# SunCoopAtt - Complete Setup Guide

## Overview
SunCoopAtt is a comprehensive Flutter-based shift management and staff time tracking system with real-time data synchronization, security validation, and role-based access control.

## ✨ Features

### 🔐 Authentication & Security
- Supabase authentication with email/password
- Role-based access control (Admin/Staff)
- GPS location validation for clock in/out
- WiFi network validation
- Device integrity checking

### 📅 Shift Management
- Create, edit, and delete shifts
- Shift booking system with capacity management
- Calendar view with shift visualization
- Recurring shift creation
- Real-time availability updates

### ⏰ Time Tracking
- Secure clock in/out with location verification
- Break time tracking
- Overtime calculation
- Work history and summaries
- Admin time adjustment capabilities

### 👥 User Management
- User profile management
- Staff statistics and analytics
- Admin dashboard with system overview
- Team performance metrics

### 📱 Modern UI/UX
- Material 3 design system
- Responsive layouts
- Dark/Light theme support
- Bottom navigation
- Pull-to-refresh functionality

## 🛠️ Prerequisites

- Flutter SDK (3.8.0 or higher)
- Supabase account
- Android Studio / VS Code
- Git

## 📦 Installation

### 1. Clone the Repository
```bash
git clone <repository-url>
cd suncoopatt
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Generate Code (for Freezed models)
```bash
flutter packages pub run build_runner build
```

## 🗄️ Supabase Setup

### 1. Create a New Supabase Project
1. Go to [Supabase Dashboard](https://supabase.com/dashboard)
2. Click "New Project"
3. Fill in project details
4. Wait for project to be created

### 2. Set Up Database Schema
1. Go to SQL Editor in your Supabase dashboard
2. Copy the contents of `supabase_schema.sql`
3. Paste and execute the SQL script

This will create:
- All necessary tables (users, shifts, shift_bookings, clock_records, app_settings)
- Row Level Security (RLS) policies
- Database functions and triggers
- Default app settings

### 3. Configure Authentication
1. Go to Authentication > Settings
2. Enable email authentication
3. Configure email templates if needed
4. Set up redirect URLs for your app

### 4. Set Up Row Level Security
The SQL script already includes RLS policies, but verify:
1. Go to Authentication > Policies
2. Ensure all tables have appropriate policies enabled
3. Test with different user roles

### 5. Get Project Credentials
1. Go to Settings > API
2. Copy your project URL and anon public key
3. Update the `.env` file (see next section)

## ⚙️ Environment Configuration

### 1. Update `.env` File
Copy `.env.example` to `.env` and update the values:

```env
# Supabase Configuration
SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here

# Office Security Settings (Update these for your office)
OFFICE_WIFI_SSID=YourOfficeWiFiName
OFFICE_WIFI_BSSID=xx:xx:xx:xx:xx:xx
OFFICE_LATITUDE=40.7128
OFFICE_LONGITUDE=-74.0060
OFFICE_GEOFENCE_RADIUS=100.0

# App Configuration
APP_NAME=SunCoopAtt
APP_VERSION=1.0.0
DEBUG_MODE=true

# Time & Date Settings
DEFAULT_BREAK_TIME_MINUTES=30
MAX_SHIFT_HOURS=12
OVERTIME_THRESHOLD_HOURS=8

# Security Settings
REQUIRE_WIFI_CHECK=true
REQUIRE_GPS_CHECK=true
REQUIRE_DEVICE_INTEGRITY_CHECK=true
```

### 2. Update `lib/core/config/env_config.dart`
Replace the placeholder values with your actual Supabase credentials:

```dart
class EnvConfig {
  static const String supabaseUrl = 'https://your-project-id.supabase.co';
  static const String supabaseAnonKey = 'your-anon-key-here';
  
  // Update office settings
  static const String officeWifiSSID = 'YourOfficeWiFiName';
  static const String officeWifiBSSID = 'xx:xx:xx:xx:xx:xx';
  static const double officeLatitude = 40.7128;
  static const double officeLongitude = -74.0060;
  // ... rest of configuration
}
```

## 🔧 Platform-Specific Setup

### Android
1. Open `android/app/src/main/AndroidManifest.xml`
2. Add required permissions:
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.CHANGE_WIFI_STATE" />
<uses-permission android:name="android.permission.INTERNET" />
```

