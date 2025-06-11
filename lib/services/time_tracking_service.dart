import '../models/clock_record_model.dart';
import '../core/constants/app_constants.dart';
import 'supabase_service.dart';

class TimeTrackingService {
  static Future<ClockRecordModel> clockIn(ClockInRequest request) async {
    try {
      // Check if user is already clocked in
      final existingRecord = await getCurrentClockRecord();
      if (existingRecord != null && existingRecord.clockOutTime == null) {
        throw Exception('You are already clocked in');
      }

      final data = {
        'user_id': SupabaseService.currentUserId!,
        'shift_booking_id': request.shiftBookingId,
        'clock_in_time': DateTime.now().toIso8601String(),
        'clock_in_wifi_ssid': request.wifiSsid,
        'clock_in_wifi_bssid': request.wifiBssid,
        'clock_in_latitude': request.latitude,
        'clock_in_longitude': request.longitude,
        'clock_in_device_info': request.deviceInfo,
        'status': AppConstants.clockStatusIn,
        'is_valid': true,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      final response = await SupabaseService.from(AppConstants.clockRecordsTable)
          .insert(data)
          .select()
          .single();

      return ClockRecordModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to clock in: $e');
    }
  }

  static Future<ClockRecordModel> clockOut(ClockOutRequest request) async {
    try {
      final currentRecord = await getCurrentClockRecord();
      if (currentRecord == null || currentRecord.clockOutTime != null) {
        throw Exception('No active clock-in record found');
      }

      final clockOutTime = DateTime.now();
      final clockInTime = currentRecord.clockInTime;
      final totalHours = clockOutTime.difference(clockInTime).inMinutes / 60.0;
      
      final breakTimeMinutes = request.breakTimeMinutes ?? 0;
      final adjustedHours = totalHours - (breakTimeMinutes / 60.0);
      final overtimeHours = adjustedHours > 8 ? adjustedHours - 8 : 0;

      final data = {
        'clock_out_time': clockOutTime.toIso8601String(),
        'clock_out_wifi_ssid': request.wifiSsid,
        'clock_out_wifi_bssid': request.wifiBssid,
        'clock_out_latitude': request.latitude,
        'clock_out_longitude': request.longitude,
        'clock_out_device_info': request.deviceInfo,
        'total_hours': adjustedHours,
        'break_time_minutes': breakTimeMinutes,
        'overtime_hours': overtimeHours,
        'status': AppConstants.clockStatusOut,
        'updated_at': DateTime.now().toIso8601String(),
      };

      final response = await SupabaseService.from(AppConstants.clockRecordsTable)
          .update(data)
          .eq('id', request.clockRecordId)
          .select()
          .single();

      return ClockRecordModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to clock out: $e');
    }
  }

  static Future<ClockRecordModel?> getCurrentClockRecord() async {
    try {
      final response = await SupabaseService.from(AppConstants.clockRecordsTable)
          .select()
          .eq('user_id', SupabaseService.currentUserId!)
          .isFilter('clock_out_time', null)
          .order('clock_in_time', ascending: false)
          .limit(1)
          .maybeSingle();

      if (response == null) return null;
      return ClockRecordModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get current clock record: $e');
    }
  }

  static Future<List<ClockRecordModel>> getClockRecords({
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  }) async {
    try {
      final targetUserId = userId ?? SupabaseService.currentUserId!;
      
      var query = SupabaseService.from(AppConstants.clockRecordsTable)
          .select('''
            *,
            shift_bookings (
              *,
              shifts (
                *
              )
            )
          ''')
          .eq('user_id', targetUserId);

      if (startDate != null) {
        query = query.gte('clock_in_time', startDate.toIso8601String());
      }
      if (endDate != null) {
        query = query.lte('clock_in_time', endDate.toIso8601String());
      }

      var orderedQuery = query.order('clock_in_time', ascending: false);
      
      if (limit != null) {
        orderedQuery = orderedQuery.limit(limit);
      }

      final response = await orderedQuery;
      
      return response.map<ClockRecordModel>((data) => ClockRecordModel.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Failed to fetch clock records: $e');
    }
  }

  static Future<WorkSummary> getWorkSummary({
    String? userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final targetUserId = userId ?? SupabaseService.currentUserId!;
      
      final records = await getClockRecords(
        userId: targetUserId,
        startDate: startDate,
        endDate: endDate,
      );

      final totalHours = records
          .where((r) => r.totalHours != null)
          .fold<double>(0, (sum, r) => sum + r.totalHours!);
      
      final overtimeHours = records
          .where((r) => r.overtimeHours != null)
          .fold<double>(0, (sum, r) => sum + r.overtimeHours);

      return WorkSummary(
        userId: targetUserId,
        startDate: startDate,
        endDate: endDate,
        totalHours: totalHours,
        overtimeHours: overtimeHours,
        totalSessions: records.length,
        records: records,
      );
    } catch (e) {
      throw Exception('Failed to get work summary: $e');
    }
  }

  static Future<Map<String, double>> getTodayStats() async {
    try {
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final records = await getClockRecords(
        startDate: startOfDay,
        endDate: endOfDay,
      );

      final currentRecord = await getCurrentClockRecord();
      double hoursWorkedToday = 0;
      
      // Calculate completed hours
      for (final record in records) {
        if (record.totalHours != null) {
          hoursWorkedToday += record.totalHours!;
        }
      }

      // Add current session hours if clocked in
      if (currentRecord != null && currentRecord.clockOutTime == null) {
        final currentHours = DateTime.now().difference(currentRecord.clockInTime).inMinutes / 60.0;
        hoursWorkedToday += currentHours;
      }

      return {
        'hoursWorkedToday': hoursWorkedToday,
        'totalSessions': records.length.toDouble(),
        'isClockedIn': currentRecord?.clockOutTime == null ? 1.0 : 0.0,
      };
    } catch (e) {
      throw Exception('Failed to get today stats: $e');
    }
  }

  static Future<List<ClockRecordModel>> getTeamClockRecords({
    DateTime? startDate,
    DateTime? endDate,
    String? status,
  }) async {
    try {
      var query = SupabaseService.from(AppConstants.clockRecordsTable)
          .select('''
            *,
            users (
              id,
              full_name,
              email,
              avatar_url
            ),
            shift_bookings (
              *,
              shifts (
                *
              )
            )
          ''');

      if (startDate != null) {
        query = query.gte('clock_in_time', startDate.toIso8601String());
      }
      if (endDate != null) {
        query = query.lte('clock_in_time', endDate.toIso8601String());
      }
      if (status != null) {
        query = query.eq('status', status);
      }

      final response = await query.order('clock_in_time', ascending: false);
      
      return response.map<ClockRecordModel>((data) => ClockRecordModel.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Failed to fetch team clock records: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getCurrentlyWorkingStaff() async {
    try {
      final response = await SupabaseService.from(AppConstants.clockRecordsTable)
          .select('''
            *,
            users (
              id,
              full_name,
              email,
              avatar_url
            ),
            shift_bookings (
              *,
              shifts (
                title,
                location
              )
            )
          ''')
          .eq('status', AppConstants.clockStatusIn)
          .isFilter('clock_out_time', null);

      return response.map((data) {
        final record = ClockRecordModel.fromJson(data);
        final user = data['users'];
        final shiftInfo = data['shift_bookings']?['shifts'];
        
        return {
          'record': record,
          'user': user,
          'shiftTitle': shiftInfo?['title'] ?? 'Unknown Shift',
          'location': shiftInfo?['location'] ?? 'Unknown Location',
          'hoursWorked': DateTime.now().difference(record.clockInTime).inMinutes / 60.0,
        };
      }).toList();
    } catch (e) {
      throw Exception('Failed to get currently working staff: $e');
    }
  }

  static Future<void> adminAdjustClockRecord({
    required String recordId,
    DateTime? clockInTime,
    DateTime? clockOutTime,
    int? breakTimeMinutes,
    String? notes,
  }) async {
    try {
      final data = <String, dynamic>{
        'admin_adjusted': true,
        'adjusted_by': SupabaseService.currentUserId!,
        'updated_at': DateTime.now().toIso8601String(),
      };

      if (clockInTime != null) {
        data['clock_in_time'] = clockInTime.toIso8601String();
      }
      if (clockOutTime != null) {
        data['clock_out_time'] = clockOutTime.toIso8601String();
      }
      if (breakTimeMinutes != null) {
        data['break_time_minutes'] = breakTimeMinutes;
      }
      if (notes != null) {
        data['admin_notes'] = notes;
      }

      // Recalculate total hours if both times are provided
      if (clockInTime != null && clockOutTime != null) {
        final totalMinutes = clockOutTime.difference(clockInTime).inMinutes;
        final breakMinutes = breakTimeMinutes ?? 0;
        final adjustedHours = (totalMinutes - breakMinutes) / 60.0;
        final overtimeHours = adjustedHours > 8 ? adjustedHours - 8 : 0;
        
        data['total_hours'] = adjustedHours;
        data['overtime_hours'] = overtimeHours;
      }

      await SupabaseService.from(AppConstants.clockRecordsTable)
          .update(data)
          .eq('id', recordId);
    } catch (e) {
      throw Exception('Failed to adjust clock record: $e');
    }
  }

  static Future<void> markRecordInvalid(String recordId, String reason) async {
    try {
      await SupabaseService.from(AppConstants.clockRecordsTable)
          .update({
            'is_valid': false,
            'validation_notes': reason,
            'status': AppConstants.clockStatusInvalid,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', recordId);
    } catch (e) {
      throw Exception('Failed to mark record as invalid: $e');
    }
  }
} 