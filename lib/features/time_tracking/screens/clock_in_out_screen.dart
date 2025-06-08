import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../shared/widgets/bottom_navigation.dart';

class ClockInOutScreen extends ConsumerStatefulWidget {
  const ClockInOutScreen({super.key});

  @override
  ConsumerState<ClockInOutScreen> createState() => _ClockInOutScreenState();
}

class _ClockInOutScreenState extends ConsumerState<ClockInOutScreen> {
  bool _isClockedIn = false;
  bool _isLoading = false;
  DateTime? _clockInTime;
  String _currentLocation = 'Checking location...';
  bool _isLocationValid = false;
  bool _isWifiValid = false;

  @override
  void initState() {
    super.initState();
    _checkCurrentStatus();
    _validateLocation();
    _validateWifi();
  }

  void _checkCurrentStatus() {
    // TODO: Check current clock status from Supabase
    // Mock data for now
    setState(() {
      _isClockedIn = false; // Change based on actual status
      _clockInTime = null;
    });
  }

  void _validateLocation() async {
    // TODO: Implement GPS validation using geolocator
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _currentLocation = 'Main Office (123 Business St)';
      _isLocationValid = true;
    });
  }

  void _validateWifi() async {
    // TODO: Implement WiFi validation
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isWifiValid = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = ref.watch(isAdminProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Tracking'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              _showTimeHistory();
            },
            tooltip: 'Time History',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _checkCurrentStatus();
          _validateLocation();
          _validateWifi();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current Status Card
              _CurrentStatusCard(
                isClockedIn: _isClockedIn,
                clockInTime: _clockInTime,
              ),
              const SizedBox(height: 16),
              
              // Security Validation Card
              _SecurityValidationCard(
                location: _currentLocation,
                isLocationValid: _isLocationValid,
                isWifiValid: _isWifiValid,
              ),
              const SizedBox(height: 16),
              
              // Today's Shift Card
              _TodayShiftCard(),
              const SizedBox(height: 16),
              
              // Clock In/Out Button
              _ClockActionButton(
                isClockedIn: _isClockedIn,
                isLoading: _isLoading,
                canClock: _isLocationValid && _isWifiValid,
                onPressed: _handleClockAction,
              ),
              const SizedBox(height: 16),
              
              // Quick Stats
              _QuickStatsCard(),
              const SizedBox(height: 16),
              
              // Recent Activity
              _RecentActivityCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: AppBottomNavigation.getIndexForRoute('/clock', isAdmin),
      ),
    );
  }

  void _handleClockAction() async {
    if (!_isLocationValid || !_isWifiValid) {
      _showSecurityAlert();
      return;
    }

    setState(() => _isLoading = true);

    try {
      // TODO: Implement Supabase clock in/out logic
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      setState(() {
        _isClockedIn = !_isClockedIn;
        if (_isClockedIn) {
          _clockInTime = DateTime.now();
        } else {
          _clockInTime = null;
        }
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isClockedIn ? 'Clocked in successfully!' : 'Clocked out successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to ${_isClockedIn ? 'clock out' : 'clock in'}: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showSecurityAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Security Check Failed'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Please ensure the following requirements are met:'),
            const SizedBox(height: 12),
            if (!_isLocationValid) ...[
              Row(
                children: [
                  Icon(Icons.location_off, color: Colors.red, size: 16),
                  const SizedBox(width: 8),
                  const Text('Valid GPS location'),
                ],
              ),
            ],
            if (!_isWifiValid) ...[
              Row(
                children: [
                  Icon(Icons.wifi_off, color: Colors.red, size: 16),
                  const SizedBox(width: 8),
                  const Text('Connected to office WiFi'),
                ],
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showTimeHistory() {
    // TODO: Navigate to time history screen or show modal
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Time History',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 10, // Mock data count
                  itemBuilder: (context, index) => Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green.withOpacity(0.1),
                        child: Icon(Icons.access_time, color: Colors.green),
                      ),
                      title: Text('January ${15 - index}, 2024'),
                      subtitle: Text('8.5 hours worked'),
                      trailing: const Text('9:00 AM - 5:30 PM'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CurrentStatusCard extends StatelessWidget {
  const _CurrentStatusCard({
    required this.isClockedIn,
    required this.clockInTime,
  });

  final bool isClockedIn;
  final DateTime? clockInTime;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isClockedIn ? Icons.access_time : Icons.access_time_outlined,
                  size: 32,
                  color: isClockedIn ? Colors.green : Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isClockedIn ? 'Currently Clocked In' : 'Not Clocked In',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isClockedIn ? Colors.green : null,
                        ),
                      ),
                      if (clockInTime != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Since ${clockInTime!.hour.toString().padLeft(2, '0')}:${clockInTime!.minute.toString().padLeft(2, '0')}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (isClockedIn) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'ACTIVE',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            if (isClockedIn && clockInTime != null) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      _calculateElapsedTime(clockInTime!),
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Text(
                      'Time worked today',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _calculateElapsedTime(DateTime startTime) {
    final elapsed = DateTime.now().difference(startTime);
    final hours = elapsed.inHours;
    final minutes = elapsed.inMinutes % 60;
    return '${hours}h ${minutes}m';
  }
}

class _SecurityValidationCard extends StatelessWidget {
  const _SecurityValidationCard({
    required this.location,
    required this.isLocationValid,
    required this.isWifiValid,
  });

  final String location;
  final bool isLocationValid;
  final bool isWifiValid;

  @override
  Widget build(BuildContext context) {
    final allValid = isLocationValid && isWifiValid;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  allValid ? Icons.security : Icons.warning,
                  color: allValid ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  'Security Validation',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _ValidationItem(
              icon: Icons.location_on,
              label: 'Location',
              value: location,
              isValid: isLocationValid,
            ),
            const SizedBox(height: 8),
            _ValidationItem(
              icon: Icons.wifi,
              label: 'WiFi Network',
              value: 'SunCoop-Office',
              isValid: isWifiValid,
            ),
          ],
        ),
      ),
    );
  }
}

class _ValidationItem extends StatelessWidget {
  const _ValidationItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.isValid,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: isValid ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Icon(
          isValid ? Icons.check_circle : Icons.error,
          color: isValid ? Colors.green : Colors.red,
          size: 20,
        ),
      ],
    );
  }
}

