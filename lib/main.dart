import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'features/auth/presentation/screens/auth_screen.dart';

void main() {
  runApp(const AuthApp());
}

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication App',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: CupertinoColors.systemBlue),
      ),
      themeMode: ThemeMode.dark,

      home: const AuthScreen(),
    );
  }
}