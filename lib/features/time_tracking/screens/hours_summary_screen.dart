import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/time_tracking_providers.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/enhanced_app_bar.dart';

class HoursSummaryScreen extends ConsumerStatefulWidget {
  const HoursSummaryScreen({super.key});

  @override
  ConsumerState<HoursSummaryScreen> createState() => _HoursSummaryScreenState();
}

class _HoursSummaryScreenState extends ConsumerState<HoursSummaryScreen> {
  String _selectedPeriod = 'week'; // 'week', 'month', 'custom'
  DateTime? _customStartDate;
  DateTime? _customEndDate;

  @override
  Widget build(BuildContext context) {
    final isAdmin = ref.watch(isAdminProvider);
    
    return Scaffold(
      appBar: const EnhancedAppBar(
        title: 'Hours Summary',
      ),
      body: Column(
        children: [
          // Period Selector
          _PeriodSelector(
            selectedPeriod: _selectedPeriod,
            onPeriodChanged: (period) {
              setState(() {
                _selectedPeriod = period;
              });
            },
            onCustomDateSelected: (start, end) {
              setState(() {
                _customStartDate = start;
                _customEndDate = end;
              });
            },
          ),
          
          // Summary Content
          Expanded(
            child: _buildSummaryContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryContent() {
    switch (_selectedPeriod) {
      case 'week':
        return _WeekSummaryView();
      case 'month':
        return _MonthSummaryView();
      case 'custom':
        if (_customStartDate != null && _customEndDate != null) {
          return _CustomSummaryView(
            startDate: _customStartDate!,
            endDate: _customEndDate!,
          );
        }
        return const Center(
          child: Text('Please select a custom date range'),
        );
      default:
        return _WeekSummaryView();
    }
  }
}

class _PeriodSelector extends StatelessWidget {
  const _PeriodSelector({
    required this.selectedPeriod,
    required this.onPeriodChanged,
    required this.onCustomDateSelected,
  });

  final String selectedPeriod;
  final Function(String) onPeriodChanged;
  final Function(DateTime, DateTime) onCustomDateSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'week',
                      label: Text('This Week'),
                      icon: Icon(Icons.view_week),
                    ),
                    ButtonSegment(
                      value: 'month',
                      label: Text('This Month'),
                      icon: Icon(Icons.calendar_month),
                    ),
                    ButtonSegment(
                      value: 'custom',
                      label: Text('Custom'),
                      icon: Icon(Icons.date_range),
                    ),
                  ],
                  selected: {selectedPeriod},
                  onSelectionChanged: (Set<String> selection) {
                    onPeriodChanged(selection.first);
                  },
                ),
              ),
            ],
          ),
          if (selectedPeriod == 'custom') ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _selectDateRange(context),
                    icon: const Icon(Icons.calendar_today),
                    label: const Text('Select Date Range'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(
        start: DateTime.now().subtract(const Duration(days: 7)),
        end: DateTime.now(),
      ),
    );

    if (picked != null) {
      onCustomDateSelected(picked.start, picked.end);
    }
  }
}

