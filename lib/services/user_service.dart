import '../models/user_model.dart';
import '../core/constants/app_constants.dart';
import 'supabase_service.dart';

class UserService {
  static Future<List<UserModel>> getAllUsers({
    String? role,
    bool? isActive,
    String? searchQuery,
  }) async {
    try {
      var query = SupabaseService.from(AppConstants.usersTable).select();

      if (role != null) {
        query = query.eq('role', role);
      }
      if (isActive != null) {
        query = query.eq('is_active', isActive);
      }
      if (searchQuery != null && searchQuery.isNotEmpty) {
        query = query.or('full_name.ilike.%$searchQuery%,email.ilike.%$searchQuery%');
      }

      final response = await query.order('created_at', ascending: false);
      
      return response.map<UserModel>((data) => UserModel.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  static Future<UserModel?> getUserById(String userId) async {
    try {
      final response = await SupabaseService.from(AppConstants.usersTable)
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (response == null) return null;
      return UserModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }

  static Future<UserModel> createUser(CreateUserRequest request) async {
    try {
      // Create auth user first
      final authResponse = await SupabaseService.client.auth.admin.createUser(
        email: request.email,
        password: request.password,
        emailConfirm: true,
        userData: {
          'full_name': request.fullName,
          'role': request.role,
        },
      );

      if (authResponse.user == null) {
        throw Exception('Failed to create auth user');
      }

      // Create user profile
      final userData = {
        'id': authResponse.user!.id,
        'email': request.email,
        'full_name': request.fullName,
        'role': request.role,
        'phone': request.phone,
        'employee_id': request.employeeId,
        'is_active': true,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      final response = await SupabaseService.from(AppConstants.usersTable)
          .insert(userData)
          .select()
          .single();

      return UserModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  static Future<UserModel> updateUser(String userId, UpdateUserRequest request) async {
    try {
      final data = <String, dynamic>{
        'updated_at': DateTime.now().toIso8601String(),
      };

      if (request.fullName != null) data['full_name'] = request.fullName;
      if (request.avatarUrl != null) data['avatar_url'] = request.avatarUrl;
      if (request.phone != null) data['phone'] = request.phone;
      if (request.employeeId != null) data['employee_id'] = request.employeeId;
      if (request.isActive != null) data['is_active'] = request.isActive;

      final response = await SupabaseService.from(AppConstants.usersTable)
          .update(data)
          .eq('id', userId)
          .select()
          .single();

      return UserModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  static Future<void> deleteUser(String userId) async {
    try {
      // First delete user profile
      await SupabaseService.from(AppConstants.usersTable)
          .delete()
          .eq('id', userId);

      // Then delete auth user
      await SupabaseService.client.auth.admin.deleteUser(userId);
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  static Future<void> toggleUserStatus(String userId, bool isActive) async {
    try {
      await SupabaseService.from(AppConstants.usersTable)
          .update({
            'is_active': isActive,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', userId);
    } catch (e) {
      throw Exception('Failed to toggle user status: $e');
    }
  }

  static Future<void> sendPasswordResetEmail(String email) async {
    try {
      await SupabaseService.client.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw Exception('Failed to send password reset email: $e');
    }
  }

  static Future<Map<String, dynamic>> getUserStats(String userId) async {
    try {
      final now = DateTime.now();
      final startOfMonth = DateTime(now.year, now.month, 1);
      final endOfMonth = DateTime(now.year, now.month + 1, 0);

      // Get shift bookings for this month
      final shiftBookings = await SupabaseService.from(AppConstants.shiftBookingsTable)
          .select('*, shifts(*)')
          .eq('user_id', userId)
          .gte('booked_at', startOfMonth.toIso8601String())
          .lte('booked_at', endOfMonth.toIso8601String());

      // Get clock records for this month
      final clockRecords = await SupabaseService.from(AppConstants.clockRecordsTable)
          .select()
          .eq('user_id', userId)
          .gte('clock_in_time', startOfMonth.toIso8601String())
          .lte('clock_in_time', endOfMonth.toIso8601String())
          .not('total_hours', 'is', null);

      final totalHours = clockRecords.fold<double>(
        0,
        (sum, record) => sum + (record['total_hours'] as num).toDouble(),
      );

      final totalShifts = shiftBookings.length;

      // Calculate earnings
      double totalEarnings = 0;
      for (final record in clockRecords) {
        final hours = (record['total_hours'] as num).toDouble();
        final hourlyRate = 15.0; // Default rate, should get from shift or user profile
        totalEarnings += hours * hourlyRate;
      }

      // Calculate attendance rate (last 3 months)
      final threeMonthsAgo = DateTime(now.year, now.month - 3, 1);
      final scheduledShifts = await SupabaseService.from(AppConstants.shiftBookingsTable)
          .select()
          .eq('user_id', userId)
          .eq('status', 'booked')
          .gte('booked_at', threeMonthsAgo.toIso8601String());

      final attendedShifts = await SupabaseService.from(AppConstants.clockRecordsTable)
          .select()
          .eq('user_id', userId)
          .gte('clock_in_time', threeMonthsAgo.toIso8601String())
          .not('total_hours', 'is', null);

      final attendanceRate = scheduledShifts.length > 0 
          ? (attendedShifts.length / scheduledShifts.length) * 100
          : 0.0;

      return {
        'totalHours': totalHours,
        'totalShifts': totalShifts,
        'totalEarnings': totalEarnings,
        'attendanceRate': attendanceRate,
      };
    } catch (e) {
      throw Exception('Failed to get user stats: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getTeamStats() async {
    try {
      final users = await getAllUsers();
      final List<Map<String, dynamic>> teamStats = [];

      for (final user in users) {
        final stats = await getUserStats(user.id);
        teamStats.add({
          'user': user,
          'stats': stats,
        });
      }

      return teamStats;
    } catch (e) {
      throw Exception('Failed to get team stats: $e');
    }
  }

  static Future<Map<String, dynamic>> getSystemStats() async {
    try {
      final now = DateTime.now();
      final startOfMonth = DateTime(now.year, now.month, 1);
      
      // Get all users
      final allUsers = await getAllUsers();
      final activeUsers = allUsers.where((u) => u.isActive).length;
      
      // Get active shifts for today
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));
      
      final activeShifts = await SupabaseService.from(AppConstants.shiftsTable)
          .select()
          .eq('is_active', true)
          .gte('start_time', startOfDay.toIso8601String())
          .lte('start_time', endOfDay.toIso8601String());

      // Get today's hours
      final todayClockRecords = await SupabaseService.from(AppConstants.clockRecordsTable)
          .select()
          .gte('clock_in_time', startOfDay.toIso8601String())
          .lte('clock_in_time', endOfDay.toIso8601String())
          .not('total_hours', 'is', null);

      final totalHoursToday = todayClockRecords.fold<double>(
        0,
        (sum, record) => sum + (record['total_hours'] as num).toDouble(),
      );

      // Get currently working staff
      final currentlyWorking = await SupabaseService.from(AppConstants.clockRecordsTable)
          .select()
          .eq('status', AppConstants.clockStatusIn)
          .is_('clock_out_time', null);

      // Calculate this month's attendance
      final monthlyShifts = await SupabaseService.from(AppConstants.shiftBookingsTable)
          .select()
          .eq('status', 'booked')
          .gte('booked_at', startOfMonth.toIso8601String());

      final monthlyAttendance = await SupabaseService.from(AppConstants.clockRecordsTable)
          .select()
          .gte('clock_in_time', startOfMonth.toIso8601String())
          .not('total_hours', 'is', null);

      final attendanceRate = monthlyShifts.length > 0
          ? (monthlyAttendance.length / monthlyShifts.length) * 100
          : 0.0;

      return {
        'totalStaff': allUsers.length,
        'activeStaff': activeUsers,
        'activeShifts': activeShifts.length,
        'hoursToday': totalHoursToday,
        'currentlyWorking': currentlyWorking.length,
        'attendanceRate': attendanceRate,
      };
    } catch (e) {
      throw Exception('Failed to get system stats: $e');
    }
  }
} 