import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user_model.dart';
import '../../services/user_service.dart';

// All users provider
final allUsersProvider = FutureProvider.family<List<UserModel>, Map<String, dynamic>>((ref, params) async {
  return UserService.getAllUsers(
    role: params['role'] as String?,
    isActive: params['isActive'] as bool?,
    searchQuery: params['searchQuery'] as String?,
  );
});

// Single user provider
final userProvider = FutureProvider.family<UserModel?, String>((ref, userId) async {
  return UserService.getUserById(userId);
});

// User stats provider
final userStatsProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, userId) async {
  return UserService.getUserStats(userId);
});

// Team stats provider
final teamStatsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  return UserService.getTeamStats();
});

// System stats provider
final systemStatsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  return UserService.getSystemStats();
});

// Staff users provider
final staffUsersProvider = FutureProvider<List<UserModel>>((ref) async {
  return UserService.getAllUsers(role: 'staff', isActive: true);
});

// Admin users provider
final adminUsersProvider = FutureProvider<List<UserModel>>((ref) async {
  return UserService.getAllUsers(role: 'admin', isActive: true);
});

// User actions notifier
final userActionsProvider = StateNotifierProvider<UserActionsNotifier, AsyncValue<void>>((ref) {
  return UserActionsNotifier(ref);
});

class UserActionsNotifier extends StateNotifier<AsyncValue<void>> {
  UserActionsNotifier(this.ref) : super(const AsyncValue.data(null));
  
  final Ref ref;

  Future<void> createUser(CreateUserRequest request) async {
    state = const AsyncValue.loading();
    try {
      await UserService.createUser(request);
      state = const AsyncValue.data(null);
      // Invalidate users to refresh data
      ref.invalidate(allUsersProvider);
      ref.invalidate(staffUsersProvider);
      ref.invalidate(adminUsersProvider);
      ref.invalidate(systemStatsProvider);
      ref.invalidate(teamStatsProvider);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateUser(String userId, UpdateUserRequest request) async {
    state = const AsyncValue.loading();
    try {
      await UserService.updateUser(userId, request);
      state = const AsyncValue.data(null);
      // Invalidate relevant providers
      ref.invalidate(allUsersProvider);
      ref.invalidate(userProvider(userId));
      ref.invalidate(staffUsersProvider);
      ref.invalidate(adminUsersProvider);
      ref.invalidate(teamStatsProvider);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteUser(String userId) async {
    state = const AsyncValue.loading();
    try {
      await UserService.deleteUser(userId);
      state = const AsyncValue.data(null);
      // Invalidate users to refresh data
      ref.invalidate(allUsersProvider);
      ref.invalidate(staffUsersProvider);
      ref.invalidate(adminUsersProvider);
      ref.invalidate(systemStatsProvider);
      ref.invalidate(teamStatsProvider);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> toggleUserStatus(String userId, bool isActive) async {
    state = const AsyncValue.loading();
    try {
      await UserService.toggleUserStatus(userId, isActive);
      state = const AsyncValue.data(null);
      // Invalidate relevant providers
      ref.invalidate(allUsersProvider);
      ref.invalidate(userProvider(userId));
      ref.invalidate(staffUsersProvider);
      ref.invalidate(adminUsersProvider);
      ref.invalidate(systemStatsProvider);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    state = const AsyncValue.loading();
    try {
      await UserService.sendPasswordResetEmail(email);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

// Search results provider
final userSearchProvider = StateProvider<String>((ref) => '');

final filteredUsersProvider = FutureProvider<List<UserModel>>((ref) async {
  final searchQuery = ref.watch(userSearchProvider);
  return UserService.getAllUsers(
    searchQuery: searchQuery.isEmpty ? null : searchQuery,
  );
});

// Active staff count provider
final activeStaffCountProvider = FutureProvider<int>((ref) async {
  final users = await UserService.getAllUsers(role: 'staff', isActive: true);
  return users.length;
});

// Total users count provider
final totalUsersCountProvider = FutureProvider<int>((ref) async {
  final users = await UserService.getAllUsers();
  return users.length;
}); 