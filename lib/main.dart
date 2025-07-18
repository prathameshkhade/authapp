import 'package:authapp/core/config/theme.dart';
import 'package:authapp/features/auth/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';


void main() {
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