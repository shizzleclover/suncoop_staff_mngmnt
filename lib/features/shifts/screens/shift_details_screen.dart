import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../shared/widgets/loading_widget.dart';

class ShiftDetailsScreen extends ConsumerWidget {
  const ShiftDetailsScreen({
    super.key,
    required this.shiftId,
  });

  final String shiftId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isAdminProvider);
    
    // Mock shift data - replace with actual data from Supabase
    final shift = _getMockShift(shiftId);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shift Details'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (isAdmin) ...[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                context.go('/admin/edit-shift/$shiftId');
              },
            ),
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'duplicate',
                  child: Row(
                    children: [
                      Icon(Icons.content_copy),
                      SizedBox(width: 12),
                      Text('Duplicate'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 12),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                if (value == 'delete') {
                  _showDeleteConfirmation(context);
                }
              },
            ),
          ],
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shift Header Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            shift['title'],
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: shift['isAvailable']
                                ? Colors.green.withOpacity(0.1)
                                : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            shift['isAvailable'] ? 'Available' : 'Fully Booked',
                            style: TextStyle(
                              color: shift['isAvailable'] ? Colors.green : Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (shift['description'] != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        shift['description'],
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Shift Details Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shift Information',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _DetailRow(
                      icon: Icons.access_time,
                      label: 'Time',
                      value: '${shift['startTime']} - ${shift['endTime']}',
                    ),
                    _DetailRow(
                      icon: Icons.calendar_today,
                      label: 'Date',
                      value: shift['date'],
                    ),
                    if (shift['location'] != null)
                      _DetailRow(
                        icon: Icons.location_on,
                        label: 'Location',
                        value: shift['location'],
                      ),
                    if (shift['hourlyRate'] != null)
                      _DetailRow(
                        icon: Icons.attach_money,
                        label: 'Hourly Rate',
                        value: '\$${shift['hourlyRate']}/hour',
                      ),
                    _DetailRow(
                      icon: Icons.people,
                      label: 'Staff Capacity',
                      value: '${shift['staffCount']}/${shift['maxStaff']} filled',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Staff Assignments (Admin) or Booking Status (Staff)
            if (isAdmin) ...[
              _AdminStaffSection(shift: shift),
            ] else ...[
              _StaffBookingSection(shift: shift, shiftId: shiftId),
            ],
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getMockShift(String id) {
    // Mock data - replace with Supabase query
    return {
      'id': id,
      'title': 'Morning Front Desk',
      'description': 'Handle customer inquiries, manage appointments, and provide general reception duties.',
      'date': 'January 15, 2024',
      'startTime': '9:00 AM',
      'endTime': '1:00 PM',
      'location': 'Main Office - Reception',
      'hourlyRate': 15.0,
      'isAvailable': true,
      'staffCount': 1,
      'maxStaff': 2,
      'assignedStaff': [
        {'id': '1', 'name': 'John Doe', 'status': 'confirmed'},
      ],
    };
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Shift'),
        content: const Text('Are you sure you want to delete this shift? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement delete functionality
              context.go('/calendar');
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

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
          Text(
            '$label:',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminStaffSection extends StatelessWidget {
  const _AdminStaffSection({required this.shift});

  final Map<String, dynamic> shift;

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
                  'Assigned Staff',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                FilledButton.icon(
                  onPressed: () {
                    // TODO: Add staff assignment functionality
                  },
                  icon: const Icon(Icons.person_add),
                  label: const Text('Assign'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (shift['assignedStaff'].isEmpty) ...[
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.person_off,
                      size: 48,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No staff assigned yet',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              ...shift['assignedStaff'].map<Widget>((staff) => ListTile(
                leading: CircleAvatar(
                  child: Text(staff['name'][0]),
                ),
                title: Text(staff['name']),
                subtitle: Text('Status: ${staff['status']}'),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'remove',
                      child: Text('Remove from shift'),
                    ),
                  ],
                ),
              )),
            ],
          ],
        ),
      ),
    );
  }
}

class _StaffBookingSection extends StatefulWidget {
  const _StaffBookingSection({
    required this.shift,
    required this.shiftId,
  });

  final Map<String, dynamic> shift;
  final String shiftId;

  @override
  State<_StaffBookingSection> createState() => _StaffBookingSectionState();
}

class _StaffBookingSectionState extends State<_StaffBookingSection> {
  bool isBooked = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking Status',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (isBooked) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 48,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'You\'re booked for this shift!',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Make sure to clock in on time.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: isLoading ? null : _cancelBooking,
                  icon: isLoading 
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.cancel),
                  label: Text(isLoading ? 'Cancelling...' : 'Cancel Booking'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ] else if (widget.shift['isAvailable']) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_available,
                      color: Theme.of(context).colorScheme.primary,
                      size: 48,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This shift is available',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Book now to secure your spot!',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton.icon(
                  onPressed: isLoading ? null : _bookShift,
                  icon: isLoading 
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.book_online),
                  label: Text(isLoading ? 'Booking...' : 'Book This Shift'),
                ),
              ),
            ] else ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_busy,
                      color: Colors.orange,
                      size: 48,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Shift Fully Booked',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'All positions for this shift have been filled.',
                      style: Theme.of(context).textTheme.bodyMedium,
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

  void _bookShift() async {
    setState(() => isLoading = true);
    
    try {
      // TODO: Implement Supabase booking logic
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      
      setState(() {
        isBooked = true;
        isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Shift booked successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to book shift: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _cancelBooking() async {
    setState(() => isLoading = true);
    
    try {
      // TODO: Implement Supabase cancellation logic
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      
      setState(() {
        isBooked = false;
        isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Booking cancelled successfully!'),
          backgroundColor: Colors.orange,
        ),
      );
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to cancel booking: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
} 