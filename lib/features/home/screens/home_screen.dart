import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/providers/shift_providers.dart';
import '../../../core/providers/time_tracking_providers.dart';
import '../../../shared/widgets/bottom_navigation.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/app_sidebar.dart';
import '../../../shared/widgets/enhanced_app_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final isAdmin = ref.watch(isAdminProvider);
    
    return Scaffold(
      appBar: EnhancedAppBar(
        title: 'Dashboard',
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
        ],
      ),
      drawer: const AppSidebar(),
      body: userAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('User not found'));
          }
          
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(currentUserProvider);
              ref.invalidate(userBookingsProvider);
              ref.invalidate(thisWeekSummaryProvider);
              ref.invalidate(todayStatsProvider);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Card
                  _WelcomeCard(user: user),
                  const SizedBox(height: 16),
                  
                  // Quick Actions
                  if (isAdmin) ...[
                    _AdminQuickActions(),
                    const SizedBox(height: 16),
                    _AdminStatsCards(),
                  ] else ...[
                    _StaffQuickActions(),
                    const SizedBox(height: 16),
                    _UserShiftsSection(),
                    const SizedBox(height: 16),
                    _UserWorkSummary(),
                  ],
                  
                  const SizedBox(height: 16),
                  
                  // Recent Activity for staff only
                  if (!isAdmin) _UserRecentActivity(),
                ],
              ),
            ),
          );
        },
        loading: () => const LoadingWidget(message: 'Loading dashboard...'),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error loading dashboard: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(currentUserProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: AppBottomNavigation.getIndexForRoute('/home', isAdmin),
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard({required this.user});
  
  final user;

  @override
  Widget build(BuildContext context) {
    final timeOfDay = DateTime.now().hour;
    String greeting = 'Good morning';
    if (timeOfDay >= 12 && timeOfDay < 17) {
      greeting = 'Good afternoon';
    } else if (timeOfDay >= 17) {
      greeting = 'Good evening';
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: user.avatarUrl != null
                  ? ClipOval(
                      child: Image.network(
                        user.avatarUrl!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Text(
                      user.fullName.substring(0, 1).toUpperCase(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$greeting, ${user.fullName.split(' ').first}!',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.role == 'admin' ? 'Administrator' : 'Staff Member',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Today is ${DateTime.now().toString().split(' ')[0]}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminQuickActions extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                icon: Icons.add_circle_outline,
                title: 'Create Shift',
                subtitle: 'Add new shift',
                onTap: () => context.go('/admin/create-shift'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionCard(
                icon: Icons.people_outline,
                title: 'Manage Users',
                subtitle: 'View staff',
                onTap: () => context.go('/admin/users'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StaffQuickActions extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                icon: Icons.schedule,
                title: 'View Shifts',
                subtitle: 'Available shifts',
                onTap: () => context.go('/calendar'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionCard(
                icon: Icons.access_time,
                title: 'Clock In/Out',
                subtitle: 'Track time',
                onTap: () => context.go('/clock'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                icon: Icons.schedule_rounded,
                title: 'Hours Summary',
                subtitle: 'View timesheet',
                onTap: () => context.go('/hours'),
              ),
            ),
            const SizedBox(width: 12),
            // Empty space to balance the layout
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                icon,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AdminStatsCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Overview',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Active Shifts',
                value: '8',
                icon: Icons.work_outline,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                title: 'Staff On Duty',
                value: '12',
                icon: Icons.people_outline,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// New User Shifts Section
class _UserShiftsSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7));
    
    final userBookingsAsync = ref.watch(userBookingsProvider({
      'startDate': startOfWeek,
      'endDate': endOfWeek,
    }));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Selected Shifts',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        userBookingsAsync.when(
          data: (bookings) {
            if (bookings.isEmpty) {
              return _NoDataCard(
                icon: Icons.schedule_outlined,
                title: 'No Shifts Selected',
                subtitle: 'You haven\'t selected any shifts yet. Browse available shifts to get started.',
                actionText: 'View Available Shifts',
                onActionTap: () => context.go('/calendar'),
              );
            }
            
            return Column(
              children: bookings.take(3).map((booking) {
                // Note: In real implementation, you'd get shift details from booking.shift
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getStatusColor(booking.status).withOpacity(0.1),
                      child: Icon(
                        _getStatusIcon(booking.status),
                        color: _getStatusColor(booking.status),
                      ),
                    ),
                    title: Text(
                      'Shift - ${_formatDate(booking.bookedAt)}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      'Status: ${booking.status.toUpperCase()}',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.go('/calendar'),
                  ),
                );
              }).toList(),
            );
          },
          loading: () => const Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 12),
                    Text('Loading your shifts...'),
                  ],
                ),
              ),
            ),
          ),
          error: (error, stack) => _ErrorCard(
            message: 'Failed to load shifts',
            onRetry: () => ref.invalidate(userBookingsProvider),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'booked':
        return Colors.blue;
      case 'confirmed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'booked':
        return Icons.schedule;
      case 'confirmed':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }
}

