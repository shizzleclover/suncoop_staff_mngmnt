import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/auth_provider.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({
    super.key,
    this.showLabel = true,
    this.iconSize = 24.0,
    this.style = LogoutButtonStyle.icon,
  });

  final bool showLabel;
  final double iconSize;
  final LogoutButtonStyle style;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    switch (style) {
      case LogoutButtonStyle.icon:
        return IconButton(
          onPressed: () => _showLogoutDialog(context, ref),
          icon: Icon(
            Icons.logout_rounded,
            size: iconSize,
            color: colorScheme.error,
          ),
          tooltip: 'Logout',
        );

      case LogoutButtonStyle.outlined:
        return OutlinedButton.icon(
          onPressed: () => _showLogoutDialog(context, ref),
          icon: Icon(
            Icons.logout_rounded,
            size: iconSize,
            color: colorScheme.error,
          ),
          label: showLabel ? const Text('Logout') : const SizedBox.shrink(),
          style: OutlinedButton.styleFrom(
            foregroundColor: colorScheme.error,
            side: BorderSide(color: colorScheme.error),
          ),
        );

      case LogoutButtonStyle.filled:
        return FilledButton.icon(
          onPressed: () => _showLogoutDialog(context, ref),
          icon: Icon(
            Icons.logout_rounded,
            size: iconSize,
          ),
          label: showLabel ? const Text('Logout') : const SizedBox.shrink(),
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.error,
            foregroundColor: colorScheme.onError,
          ),
        );

      case LogoutButtonStyle.text:
        return TextButton.icon(
          onPressed: () => _showLogoutDialog(context, ref),
          icon: Icon(
            Icons.logout_rounded,
            size: iconSize,
            color: colorScheme.error,
          ),
          label: showLabel ? const Text('Logout') : const SizedBox.shrink(),
          style: TextButton.styleFrom(
            foregroundColor: colorScheme.error,
          ),
        );

      case LogoutButtonStyle.listTile:
        return ListTile(
          leading: Icon(
            Icons.logout_rounded,
            color: colorScheme.error,
            size: iconSize,
          ),
          title: showLabel ? const Text('Logout') : null,
          onTap: () => _showLogoutDialog(context, ref),
          textColor: colorScheme.error,
          iconColor: colorScheme.error,
        );
    }
  }

  Future<void> _showLogoutDialog(BuildContext context, WidgetRef ref) async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final shouldLogout = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.logout_rounded,
          color: colorScheme.error,
          size: 32,
        ),
        title: const Text('Logout'),
        content: const Text(
          'Are you sure you want to logout? You will need to sign in again to access your account.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (shouldLogout == true && context.mounted) {
      await _performLogout(context, ref);
    }
  }

  Future<void> _performLogout(BuildContext context, WidgetRef ref) async {
    try {
      // Show loading indicator
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Logging out...'),
                  ],
                ),
              ),
            ),
          ),
        );
      }

      // Perform logout
      await ref.read(authNotifierProvider.notifier).signOut();

      // Close loading dialog and navigate to login
      if (context.mounted) {
        Navigator.of(context).pop(); // Close loading dialog
        context.go('/login');
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text('Successfully logged out'),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } catch (e) {
      // Close loading dialog if it's open
      if (context.mounted) {
        Navigator.of(context).pop();
        
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('Logout failed: ${e.toString()}'),
                ),
              ],
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }
}

enum LogoutButtonStyle {
  icon,
  outlined,
  filled,
  text,
  listTile,
} 