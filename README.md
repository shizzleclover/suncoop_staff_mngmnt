# SunCoopAtt - Shift Management & Time Tracking System

A comprehensive Flutter-based shift management and staff time tracking system with real-time updates, GPS/WiFi validation, and role-based access control.

## 🎯 Overview

**SunCoopAtt** is a mobile-first platform where administrators can create and manage shifts, staff members can claim available shifts, and employees can clock in/out with anti-manipulation security measures.

## ✨ Features

### 🔐 Authentication & Authorization
- Secure user authentication via Supabase Auth
- Role-based access control (Admin/Staff)
- Row Level Security (RLS) for data protection

### 📅 Shift Management
- Admins can create and publish shifts
- Staff can view available shifts in calendar format
- Real-time shift availability updates
- Shift booking system with capacity limits

### ⏰ Time Tracking
- GPS-based clock in/out validation
- WiFi network verification (SSID + BSSID)
- Device integrity checks (anti-rooting)
- Automatic hours calculation with overtime tracking

### 👤 User Management
- User profiles with work history
- Total hours tracking and reporting
- Admin dashboard for staff oversight

### 🔄 Real-time Updates
- Live shift availability updates
- Real-time clock status changes
- Instant notifications across devices

## 🏗️ Architecture

### Tech Stack
- **Frontend**: Flutter with Material 3 Design
- **Backend**: Supabase (PostgreSQL + Auth + Real-time)
- **State Management**: Riverpod
- **Serialization**: Freezed + JSON Annotation
- **Navigation**: GoRouter
- **Calendar UI**: Syncfusion/Table Calendar

### Project Structure
```
lib/
├── core/
│   ├── constants/           # App-wide constants
│   ├── config/             # Environment configuration
│   └── providers/          # Global providers
├── models/                 # Data models (Freezed)
├── services/              # External service integrations
├── features/              # Feature-based modules
│   ├── auth/              # Authentication
│   ├── shifts/            # Shift management
│   ├── time_tracking/     # Clock in/out
│   ├── admin/             # Admin dashboard
│   └── profile/           # User profiles
└── shared/
    ├── widgets/           # Reusable widgets
    └── theme/             # App theming
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.8.0)
- Dart SDK
- Supabase account
- IDE (VS Code/Android Studio)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd suncoopatt
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Supabase**
   - Create a new Supabase project
   - Run the SQL schema from `/docs/database_schema.sql`
   - Get your project URL and anon key

4. **Configure environment variables**
   - Copy `.env.example` to `.env`
   - Update with your actual values:
   ```env
   SUPABASE_URL=your_supabase_url
   SUPABASE_ANON_KEY=your_anon_key
   OFFICE_WIFI_SSID=your_office_wifi
   OFFICE_LATITUDE=your_office_lat
   OFFICE_LONGITUDE=your_office_lng
   ```

5. **Generate code (Freezed models)**
   ```bash
   flutter packages pub run build_runner build
   ```

6. **Run the app**
   ```bash
   flutter run
   ```

## 🔧 Configuration

### Security Settings
Configure your office security parameters in `.env`:

- **WiFi Validation**: Set your office WiFi SSID and BSSID
- **GPS Geofencing**: Set office coordinates and radius
- **Device Integrity**: Enable/disable rooting detection

### App Settings
Customize app behavior in `/lib/core/constants/app_constants.dart`:

- Break time defaults
- Maximum shift hours
- Overtime thresholds
- UI constants

## 📊 Database Schema

The system uses 5 main tables:

1. **users** - User profiles and roles
2. **shifts** - Available work shifts
3. **shift_bookings** - Shift assignments
4. **clock_records** - Time tracking data
5. **app_settings** - System configuration

### Key Features
- Row Level Security (RLS) for data protection
- Real-time subscriptions enabled
- Automatic triggers for calculations
- Comprehensive audit trails

## 🔒 Security Features

### Anti-Manipulation Measures
- **GPS Validation**: Users must be within office geofence
- **WiFi Verification**: Must be connected to office network
- **Device Integrity**: Detects rooted/compromised devices
- **Session Security**: Token-based authentication

### Data Protection
- All data secured with Supabase RLS
- Role-based access controls
- Encrypted data transmission
- Audit logs for all actions

## 🧪 Development

### Code Generation
When modifying models, run:
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Testing
```bash
flutter test
```

### Building
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## 📱 User Roles

### Staff Members
- View available shifts
- Book/cancel shifts
- Clock in/out with validation
- View personal work history
- Update profile information

### Administrators
- Create and manage shifts
- View all staff activity
- Adjust time records
- Export reports
- Manage user accounts

## 🔮 Future Enhancements

- [ ] Push notifications for shift reminders
- [ ] Advanced reporting and analytics
- [ ] Payroll integration
- [ ] Multi-location support
- [ ] Mobile offline capabilities
- [ ] Advanced scheduling algorithms

## 🐛 Troubleshooting

### Common Issues

1. **Supabase Connection Error**
   - Verify URL and keys in `.env`
   - Check network connectivity
   - Ensure RLS policies are set up

2. **Code Generation Errors**
   - Run `flutter clean`
   - Delete generated files
   - Run build_runner again

3. **GPS/WiFi Not Working**
   - Check device permissions
   - Verify location services enabled
   - Update coordinates in configuration

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📞 Support

For issues and questions:
- Create an issue on GitHub
- Check the documentation
- Review the troubleshooting section

---

**Built with ❤️ using Flutter and Supabase**
