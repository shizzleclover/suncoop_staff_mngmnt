import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../shared/widgets/bottom_navigation.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isAdminProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to system settings
            },
            tooltip: 'System Settings',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // TODO: Refresh dashboard data
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Implement refresh functionality
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              _AdminWelcomeCard(),
              const SizedBox(height: 16),
              
              // Quick Actions
              _QuickActionsGrid(),
              const SizedBox(height: 16),
              
              // System Overview
              _SystemOverviewCard(),
              const SizedBox(height: 16),
              
              // Staff Status
              _StaffStatusCard(),
              const SizedBox(height: 16),
              
              // Recent Activity
              _RecentActivityCard(),
              const SizedBox(height: 16),
              
              // System Stats
              _SystemStatsCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: AppBottomNavigation.getIndexForRoute('/admin', isAdmin),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/admin/create-shift'),
        icon: const Icon(Icons.add),
        label: const Text('Create Shift'),
      ),
    );
  }
}

class _AdminWelcomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.admin_panel_settings,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back, Admin!',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Manage your team and oversee operations',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: [
            _QuickActionCard(
              icon: Icons.add_circle_outline,
              title: 'Create Shift',
              subtitle: 'Add new shift',
              color: Colors.blue,
              onTap: () => context.go('/admin/create-shift'),
            ),
            _QuickActionCard(
              icon: Icons.people_outline,
              title: 'Manage Users',
              subtitle: 'View all staff',
              color: Colors.green,
              onTap: () => context.go('/admin/users'),
            ),
            _QuickActionCard(
              icon: Icons.event_note,
              title: 'Shift Bookings',
              subtitle: 'View bookings',
              color: Colors.orange,
              onTap: () => context.go('/admin/bookings'),
            ),
            _QuickActionCard(
              icon: Icons.analytics,
              title: 'Reports',
              subtitle: 'View analytics',
              color: Colors.purple,
              onTap: () {
                // TODO: Navigate to reports
              },
            ),
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
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: color,
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

class _SystemOverviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'System Overview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _OverviewItem(
                    title: 'Total Staff',
                    value: '24',
                    icon: Icons.people,
                    color: Colors.blue,
                    trend: '+2 this week',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _OverviewItem(
                    title: 'Active Shifts',
                    value: '8',
                    icon: Icons.work,
                    color: Colors.green,
                    trend: '3 pending',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _OverviewItem(
                    title: 'Hours Today',
                    value: '192',
                    icon: Icons.access_time,
                    color: Colors.orange,
                    trend: '12 staff working',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _OverviewItem(
                    title: 'Attendance',
                    value: '95.2%',
                    icon: Icons.check_circle,
                    color: Colors.purple,
                    trend: 'This month',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OverviewItem extends StatelessWidget {
  const _OverviewItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.trend,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String trend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            trend,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _StaffStatusCard extends StatelessWidget {
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
                Text(
                  'Staff Status',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => context.go('/admin/users'),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Currently Working
            _StaffStatusSection(
              title: 'Currently Working',
              count: 12,
              icon: Icons.work,
              color: Colors.green,
              staff: [
                'John Doe - Front Desk',
                'Jane Smith - Reception',
                'Mike Johnson - Security',
              ],
            ),
            const SizedBox(height: 16),
            
            // On Break
            _StaffStatusSection(
              title: 'On Break',
              count: 3,
              icon: Icons.coffee,
              color: Colors.orange,
              staff: [
                'Sarah Wilson - Lunch Break',
                'Tom Brown - Coffee Break',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StaffStatusSection extends StatelessWidget {
  const _StaffStatusSection({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
    required this.staff,
  });

  final String title;
  final int count;
  final IconData icon;
  final Color color;
  final List<String> staff;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              '$title ($count)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...staff.take(3).map((member) => Padding(
          padding: const EdgeInsets.only(left: 28, bottom: 4),
          child: Text(
            member,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        )),
        if (staff.length > 3) ...[
          Padding(
            padding: const EdgeInsets.only(left: 28),
            child: Text(
              '+${staff.length - 3} more',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _RecentActivityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            _ActivityItem(
              icon: Icons.person_add,
              title: 'New staff member added',
              subtitle: 'Sarah Wilson joined the team',
              time: '2 hours ago',
              color: Colors.green,
            ),
            const Divider(),
            _ActivityItem(
              icon: Icons.schedule,
              title: 'Shift created',
              subtitle: 'Evening cleaning shift for tomorrow',
              time: '4 hours ago',
              color: Colors.blue,
            ),
            const Divider(),
            _ActivityItem(
              icon: Icons.warning,
              title: 'Late clock-in alert',
              subtitle: 'John Doe clocked in 15 minutes late',
              time: '6 hours ago',
              color: Colors.orange,
            ),
            const Divider(),
            _ActivityItem(
              icon: Icons.check_circle,
              title: 'Shift completed',
              subtitle: 'Morning reception shift completed',
              time: 'Yesterday',
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _SystemStatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'System Statistics',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            _StatRow(
              label: 'Total Hours This Month',
              value: '1,247 hours',
              icon: Icons.access_time,
            ),
            _StatRow(
              label: 'Average Shift Duration',
              value: '7.5 hours',
              icon: Icons.schedule,
            ),
            _StatRow(
              label: 'Most Active Location',
              value: 'Main Office',
              icon: Icons.location_on,
            ),
            _StatRow(
              label: 'System Uptime',
              value: '99.8%',
              icon: Icons.cloud_done,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
} 