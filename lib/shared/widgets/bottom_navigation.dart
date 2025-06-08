import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/auth_provider.dart';
import 'logout_button.dart';

class AppBottomNavigation extends ConsumerWidget {
  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isAdminProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildNavigationItems(context, isAdmin, colorScheme),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNavigationItems(
    BuildContext context,
    bool isAdmin,
    ColorScheme colorScheme,
  ) {
    final items = _getNavigationItems(isAdmin);
    final List<Widget> widgets = [];

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final isSelected = i == currentIndex;
      
      widgets.add(
        Expanded(
          child: _NavigationItem(
            icon: item.icon,
            label: item.label!,
            isSelected: isSelected,
            onTap: () => _onTap(context, i, isAdmin),
            colorScheme: colorScheme,
          ),
        ),
      );
    }

    // Add logout button for admins
    if (isAdmin) {
      widgets.add(
        _NavigationItem(
          icon: const Icon(Icons.logout_rounded),
          label: 'Logout',
          isSelected: false,
          onTap: () => _showLogoutDialog(context),
          colorScheme: colorScheme,
          isLogout: true,
        ),
      );
    }

    return widgets;
  }

  List<BottomNavigationBarItem> _getNavigationItems(bool isAdmin) {
    if (isAdmin) {
      return const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_rounded),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_rounded),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.admin_panel_settings_rounded),
          label: 'Admin',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ];
    } else {
      return const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_rounded),
          label: 'Shifts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.access_time_rounded),
          label: 'Clock',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ];
    }
  }

  void _onTap(BuildContext context, int index, bool isAdmin) {
    if (isAdmin) {
      switch (index) {
        case 0:
          context.go('/home');
          break;
        case 1:
          context.go('/calendar');
          break;
        case 2:
          context.go('/admin');
          break;
        case 3:
          context.go('/profile');
          break;
      }
    } else {
      switch (index) {
        case 0:
          context.go('/home');
          break;
        case 1:
          context.go('/calendar');
          break;
        case 2:
          context.go('/clock');
          break;
        case 3:
          context.go('/profile');
          break;
      }
    }
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.logout_rounded,
          color: Theme.of(context).colorScheme.error,
          size: 32,
        ),
        title: const Text('Logout'),
        content: const Text(
          'Are you sure you want to logout? You will need to sign in again to access your account.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          const LogoutButton(
            style: LogoutButtonStyle.filled,
            showLabel: true,
          ),
        ],
      ),
    );
  }

  static int getIndexForRoute(String route, bool isAdmin) {
    if (isAdmin) {
      switch (route) {
        case '/home':
          return 0;
        case '/calendar':
          return 1;
        case '/admin':
        case '/admin/create-shift':
        case '/admin/bookings':
        case '/admin/users':
          return 2;
        case '/profile':
          return 3;
        default:
          return 0;
      }
    } else {
      switch (route) {
        case '/home':
          return 0;
        case '/calendar':
          return 1;
        case '/clock':
          return 2;
        case '/profile':
          return 3;
        default:
          return 0;
      }
    }
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.colorScheme,
    this.isLogout = false,
  });

  final Widget icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;
  final bool isLogout;

  @override
  Widget build(BuildContext context) {
    final color = isLogout
        ? colorScheme.error
        : isSelected
            ? colorScheme.primary
            : colorScheme.onSurface.withOpacity(0.6);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected && !isLogout
                    ? colorScheme.primaryContainer.withOpacity(0.3)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconTheme(
                data: IconThemeData(
                  color: color,
                  size: 24,
                ),
                child: icon,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected && !isLogout ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 