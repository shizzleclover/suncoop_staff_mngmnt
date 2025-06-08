import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../services/supabase_service.dart';
import '../../models/user_model.dart';
import '../../core/constants/app_constants.dart';

// Auth state provider
final authStateProvider = StreamProvider<AuthState>((ref) {
  return SupabaseService.authStateChanges;
});

// Current user provider
final currentUserProvider = StreamProvider<UserModel?>((ref) async* {
  await for (final authState in ref.watch(authStateProvider.stream)) {
    if (authState.session?.user != null) {
      try {
        final userId = authState.session!.user.id;
        final response = await SupabaseService.from(AppConstants.usersTable)
            .select()
            .eq('id', userId)
            .single();
        
        // Debug: Print the response to see what we're getting
        print('User data from database: $response');
        
        // Map the database fields to match our model
        final mappedData = {
          'id': response['id'],
          'email': response['email'],
          'fullName': response['full_name'] ?? response['fullName'] ?? '', // Handle both snake_case and camelCase
          'avatarUrl': response['avatar_url'] ?? response['avatarUrl'],
          'role': response['role'] ?? 'staff',
          'phone': response['phone'],
          'employeeId': response['employee_id'] ?? response['employeeId'],
          'isActive': response['is_active'] ?? response['isActive'] ?? true,
          'createdAt': DateTime.parse(response['created_at'] ?? response['createdAt'] ?? DateTime.now().toIso8601String()),
          'updatedAt': DateTime.parse(response['updated_at'] ?? response['updatedAt'] ?? DateTime.now().toIso8601String()),
        };
        
        print('Mapped user data: $mappedData');
        yield UserModel.fromJson(mappedData);
      } catch (e, stackTrace) {
        print('Error loading user: $e');
        print('Stack trace: $stackTrace');
        yield null;
      }
    } else {
      yield null;
    }
  }
});

// User role provider
final userRoleProvider = Provider<String?>((ref) {
  final user = ref.watch(currentUserProvider).value;
  return user?.role;
});

// Is admin provider
final isAdminProvider = Provider<bool>((ref) {
  final role = ref.watch(userRoleProvider);
  return role == AppConstants.adminRole;
});

// Auth notifier for actions
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AsyncValue<void>>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AsyncValue<void>> {
  AuthNotifier() : super(const AsyncValue.data(null));

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await SupabaseService.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> signUpWithEmail(String email, String password, String fullName) async {
    state = const AsyncValue.loading();
    try {
      final response = await SupabaseService.client.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );
      
      if (response.user != null) {
        // User profile will be created automatically via database trigger
        state = const AsyncValue.data(null);
      } else {
        throw Exception('Failed to create user account');
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      await SupabaseService.signOut();
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> resetPassword(String email) async {
    state = const AsyncValue.loading();
    try {
      await SupabaseService.client.auth.resetPasswordForEmail(email);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
} 