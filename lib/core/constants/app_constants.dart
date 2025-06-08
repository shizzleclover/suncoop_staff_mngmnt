class AppConstants {
  // App Info
  static const String appName = 'SunCoopAtt';
  static const String appVersion = '1.0.0';
  
  // Time & Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String displayTimeFormat = 'h:mm a';
  
  // User Roles
  static const String adminRole = 'admin';
  static const String staffRole = 'staff';
  
  // Database Tables
  static const String usersTable = 'users';
  static const String shiftsTable = 'shifts';
  static const String shiftBookingsTable = 'shift_bookings';
  static const String clockRecordsTable = 'clock_records';
  static const String appSettingsTable = 'app_settings';
  
  // Routes
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String profileRoute = '/profile';
  static const String shiftsRoute = '/shifts';
  static const String adminRoute = '/admin';
  static const String clockInRoute = '/clock-in';
  static const String calendarRoute = '/calendar';
  
  // Shift Status
  static const String shiftStatusBooked = 'booked';
  static const String shiftStatusCancelled = 'cancelled';
  static const String shiftStatusCompleted = 'completed';
  
  // Clock Status
  static const String clockStatusIn = 'clocked_in';
  static const String clockStatusOut = 'clocked_out';
  static const String clockStatusInvalid = 'invalid';
  
  // Validation
  static const double defaultGeofenceRadius = 100.0; // meters
  static const int maxShiftHours = 12;
  static const int defaultBreakMinutes = 30;
  static const int overtimeThreshold = 8;
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
} 