import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'route_animations.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/shifts/screens/calendar_screen.dart';
import '../../features/shifts/screens/shift_details_screen.dart';
import '../../features/shifts/screens/create_shift_screen.dart';
import '../../features/time_tracking/screens/clock_in_out_screen.dart';
import '../../features/time_tracking/screens/hours_summary_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/admin/screens/admin_dashboard_screen.dart';
import '../../features/admin/screens/shift_bookings_screen.dart';
import '../../features/admin/screens/user_management_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isAuthenticated = authState.value?.session != null;
      final isLoggingIn = state.matchedLocation == '/login';
      
      if (!isAuthenticated && !isLoggingIn) {
        return '/login';
      }
      
      if (isAuthenticated && isLoggingIn) {
        return '/home';
      }
      
      return null;
    },
    routes: [
      // Authentication Routes
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => RouteAnimations.fadeTransition(
          context,
          state,
          const LoginScreen(),
        ),
      ),
      
      // Main App Routes
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => RouteAnimations.fadeTransition(
          context,
          state,
          const HomeScreen(),
        ),
      ),
      GoRoute(
        path: '/calendar',
        pageBuilder: (context, state) => RouteAnimations.slideAndFade(
          context,
          state,
          const CalendarScreen(),
        ),
      ),
      GoRoute(
        path: '/shifts/:shiftId',
        pageBuilder: (context, state) {
          final shiftId = state.pathParameters['shiftId']!;
          return RouteAnimations.slideFromRight(
            context,
            state,
            ShiftDetailsScreen(shiftId: shiftId),
          );
        },
      ),
      GoRoute(
        path: '/clock',
        pageBuilder: (context, state) => RouteAnimations.scaleTransition(
          context,
          state,
          const ClockInOutScreen(),
        ),
      ),
      GoRoute(
        path: '/hours',
        pageBuilder: (context, state) => RouteAnimations.slideAndFade(
          context,
          state,
          const HoursSummaryScreen(),
        ),
      ),
      GoRoute(
        path: '/profile',
        pageBuilder: (context, state) => RouteAnimations.slideAndFade(
          context,
          state,
          const ProfileScreen(),
        ),
      ),
      
      // Admin Routes
      GoRoute(
        path: '/admin',
        pageBuilder: (context, state) => RouteAnimations.slideAndFade(
          context,
          state,
          const AdminDashboardScreen(),
        ),
      ),
      GoRoute(
        path: '/admin/create-shift',
        pageBuilder: (context, state) => RouteAnimations.slideFromBottom(
          context,
          state,
          const CreateShiftScreen(),
        ),
      ),
      GoRoute(
        path: '/admin/edit-shift/:shiftId',
        pageBuilder: (context, state) {
          final shiftId = state.pathParameters['shiftId']!;
          return RouteAnimations.slideFromBottom(
            context,
            state,
            CreateShiftScreen(shiftId: shiftId),
          );
        },
      ),
      GoRoute(
        path: '/admin/bookings',
        pageBuilder: (context, state) => RouteAnimations.slideFromRight(
          context,
          state,
          const ShiftBookingsScreen(),
        ),
      ),
      GoRoute(
        path: '/admin/users',
        pageBuilder: (context, state) => RouteAnimations.slideFromRight(
          context,
          state,
          const UserManagementScreen(),
        ),
      ),
    ],
  );
}); 