// New User Work Summary Section
class _UserWorkSummary extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thisWeekSummaryAsync = ref.watch(thisWeekSummaryProvider);
    final todayStatsAsync = ref.watch(todayStatsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Work Summary',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: thisWeekSummaryAsync.when(
                data: (summary) => _StatCard(
                  title: 'This Week',
                  value: '${summary.totalHours.toStringAsFixed(1)}h',
                  icon: Icons.access_time,
                  color: Colors.orange,
                ),
                loading: () => _LoadingStatCard(
                  title: 'This Week',
                  icon: Icons.access_time,
                  color: Colors.orange,
                ),
                error: (error, stack) => _StatCard(
                  title: 'This Week',
                  value: 'Error',
                  icon: Icons.error_outline,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: todayStatsAsync.when(
                data: (stats) => _StatCard(
                  title: 'Today',
                  value: '${stats['hoursWorkedToday']?.toStringAsFixed(1) ?? '0.0'}h',
                  icon: Icons.today,
                  color: Colors.green,
                ),
                loading: () => _LoadingStatCard(
                  title: 'Today',
                  icon: Icons.today,
                  color: Colors.green,
                ),
                error: (error, stack) => _StatCard(
                  title: 'Today',
                  value: 'Error',
                  icon: Icons.error_outline,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        thisWeekSummaryAsync.when(
          data: (summary) {
            if (summary.totalHours == 0) {
              return _NoDataCard(
                icon: Icons.access_time_outlined,
                title: 'No Work Hours Yet',
                subtitle: 'You haven\'t clocked any hours this week. Start by clocking in to track your work time.',
                actionText: 'Clock In Now',
                onActionTap: () => context.go('/clock'),
              );
            }
            return const SizedBox.shrink();
          },
          loading: () => const SizedBox.shrink(),
          error: (error, stack) => const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingStatCard extends StatelessWidget {
  const _LoadingStatCard({
    required this.title,
    required this.icon,
    required this.color,
  });

  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 12),
            const SizedBox(
              width: 40,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoDataCard extends StatelessWidget {
  const _NoDataCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.actionText,
    required this.onActionTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String actionText;
  final VoidCallback onActionTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              icon,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onActionTap,
              icon: const Icon(Icons.arrow_forward),
              label: Text(actionText),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserRecentActivity extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clockRecordsAsync = ref.watch(clockRecordsProvider({
      'limit': 5,
    }));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        clockRecordsAsync.when(
          data: (records) {
            if (records.isEmpty) {
              return _NoDataCard(
                icon: Icons.history_outlined,
                title: 'No Activity Yet',
                subtitle: 'Your recent clock in/out activities will appear here.',
                actionText: 'Start Working',
                onActionTap: () => context.go('/clock'),
              );
            }
            
            return Card(
              child: Column(
                children: records.map((record) {
                  return _ActivityItem(
                    icon: record.clockOutTime != null ? Icons.check_circle : Icons.access_time,
                    title: record.clockOutTime != null ? 'Clocked out' : 'Clocked in',
                    subtitle: record.clockOutTime != null 
                        ? 'Worked ${record.totalHours?.toStringAsFixed(1) ?? '0.0'} hours'
                        : 'Currently working',
                    time: _formatTime(record.clockInTime),
                    color: record.clockOutTime != null ? Colors.green : Colors.orange,
                  );
                }).toList(),
              ),
            );
          },
          loading: () => const Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 12),
                    Text('Loading recent activity...'),
                  ],
                ),
              ),
            ),
          ),
          error: (error, stack) => _ErrorCard(
            message: 'Failed to load recent activity',
            onRetry: () => ref.invalidate(clockRecordsProvider),
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}

class _ActivityItem extends StatelessWidget {
  const _ActivityItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(
        time,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
} 