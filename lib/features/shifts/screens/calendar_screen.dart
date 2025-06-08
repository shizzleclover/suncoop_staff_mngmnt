import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../shared/widgets/bottom_navigation.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/app_sidebar.dart';
import '../../../shared/widgets/enhanced_app_bar.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> with TickerProviderStateMixin {
  late final ValueNotifier<List<Event>> _selectedEvents;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  
  String _filterStatus = 'all'; // 'all', 'available', 'booked'
  bool _showOnlyMyShifts = false;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    _animationController.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    List<Event> events = kEvents[DateTime.utc(day.year, day.month, day.day)] ?? [];
    
    // Apply filters
    if (_filterStatus == 'available') {
      events = events.where((event) => event.isAvailable).toList();
    } else if (_filterStatus == 'booked') {
      events = events.where((event) => !event.isAvailable).toList();
    }
    
    return events;
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
      _animationController.reset();
      _animationController.forward();
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else {
      _selectedEvents.value = [];
    }
    _animationController.reset();
    _animationController.forward();
  }

  Future<void> _bookShift(Event event) async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Booking'),
        content: Text(
          'Are you sure you want to book "${event.title}" from ${event.startTime} to ${event.endTime}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Book Shift'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // Update the event availability
      setState(() {
        // Find and update the event in kEvents
        final eventDate = DateTime.utc(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day);
        final events = kEvents[eventDate];
        if (events != null) {
          final index = events.indexWhere((e) => e.id == event.id);
          if (index != -1) {
            // Replace with updated event
            kEvents[eventDate]![index] = Event(
              id: event.id,
              title: event.title,
              startTime: event.startTime,
              endTime: event.endTime,
              location: event.location,
              hourlyRate: event.hourlyRate,
              isAvailable: event.staffCount + 1 < event.maxStaff,
              staffCount: event.staffCount + 1,
              maxStaff: event.maxStaff,
            );
          }
        }
      });
      
      // Refresh the selected events
      _selectedEvents.value = _getEventsForDay(_selectedDay!);
      
      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully booked "${event.title}"'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = ref.watch(isAdminProvider);
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: EnhancedAppBar(
        title: isAdmin ? 'Shift Management' : 'Available Shifts',
        actions: [
          if (isAdmin) ...[
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () => context.go('/admin/create-shift'),
              tooltip: 'Create Shift',
            ),
          ],
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: _showFilterDialog,
            tooltip: 'Filter',
          ),
        ],
      ),
      drawer: const AppSidebar(),
      body: Column(
        children: [
          // Enhanced Calendar Widget
          Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TableCalendar<Event>(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                // Today styling
                todayDecoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                todayTextStyle: TextStyle(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                
                // Selected day styling
                selectedDecoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                selectedTextStyle: TextStyle(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                
                // Range styling
                rangeHighlightColor: colorScheme.primary.withOpacity(0.2),
                rangeStartDecoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                rangeEndDecoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                
                // Weekend styling
                weekendTextStyle: TextStyle(
                  color: colorScheme.error,
                  fontWeight: FontWeight.w600,
                ),
                
                // Default styling
                defaultTextStyle: TextStyle(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
                
                // Outside days
                outsideDaysVisible: true,
                outsideTextStyle: TextStyle(
                  color: colorScheme.onSurface.withOpacity(0.3),
                ),
                
                // Markers for events
                markersMaxCount: 3,
                markerDecoration: BoxDecoration(
                  color: colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
                markersOffset: const PositionedOffset(bottom: 4),
                
                cellMargin: const EdgeInsets.all(6),
                cellPadding: const EdgeInsets.all(0),
              ),
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: true,
                formatButtonDecoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                formatButtonTextStyle: TextStyle(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: colorScheme.primary,
                  size: 28,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: colorScheme.primary,
                  size: 28,
                ),
                titleTextStyle: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                weekendStyle: TextStyle(
                  color: colorScheme.error,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              onDaySelected: _onDaySelected,
              onRangeSelected: _onRangeSelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              rangeSelectionMode: _rangeSelectionMode,
            ),
          ),
          
          // Filter chips
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: _filterStatus == 'all',
                  onSelected: (selected) {
                    setState(() {
                      _filterStatus = 'all';
                      _selectedEvents.value = _getEventsForDay(_selectedDay ?? DateTime.now());
                    });
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Available'),
                  selected: _filterStatus == 'available',
                  onSelected: (selected) {
                    setState(() {
                      _filterStatus = 'available';
                      _selectedEvents.value = _getEventsForDay(_selectedDay ?? DateTime.now());
                    });
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Booked'),
                  selected: _filterStatus == 'booked',
                  onSelected: (selected) {
                    setState(() {
                      _filterStatus = 'booked';
                      _selectedEvents.value = _getEventsForDay(_selectedDay ?? DateTime.now());
                    });
                  },
                ),
              ],
            ),
          ),
          
          // Enhanced Events List
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  if (value.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.event_busy,
                              size: 64,
                              color: colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            isAdmin ? 'No shifts scheduled' : 'No available shifts',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _selectedDay != null
                                ? 'for ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}'
                                : 'for the selected period',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                          if (isAdmin) ...[
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () => context.go('/admin/create-shift'),
                              icon: const Icon(Icons.add),
                              label: const Text('Create Shift'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }
                  
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 200 + (index * 50)),
                        curve: Curves.easeOutBack,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: _EnhancedShiftCard(
                          event: value[index],
                          isAdmin: isAdmin,
                          onTap: () {
                            context.go('/shifts/${value[index].id}');
                          },
                          onBook: () => _bookShift(value[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: AppBottomNavigation.getIndexForRoute('/calendar', isAdmin),
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton.extended(
              onPressed: () => context.go('/admin/create-shift'),
              icon: const Icon(Icons.add),
              label: const Text('Create Shift'),
            )
          : null,
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Shifts'),
        content: StatefulBuilder(
          builder: (context, setDialogState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('All Shifts'),
                value: 'all',
                groupValue: _filterStatus,
                onChanged: (value) {
                  setDialogState(() {
                    _filterStatus = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Available Only'),
                value: 'available',
                groupValue: _filterStatus,
                onChanged: (value) {
                  setDialogState(() {
                    _filterStatus = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Booked Only'),
                value: 'booked',
                groupValue: _filterStatus,
                onChanged: (value) {
                  setDialogState(() {
                    _filterStatus = value!;
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              setState(() {
                _selectedEvents.value = _getEventsForDay(_selectedDay ?? DateTime.now());
              });
              Navigator.of(context).pop();
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}

class _EnhancedShiftCard extends StatelessWidget {
  const _EnhancedShiftCard({
    required this.event,
    required this.isAdmin,
    required this.onTap,
    required this.onBook,
  });

  final Event event;
  final bool isAdmin;
  final VoidCallback onTap;
  final VoidCallback onBook;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isFullyBooked = event.staffCount >= event.maxStaff;
    
    return Card(
      elevation: 4,
      shadowColor: colorScheme.shadow.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.surface,
                colorScheme.surface.withOpacity(0.8),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with title and status
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        event.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: event.isAvailable
                            ? Colors.green.withOpacity(0.15)
                            : isFullyBooked
                                ? Colors.red.withOpacity(0.15)
                                : Colors.orange.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: event.isAvailable
                              ? Colors.green
                              : isFullyBooked
                                  ? Colors.red
                                  : Colors.orange,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        event.isAvailable
                            ? 'Available'
                            : isFullyBooked
                                ? 'Full'
                                : 'Limited',
                        style: TextStyle(
                          color: event.isAvailable
                              ? Colors.green.shade700
                              : isFullyBooked
                                  ? Colors.red.shade700
                                  : Colors.orange.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Time and location info
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.access_time,
                        size: 20,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${event.startTime} - ${event.endTime}',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (event.location != null)
                            Text(
                              event.location!,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurface.withOpacity(0.7),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                if (event.hourlyRate != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.attach_money,
                          size: 18,
                          color: colorScheme.onSecondaryContainer,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '\$${event.hourlyRate}/hour',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                
                const SizedBox(height: 16),
                
                // Staff count and actions
                Row(
                  children: [
                    // Staff indicator
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.people,
                              size: 18,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${event.staffCount}/${event.maxStaff} staff',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    
                    // Action buttons
                    if (!isAdmin && event.isAvailable && !isFullyBooked) ...[
                      FilledButton.icon(
                        onPressed: onBook,
                        icon: const Icon(Icons.add_task, size: 18),
                        label: const Text('Book'),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                      ),
                    ] else if (isAdmin) ...[
                      IconButton.outlined(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // TODO: Edit shift
                        },
                        tooltip: 'Edit Shift',
                      ),
                      const SizedBox(width: 8),
                      IconButton.outlined(
                        icon: const Icon(Icons.people),
                        onPressed: () {
                          // TODO: View bookings
                        },
                        tooltip: 'View Bookings',
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Enhanced Event model with better structure
class Event {
  final String id;
  final String title;
  final String startTime;
  final String endTime;
  final String? location;
  final double? hourlyRate;
  final bool isAvailable;
  final int staffCount;
  final int maxStaff;

  const Event({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    this.location,
    this.hourlyRate,
    required this.isAvailable,
    required this.staffCount,
    required this.maxStaff,
  });

  @override
  String toString() => title;
}

// Enhanced mock events data with more variety
final kEvents = <DateTime, List<Event>>{
  DateTime.utc(2024, 1, 15): [
    const Event(
      id: '1',
      title: 'Morning Front Desk',
      startTime: '9:00 AM',
      endTime: '1:00 PM',
      location: 'Main Office',
      hourlyRate: 15.0,
      isAvailable: true,
      staffCount: 1,
      maxStaff: 2,
    ),
    const Event(
      id: '2',
      title: 'Evening Cleaning',
      startTime: '6:00 PM',
      endTime: '10:00 PM',
      location: 'All Floors',
      hourlyRate: 18.0,
      isAvailable: false,
      staffCount: 2,
      maxStaff: 2,
    ),
  ],
  DateTime.utc(2024, 1, 16): [
    const Event(
      id: '3',
      title: 'Reception Coverage',
      startTime: '2:00 PM',
      endTime: '6:00 PM',
      location: 'Front Desk',
      hourlyRate: 16.0,
      isAvailable: true,
      staffCount: 0,
      maxStaff: 1,
    ),
    const Event(
      id: '4',
      title: 'Security Patrol',
      startTime: '11:00 PM',
      endTime: '7:00 AM',
      location: 'Building Perimeter',
      hourlyRate: 20.0,
      isAvailable: true,
      staffCount: 1,
      maxStaff: 3,
    ),
  ],
  DateTime.utc(2024, 1, 17): [
    const Event(
      id: '5',
      title: 'Event Setup',
      startTime: '8:00 AM',
      endTime: '12:00 PM',
      location: 'Conference Hall',
      hourlyRate: 17.0,
      isAvailable: true,
      staffCount: 0,
      maxStaff: 4,
    ),
    const Event(
      id: '6',
      title: 'Customer Service',
      startTime: '1:00 PM',
      endTime: '5:00 PM',
      location: 'Customer Center',
      hourlyRate: 16.5,
      isAvailable: true,
      staffCount: 2,
      maxStaff: 3,
    ),
  ],
};

final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
final kToday = DateTime.now();

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
} 