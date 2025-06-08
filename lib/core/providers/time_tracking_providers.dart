import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/clock_record_model.dart';
import '../../services/time_tracking_service.dart';

// Current clock record provider
final currentClockRecordProvider = FutureProvider<ClockRecordModel?>((ref) async {
  return TimeTrackingService.getCurrentClockRecord();
});

// Clock records provider
final clockRecordsProvider = FutureProvider.family<List<ClockRecordModel>, Map<String, dynamic>>((ref, params) async {
  return TimeTrackingService.getClockRecords(
    userId: params['userId'] as String?,
    startDate: params['startDate'] as DateTime?,
    endDate: params['endDate'] as DateTime?,
    limit: params['limit'] as int?,
  );
});

// Work summary provider
final workSummaryProvider = FutureProvider.family<WorkSummary, Map<String, DateTime>>((ref, params) async {
  return TimeTrackingService.getWorkSummary(
    userId: params['userId'] as String?,
    startDate: params['startDate']!,
    endDate: params['endDate']!,
  );
});

// Today's stats provider
final todayStatsProvider = FutureProvider<Map<String, double>>((ref) async {
  return TimeTrackingService.getTodayStats();
});

// Team clock records provider (admin)
final teamClockRecordsProvider = FutureProvider.family<List<ClockRecordModel>, Map<String, dynamic>>((ref, params) async {
  return TimeTrackingService.getTeamClockRecords(
    startDate: params['startDate'] as DateTime?,
    endDate: params['endDate'] as DateTime?,
    status: params['status'] as String?,
  );
});

// Currently working staff provider (admin)
final currentlyWorkingStaffProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  return TimeTrackingService.getCurrentlyWorkingStaff();
});

// Time tracking actions notifier
final timeTrackingActionsProvider = StateNotifierProvider<TimeTrackingActionsNotifier, AsyncValue<void>>((ref) {
  return TimeTrackingActionsNotifier(ref);
});

class TimeTrackingActionsNotifier extends StateNotifier<AsyncValue<void>> {
  TimeTrackingActionsNotifier(this.ref) : super(const AsyncValue.data(null));
  
  final Ref ref;

  Future<void> clockIn(ClockInRequest request) async {
    state = const AsyncValue.loading();
    try {
      await TimeTrackingService.clockIn(request);
      state = const AsyncValue.data(null);
      // Invalidate relevant providers
      ref.invalidate(currentClockRecordProvider);
      ref.invalidate(clockRecordsProvider);
      ref.invalidate(todayStatsProvider);
      ref.invalidate(currentlyWorkingStaffProvider);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> clockOut(ClockOutRequest request) async {
    state = const AsyncValue.loading();
    try {
      await TimeTrackingService.clockOut(request);
      state = const AsyncValue.data(null);
      // Invalidate relevant providers
      ref.invalidate(currentClockRecordProvider);
      ref.invalidate(clockRecordsProvider);
      ref.invalidate(todayStatsProvider);
      ref.invalidate(currentlyWorkingStaffProvider);
      ref.invalidate(workSummaryProvider);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> adminAdjustClockRecord({
    required String recordId,
    DateTime? clockInTime,
    DateTime? clockOutTime,
    int? breakTimeMinutes,
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    try {
      await TimeTrackingService.adminAdjustClockRecord(
        recordId: recordId,
        clockInTime: clockInTime,
        clockOutTime: clockOutTime,
        breakTimeMinutes: breakTimeMinutes,
        notes: notes,
      );
      state = const AsyncValue.data(null);
      // Invalidate relevant providers
      ref.invalidate(clockRecordsProvider);
      ref.invalidate(teamClockRecordsProvider);
      ref.invalidate(workSummaryProvider);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> markRecordInvalid(String recordId, String reason) async {
    state = const AsyncValue.loading();
    try {
      await TimeTrackingService.markRecordInvalid(recordId, reason);
      state = const AsyncValue.data(null);
      // Invalidate relevant providers
      ref.invalidate(clockRecordsProvider);
      ref.invalidate(teamClockRecordsProvider);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

// Is clocked in provider
final isClockedInProvider = Provider<bool>((ref) {
  final currentRecord = ref.watch(currentClockRecordProvider);
  return currentRecord.when(
    data: (record) => record?.clockOutTime == null,
    loading: () => false,
    error: (_, __) => false,
  );
});

// Current session hours provider
final currentSessionHoursProvider = Provider<double>((ref) {
  final currentRecord = ref.watch(currentClockRecordProvider);
  return currentRecord.when(
    data: (record) {
      if (record?.clockOutTime == null && record?.clockInTime != null) {
        return DateTime.now().difference(record!.clockInTime).inMinutes / 60.0;
      }
      return 0.0;
    },
    loading: () => 0.0,
    error: (_, __) => 0.0,
  );
});

// This week's work summary provider
final thisWeekSummaryProvider = FutureProvider<WorkSummary>((ref) async {
  final now = DateTime.now();
  final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  final endOfWeek = startOfWeek.add(const Duration(days: 7));
  
  return TimeTrackingService.getWorkSummary(
    startDate: startOfWeek,
    endDate: endOfWeek,
  );
});

// This month's work summary provider
final thisMonthSummaryProvider = FutureProvider<WorkSummary>((ref) async {
  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);
  final endOfMonth = DateTime(now.year, now.month + 1, 0);
  
  return TimeTrackingService.getWorkSummary(
    startDate: startOfMonth,
    endDate: endOfMonth,
  );
}); 