class _TodayShiftCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mock shift data
    final hasShift = true;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Shift',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (hasShift) ...[
              Row(
                children: [
                  Icon(
                    Icons.work,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Morning Front Desk',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '9:00 AM - 5:00 PM • Main Office',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Chip(
                    label: Text('\$15/hr'),
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ],
              ),
            ] else ...[
              Row(
                children: [
                  Icon(
                    Icons.event_busy,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'No shift scheduled for today',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ClockActionButton extends StatelessWidget {
  const _ClockActionButton({
    required this.isClockedIn,
    required this.isLoading,
    required this.canClock,
    required this.onPressed,
  });

  final bool isClockedIn;
  final bool isLoading;
  final bool canClock;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: FilledButton.icon(
        onPressed: (isLoading || !canClock) ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: isClockedIn ? Colors.red : Colors.green,
          foregroundColor: Colors.white,
        ),
        icon: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : Icon(
                isClockedIn ? Icons.logout : Icons.login,
                size: 28,
              ),
        label: Text(
          isLoading
              ? (isClockedIn ? 'Clocking Out...' : 'Clocking In...')
              : (isClockedIn ? 'Clock Out' : 'Clock In'),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _QuickStatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This Week',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _StatItem(
                    icon: Icons.access_time,
                    label: 'Hours',
                    value: '32.5',
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    icon: Icons.event,
                    label: 'Shifts',
                    value: '4',
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    icon: Icons.attach_money,
                    label: 'Earnings',
                    value: '\$487.50',
                    color: Colors.orange,
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

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
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
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _ActivityItem(
              time: '9:00 AM',
              action: 'Clocked in',
              location: 'Main Office',
              icon: Icons.login,
              color: Colors.green,
            ),
            const Divider(),
            _ActivityItem(
              time: 'Yesterday 5:30 PM',
              action: 'Clocked out',
              location: 'Main Office',
              icon: Icons.logout,
              color: Colors.red,
            ),
            const Divider(),
            _ActivityItem(
              time: 'Yesterday 9:00 AM',
              action: 'Clocked in',
              location: 'Main Office',
              icon: Icons.login,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  const _ActivityItem({
    required this.time,
    required this.action,
    required this.location,
    required this.icon,
    required this.color,
  });

  final String time;
  final String action;
  final String location;
  final IconData icon;
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
                  action,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  location,
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