### iOS
1. Open `ios/Runner/Info.plist`
2. Add location usage descriptions:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to verify work location during clock in/out.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>This app needs location access to verify work location during clock in/out.</string>
```

## 🚀 Running the Application

### 1. Development Mode
```bash
# Run on connected device/emulator
flutter run

# Run in debug mode with hot reload
flutter run --debug

# Run in release mode
flutter run --release
```

### 2. Building for Production
```bash
# Build APK for Android
flutter build apk --release

# Build AAB for Google Play Store
flutter build appbundle --release

# Build for iOS
flutter build ios --release
```

## 👤 Initial User Setup

### 1. Create Admin User
1. Register a new user through the app
2. Go to Supabase Dashboard > Authentication > Users
3. Find your user and note the UUID
4. Go to Table Editor > users
5. Update the role column to 'admin' for your user

### 2. Test User Roles
- Admin users can access admin dashboard and user management
- Staff users can view shifts, clock in/out, and manage their profile

## 🧪 Testing the Application

### 1. Authentication Flow
- Test user registration and login
- Verify role-based navigation
- Test password reset functionality

### 2. Shift Management
- Create shifts as admin
- Book shifts as staff
- Test shift approval/rejection workflow

### 3. Time Tracking
- Test clock in/out with location verification
- Verify security validation works
- Test admin time adjustments

### 4. Security Features
- Test GPS location validation
- Verify WiFi network checking
- Test device integrity validation

## 🔐 Security Configuration

### 1. Location Validation
- Set your office coordinates in environment config
- Adjust geofence radius as needed
- Test location validation thoroughly

### 2. WiFi Validation
- Get your office WiFi SSID and BSSID
- Update configuration accordingly
- Test on different devices

### 3. Device Security
- Configure device integrity checking
- Test on rooted/jailbroken devices
- Adjust security policies as needed

## 📱 App Architecture

### State Management
- **Riverpod** for state management
- **Providers** for data fetching and actions
- **AsyncValue** for loading states

### Navigation
- **GoRouter** for declarative routing
- **Role-based routing** with guards
- **Deep linking** support

### Data Layer
- **Services** for API communication
- **Models** with Freezed for immutability
- **Providers** for reactive data

### UI Components
- **Material 3** design system
- **Responsive layouts**
- **Reusable widgets**

## 🛠️ Development Workflow

### 1. Code Generation
When you modify models or add new Riverpod providers:
```bash
flutter packages pub run build_runner build
```

### 2. Clean Build
If you encounter issues:
```bash
flutter clean
flutter pub get
flutter packages pub run build_runner build
```

### 3. Database Changes
When updating database schema:
1. Modify the SQL script
2. Apply changes in Supabase dashboard
3. Update Dart models if needed
4. Regenerate code

## 🐛 Troubleshooting

### Common Issues

1. **Supabase Connection Error**
   - Verify URL and anon key are correct
   - Check internet connection
   - Ensure RLS policies are properly configured

2. **Location Permission Denied**
   - Check platform-specific permission setup
   - Test on physical device (emulator has limitations)
   - Verify location services are enabled

3. **WiFi Validation Failing**
   - Check WiFi SSID and BSSID configuration
   - Test on different Android versions
   - Consider WiFi permission requirements

4. **Build Errors**
   - Run `flutter clean && flutter pub get`
   - Regenerate code with build_runner
   - Check Flutter/Dart version compatibility

### Performance Tips

1. **Database Optimization**
   - Use indexes on frequently queried columns
   - Implement pagination for large datasets
   - Use database functions for complex queries

2. **App Performance**
   - Use `const` constructors where possible
   - Implement proper widget disposal
   - Use `ListView.builder` for large lists

## 📚 Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Supabase Documentation](https://supabase.com/docs)
- [Riverpod Documentation](https://riverpod.dev/)
- [Material 3 Guidelines](https://m3.material.io/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and ensure code quality
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Check the troubleshooting section
- Review Supabase and Flutter documentation

---

**Note**: This is a production-ready application with comprehensive security features. Make sure to properly configure all security settings before deploying to production. 