import 'package:authapp/features/auth/domain/entity/user_entity.dart';
import 'package:authapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:authapp/features/auth/presentation/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalAuthScreen extends StatelessWidget {
  static route(UserEntity u) =>
      CupertinoPageRoute(builder: (context) => LocalAuthScreen(user: u));

  final UserEntity user;

  const LocalAuthScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Logout'),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            context.read<AuthBloc>().add(AuthLogoutEvent());
          },
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) => current is AuthActionState,
        listener: (context, state) {
          if (state is AuthLoggedOutActionState) {
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(builder: (context) => const SignupScreen()),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
              const SizedBox(height: 20),
              Text(user.email, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(
                user.id.split('-').first, // Displaying a part of the ID
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.fingerprint),
                  label: const Text('Login with biometric'),
                  onPressed: () {
                    // context.read<AuthBloc>().add(AuthLoginWithBiometrics());
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
