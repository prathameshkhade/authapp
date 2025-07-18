import 'package:authapp/core/config/app_secrets.dart';
import 'package:authapp/core/config/theme.dart';
import 'package:authapp/features/auth/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  runApp(const AuthApp());
}

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentication App',
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,

      home: const SignupScreen(),
    );
  }
}
