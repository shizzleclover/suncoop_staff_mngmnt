import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/shift_model.dart';
import '../../services/shift_service.dart';

// Shifts provider
final shiftsProvider = FutureProvider.family<List<ShiftWithBookings>, Map<String, dynamic>>((ref, params) async {
  return ShiftService.getShifts(
    startDate: params['startDate'] as DateTime?,
    endDate: params['endDate'] as DateTime?,
    isActive: params['isActive'] as bool?,
  );
});

// Single shift provider
final shiftProvider = FutureProvider.family<ShiftWithBookings?, String>((ref, shiftId) async {
  return ShiftService.getShiftById(shiftId);
});

// Today's shifts provider
final todayShiftsProvider = FutureProvider<List<ShiftWithBookings>>((ref) async {
  final today = DateTime.now();
  final startOfDay = DateTime(today.year, today.month, today.day);
  final endOfDay = startOfDay.add(const Duration(days: 1));
  
  return ShiftService.getShifts(
    startDate: startOfDay,
    endDate: endOfDay,
    isActive: true,
  );
});

// This week's shifts provider
final weekShiftsProvider = FutureProvider<List<ShiftWithBookings>>((ref) async {
  final now = DateTime.now();
  final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  final endOfWeek = startOfWeek.add(const Duration(days: 7));
  
  return ShiftService.getShifts(
    startDate: startOfWeek,
    endDate: endOfWeek,
    isActive: true,
  );
});

// User bookings provider
final userBookingsProvider = FutureProvider.family<List<ShiftBookingModel>, Map<String, dynamic>>((ref, params) async {
  return ShiftService.getUserBookings(
    userId: params['userId'] as String?,
    startDate: params['startDate'] as DateTime?,
    endDate: params['endDate'] as DateTime?,
  );
});

// All bookings provider (admin)
final allBookingsProvider = FutureProvider.family<List<ShiftBookingModel>, Map<String, dynamic>>((ref, params) async {
  return ShiftService.getAllBookings(
    status: params['status'] as String?,
    startDate: params['startDate'] as DateTime?,
    endDate: params['endDate'] as DateTime?,
  );
});

// Shift actions notifier
final shiftActionsProvider = StateNotifierProvider<ShiftActionsNotifier, AsyncValue<void>>((ref) {
  return ShiftActionsNotifier(ref);
});

class ShiftActionsNotifier extends StateNotifier<AsyncValue<void>> {
  ShiftActionsNotifier(this.ref) : super(const AsyncValue.data(null));
  
  final Ref ref;

  Future<void> createShift(CreateShiftRequest request) async {
    state = const AsyncValue.loading();
    try {
      await ShiftService.createShift(request);
      state = const AsyncValue.data(null);
      // Invalidate shifts to refresh data
      ref.invalidate(shiftsProvider);
      ref.invalidate(todayShiftsProvider);
      ref.invalidate(weekShiftsProvider);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateShift(String shiftId, UpdateShiftRequest request) async {
    state = const AsyncValue.loading();
    try {
      await ShiftService.updateShift(shiftId, request);
      state = const AsyncValue.data(null);
      // Invalidate relevant providers
      ref.invalidate(shiftsProvider);
      ref.invalidate(shiftProvider(shiftId));
      ref.invalidate(todayShiftsProvider);
      ref.invalidate(weekShiftsProvider);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteShift(String shiftId) async {
    state = const AsyncValue.loading();
    try {
      await ShiftService.deleteShift(shiftId);
      state = const AsyncValue.data(null);
      // Invalidate shifts to refresh data
      ref.invalidate(shiftsProvider);
      ref.invalidate(todayShiftsProvider);
      ref.invalidate(weekShiftsProvider);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> bookShift(String shiftId) async {
    state = const AsyncValue.loading();
    try {
      await ShiftService.bookShift(shiftId);
      state = const AsyncValue.data(null);
      // Invalidate relevant providers
      ref.invalidate(shiftProvider(shiftId));
      ref.invalidate(shiftsProvider);
      ref.invalidate(userBookingsProvider);
      ref.invalidate(allBookingsProvider);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> cancelBooking(String shiftId) async {
    state = const AsyncValue.loading();
    try {
      await ShiftService.cancelBooking(shiftId);
      state = const AsyncValue.data(null);
      // Invalidate relevant providers
      ref.invalidate(shiftProvider(shiftId));
      ref.invalidate(shiftsProvider);
      ref.invalidate(userBookingsProvider);
      ref.invalidate(allBookingsProvider);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> approveBooking(String bookingId) async {
    state = const AsyncValue.loading();
    try {
      await ShiftService.approveBooking(bookingId);
      state = const AsyncValue.data(null);
      // Invalidate bookings
      ref.invalidate(allBookingsProvider);
      ref.invalidate(userBookingsProvider);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> rejectBooking(String bookingId, String? reason) async {
    state = const AsyncValue.loading();
    try {
      await ShiftService.rejectBooking(bookingId, reason);
      state = const AsyncValue.data(null);
      // Invalidate bookings
      ref.invalidate(allBookingsProvider);
      ref.invalidate(userBookingsProvider);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
} 