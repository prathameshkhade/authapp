# AuthApp 🔐

This is a Flutter application built with BLoC & Clean Architecture to implement biometric authentication - Assignment.

## 📱 Features

- **Biometric Authentication**: Secure login using fingerprint/face recognition
- **Clean Architecture**: Organized codebase following clean architecture principles
- **BLoC State Management**: Reactive state management using flutter_bloc
- **Secure Storage**: Local secure storage for sensitive data
- **Supabase Integration**: Backend services for user authentication
- **Modern UI**: Clean and intuitive user interface with custom fonts

## 🛠️ Tech Stack

- **Framework**: Flutter 3.8.1+
- **State Management**: BLoC (flutter_bloc)
- **Architecture**: Clean Architecture
- **Authentication**: Supabase + Local Authentication
- **Secure Storage**: Flutter Secure Storage
- **Functional Programming**: fpdart
- **Dependency Injection**: get_it

## 📋 Prerequisites

Before running this project, make sure you have:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.8.1 or higher)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio / VS Code with Flutter extensions
- Android device/emulator with biometric capability
- iOS device/simulator (for iOS testing)

## 🚀 Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/prathameshkhade/authapp.git
cd authapp
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Configure Supabase
- Create a [Supabase](https://supabase.com/) project
- Set up your authentication settings in your Supabase dashboard
- Navigate to Settings → API in your Supabase project
- Copy your **Project URL** and **anon/public key**

### 4. Update AppSecrets Configuration
**Important**: You need to use your own Supabase credentials for the app to work properly.

- Locate the `AppSecrets` class in your project
- Replace the placeholder values with your own Supabase credentials:
  ```dart
  class AppSecrets {
    static const String supabaseUrl = 'YOUR_SUPABASE_PROJECT_URL';
    static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
  }
  ```
- **Never commit your actual API keys to version control!**

### 5. Platform Setup

#### Android
- Ensure your device/emulator has biometric authentication enabled
- Minimum Android SDK version should support biometric authentication

#### iOS
- Configure biometric permissions in `ios/Runner/Info.plist`:
```xml
<key>NSFaceIDUsageDescription</key>
<string>This app uses Face ID for secure authentication</string>
```

### 6. Run the Application
```bash
flutter run
```

## 🏗️ Project Structure

```
lib/
├── core/                   # Core utilities and constants
│   └── secrets/           # App secrets and configuration
├── features/              # Feature modules
│   └── auth/             # Authentication feature
│       ├── data/         # Data layer (repositories, data sources)
│       ├── domain/       # Domain layer (entities, use cases)
│       └── presentation/ # Presentation layer (BLoC, UI)
├── injection_container.dart # Dependency injection setup
└── main.dart             # App entry point
```

## 🔧 Key Dependencies

| Package | Purpose |
|---------|---------|
| `flutter_bloc` | State management |
| `supabase_flutter` | Backend services |
| `local_auth` | Biometric authentication |
| `flutter_secure_storage` | Secure local storage |
| `get_it` | Dependency injection |
| `fpdart` | Functional programming utilities |

## 🎨 Custom Fonts

The app uses **JetBrains Mono Nerd Font** with multiple weights:
- Regular (400)
- Light (300)
- Bold (600)
- Extra Bold (800)

## 🔒 Security Features

- **Biometric Authentication**: Fingerprint and Face ID support
- **Secure Storage**: Sensitive data encrypted and stored locally
- **Token Management**: Secure handling of authentication tokens
- **Clean Architecture**: Separation of concerns for better security

## ⚙️ Configuration

### Environment Setup
1. Create your own Supabase project at [supabase.com](https://supabase.com)
2. Copy your project URL and anon key to the `AppSecrets` class
3. Configure Supabase authentication settings (enable email/password auth)
4. Set up biometric authentication permissions

### Build Configuration
```bash
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release
```

## 🧪 Testing

Run tests using:
```bash
flutter test
```

## 📱 Platform Support

- ✅ Android (API 23+)
- ✅ iOS (iOS 12.0+)

## 🚨 Limitations & Assumptions

### Limitations
1. **Device Dependency**: Biometric authentication requires compatible hardware
2. **Network Dependency**: Requires internet connection for Supabase authentication
3. **Platform Restrictions**: Some biometric features may vary between Android and iOS
4. **Fallback Authentication**: Limited fallback options if biometric auth fails

### Assumptions
1. **User Device**: Assumes users have devices with biometric capabilities
2. **Internet Connectivity**: Assumes stable internet connection for authentication
3. **Permissions**: Assumes users will grant necessary biometric permissions
4. **Supabase Setup**: Assumes proper Supabase project configuration
5. **API Keys**: Assumes developers will use their own Supabase credentials

## 🔄 State Management Flow

```
UI → BLoC Events → Use Cases → Repositories → Data Sources → External APIs
   ← BLoC States ←          ←             ←              ←
```

## ⚠️ Important Security Notes

- **Never commit API keys**: Always use your own Supabase credentials and never commit them to version control
- **Environment Variables**: Consider using environment variables or secure configuration files for production
- **API Key Rotation**: Regularly rotate your Supabase API keys for enhanced security

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is created as an assignment and is for educational purposes.

## 📞 Support

For any issues or questions, please create an issue in the GitHub repository.

---

**Note**: This application demonstrates clean architecture principles and biometric authentication implementation in Flutter. Make sure to test thoroughly on physical devices for the best biometric authentication experience. Remember to use your own Supabase credentials for the application to function properly.
