import '../models/shift_model.dart';
import '../core/constants/app_constants.dart';
import 'supabase_service.dart';

class ShiftService {
  static Future<List<ShiftWithBookings>> getShifts({
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
  }) async {
    try {
      var query = SupabaseService.from(AppConstants.shiftsTable)
          .select('''
            *,
            shift_bookings (
              *,
              users (
                id,
                full_name,
                email,
                avatar_url
              )
            )
          ''');

      if (startDate != null) {
        query = query.gte('start_time', startDate.toIso8601String());
      }
      if (endDate != null) {
        query = query.lte('start_time', endDate.toIso8601String());
      }
      if (isActive != null) {
        query = query.eq('is_active', isActive);
      }

      final response = await query.order('start_time');
      
      return response.map<ShiftWithBookings>((data) {
        final shift = ShiftModel.fromJson(data);
        final bookings = (data['shift_bookings'] as List? ?? [])
            .map((booking) => ShiftBookingModel.fromJson(booking))
            .toList();
        
        final availableSpots = shift.maxStaff - bookings.where((b) => b.status == 'booked').length;
        
        return ShiftWithBookings(
          shift: shift,
          bookings: bookings,
          availableSpots: availableSpots,
          isAvailable: availableSpots > 0,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch shifts: $e');
    }
  }

  static Future<ShiftWithBookings?> getShiftById(String shiftId) async {
    try {
      final response = await SupabaseService.from(AppConstants.shiftsTable)
          .select('''
            *,
            shift_bookings (
              *,
              users (
                id,
                full_name,
                email,
                avatar_url
              )
            )
          ''')
          .eq('id', shiftId)
          .single();

      final shift = ShiftModel.fromJson(response);
      final bookings = (response['shift_bookings'] as List? ?? [])
          .map((booking) => ShiftBookingModel.fromJson(booking))
          .toList();
      
      final availableSpots = shift.maxStaff - bookings.where((b) => b.status == 'booked').length;
      
      return ShiftWithBookings(
        shift: shift,
        bookings: bookings,
        availableSpots: availableSpots,
        isAvailable: availableSpots > 0,
      );
    } catch (e) {
      throw Exception('Failed to fetch shift: $e');
    }
  }

  static Future<ShiftModel> createShift(CreateShiftRequest request) async {
    try {
      final data = {
        'title': request.title,
        'description': request.description,
        'start_time': request.startTime.toIso8601String(),
        'end_time': request.endTime.toIso8601String(),
        'location': request.location,
        'max_staff': request.maxStaff,
        'hourly_rate': request.hourlyRate,
        'created_by': SupabaseService.currentUserId!,
        'is_active': true,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      final response = await SupabaseService.from(AppConstants.shiftsTable)
          .insert(data)
          .select()
          .single();

      return ShiftModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create shift: $e');
    }
  }

  static Future<ShiftModel> updateShift(String shiftId, UpdateShiftRequest request) async {
    try {
      final data = <String, dynamic>{
        'updated_at': DateTime.now().toIso8601String(),
      };

      if (request.title != null) data['title'] = request.title;
      if (request.description != null) data['description'] = request.description;
      if (request.startTime != null) data['start_time'] = request.startTime!.toIso8601String();
      if (request.endTime != null) data['end_time'] = request.endTime!.toIso8601String();
      if (request.location != null) data['location'] = request.location;
      if (request.maxStaff != null) data['max_staff'] = request.maxStaff;
      if (request.hourlyRate != null) data['hourly_rate'] = request.hourlyRate;
      if (request.isActive != null) data['is_active'] = request.isActive;

      final response = await SupabaseService.from(AppConstants.shiftsTable)
          .update(data)
          .eq('id', shiftId)
          .select()
          .single();

      return ShiftModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update shift: $e');
    }
  }

  static Future<void> deleteShift(String shiftId) async {
    try {
      await SupabaseService.from(AppConstants.shiftsTable)
          .delete()
          .eq('id', shiftId);
    } catch (e) {
      throw Exception('Failed to delete shift: $e');
    }
  }

  static Future<ShiftBookingModel> bookShift(String shiftId) async {
    try {
      // Check if shift is available
      final shift = await getShiftById(shiftId);
      if (shift == null || !shift.isAvailable) {
        throw Exception('Shift is not available');
      }

      // Check if user already booked this shift
      final existingBooking = await SupabaseService.from(AppConstants.shiftBookingsTable)
          .select()
          .eq('shift_id', shiftId)
          .eq('user_id', SupabaseService.currentUserId!)
          .eq('status', 'booked')
          .maybeSingle();

      if (existingBooking != null) {
        throw Exception('You have already booked this shift');
      }

      final data = {
        'shift_id': shiftId,
        'user_id': SupabaseService.currentUserId!,
        'status': 'booked',
        'booked_at': DateTime.now().toIso8601String(),
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      final response = await SupabaseService.from(AppConstants.shiftBookingsTable)
          .insert(data)
          .select()
          .single();

      return ShiftBookingModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to book shift: $e');
    }
  }

  static Future<void> cancelBooking(String shiftId) async {
    try {
      await SupabaseService.from(AppConstants.shiftBookingsTable)
          .update({
            'status': 'cancelled',
            'cancelled_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('shift_id', shiftId)
          .eq('user_id', SupabaseService.currentUserId!)
          .eq('status', 'booked');
    } catch (e) {
      throw Exception('Failed to cancel booking: $e');
    }
  }

  static Future<List<ShiftBookingModel>> getUserBookings({
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final targetUserId = userId ?? SupabaseService.currentUserId!;
      
      var query = SupabaseService.from(AppConstants.shiftBookingsTable)
          .select('''
            *,
            shifts (
              *
            ),
            users (
              id,
              full_name,
              email,
              avatar_url
            )
          ''')
          .eq('user_id', targetUserId);

      if (startDate != null) {
        query = query.gte('booked_at', startDate.toIso8601String());
      }
      if (endDate != null) {
        query = query.lte('booked_at', endDate.toIso8601String());
      }

      final response = await query.order('booked_at', ascending: false);
      
      return response.map<ShiftBookingModel>((data) => ShiftBookingModel.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Failed to fetch user bookings: $e');
    }
  }

  static Future<List<ShiftBookingModel>> getAllBookings({
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      var query = SupabaseService.from(AppConstants.shiftBookingsTable)
          .select('''
            *,
            shifts (
              *
            ),
            users (
              id,
              full_name,
              email,
              avatar_url
            )
          ''');

      if (status != null) {
        query = query.eq('status', status);
      }
      if (startDate != null) {
        query = query.gte('booked_at', startDate.toIso8601String());
      }
      if (endDate != null) {
        query = query.lte('booked_at', endDate.toIso8601String());
      }

      final response = await query.order('booked_at', ascending: false);
      
      return response.map<ShiftBookingModel>((data) => ShiftBookingModel.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Failed to fetch bookings: $e');
    }
  }

  static Future<void> approveBooking(String bookingId) async {
    try {
      await SupabaseService.from(AppConstants.shiftBookingsTable)
          .update({
            'status': 'confirmed',
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', bookingId);
    } catch (e) {
      throw Exception('Failed to approve booking: $e');
    }
  }

  static Future<void> rejectBooking(String bookingId, String? reason) async {
    try {
      final data = {
        'status': 'rejected',
        'updated_at': DateTime.now().toIso8601String(),
      };
      
      if (reason != null) {
        data['notes'] = reason;
      }

      await SupabaseService.from(AppConstants.shiftBookingsTable)
          .update(data)
          .eq('id', bookingId);
    } catch (e) {
      throw Exception('Failed to reject booking: $e');
    }
  }
} 