class _WeekSummaryView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(thisWeekSummaryProvider);
    
    return summaryAsync.when(
      data: (summary) => _SummaryContent(summary: summary),
      loading: () => const LoadingWidget(message: 'Loading week summary...'),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error loading summary: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.invalidate(thisWeekSummaryProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _MonthSummaryView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(thisMonthSummaryProvider);
    
    return summaryAsync.when(
      data: (summary) => _SummaryContent(summary: summary),
      loading: () => const LoadingWidget(message: 'Loading month summary...'),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error loading summary: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.invalidate(thisMonthSummaryProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomSummaryView extends ConsumerWidget {
  const _CustomSummaryView({
    required this.startDate,
    required this.endDate,
  });

  final DateTime startDate;
  final DateTime endDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(workSummaryProvider({
      'startDate': startDate,
      'endDate': endDate,
    }));
    
    return summaryAsync.when(
      data: (summary) => _SummaryContent(summary: summary),
      loading: () => const LoadingWidget(message: 'Loading custom summary...'),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error loading summary: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.invalidate(workSummaryProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryContent extends StatelessWidget {
  const _SummaryContent({required this.summary});

  final summary; // WorkSummary type

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh logic would go here
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
            _SummaryStatsCards(summary: summary),
            const SizedBox(height: 24),
            
            // Daily Breakdown
            _DailyBreakdown(summary: summary),
            const SizedBox(height: 24),
            
            // Recent Sessions
            _RecentSessions(summary: summary),
          ],
        ),
      ),
    );
  }
}

class _SummaryStatsCards extends StatelessWidget {
  const _SummaryStatsCards({required this.summary});

  final summary; // WorkSummary type

  @override
  Widget build(BuildContext context) {
    final regularHours = summary.totalHours - summary.overtimeHours;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Total Hours',
                value: '${summary.totalHours.toStringAsFixed(1)}h',
                icon: Icons.access_time,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                title: 'Regular Hours',
                value: '${regularHours.toStringAsFixed(1)}h',
                icon: Icons.schedule,
                color: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Overtime',
                value: '${summary.overtimeHours.toStringAsFixed(1)}h',
                icon: Icons.trending_up,
                color: Colors.orange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                title: 'Sessions',
                value: '${summary.totalSessions}',
                icon: Icons.event_note,
                color: Colors.blue,
              ),
            ),
          ],
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
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
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
          ],
        ),
      ),
    );
  }
}

class _DailyBreakdown extends StatelessWidget {
  const _DailyBreakdown({required this.summary});

  final summary; // WorkSummary type

  @override
  Widget build(BuildContext context) {
    // Group records by day
    final Map<String, List<dynamic>> dailyRecords = {};
    for (final record in summary.records) {
      final dateKey = '${record.clockInTime.year}-${record.clockInTime.month.toString().padLeft(2, '0')}-${record.clockInTime.day.toString().padLeft(2, '0')}';
      dailyRecords[dateKey] = (dailyRecords[dateKey] ?? [])..add(record);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Breakdown',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...dailyRecords.entries.map((entry) {
          final date = DateTime.parse(entry.key);
          final records = entry.value;
          final totalHours = records.fold<double>(
            0,
            (sum, record) => sum + (record.totalHours ?? 0),
          );

          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  date.day.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                _formatDate(date),
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text('${records.length} session${records.length != 1 ? 's' : ''}'),
              trailing: Text(
                '${totalHours.toStringAsFixed(1)}h',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    
    return '${weekdays[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}';
  }
}

class _RecentSessions extends StatelessWidget {
  const _RecentSessions({required this.summary});

  final summary; // WorkSummary type

  @override
  Widget build(BuildContext context) {
    final recentRecords = summary.records.take(10).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Sessions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...recentRecords.map((record) {
          final clockInTime = record.clockInTime;
          final clockOutTime = record.clockOutTime;
          final duration = record.totalHours ?? 0;

          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: record.clockOutTime != null 
                    ? Colors.green.withOpacity(0.1)
                    : Colors.orange.withOpacity(0.1),
                child: Icon(
                  record.clockOutTime != null ? Icons.check : Icons.access_time,
                  color: record.clockOutTime != null ? Colors.green : Colors.orange,
                ),
              ),
              title: Text(
                _formatSessionDate(clockInTime),
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                clockOutTime != null
                    ? '${_formatTime(clockInTime)} - ${_formatTime(clockOutTime)}'
                    : 'Started at ${_formatTime(clockInTime)} (In Progress)',
              ),
              trailing: Text(
                clockOutTime != null
                    ? '${duration.toStringAsFixed(1)}h'
                    : 'Active',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: clockOutTime != null 
                      ? Theme.of(context).colorScheme.primary
                      : Colors.orange,
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  String _formatSessionDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final sessionDate = DateTime(date.year, date.month, date.day);

    if (sessionDate == today) {
      return 'Today';
    } else if (sessionDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return '${date.month}/${date.day}/${date.year}';
    }
  }

  String _formatTime(DateTime time) {
    final hour = time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
} 