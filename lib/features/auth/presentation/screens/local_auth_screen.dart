import 'package:authapp/features/auth/domain/entity/user_entity.dart';
import 'package:authapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:authapp/features/auth/presentation/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home.dart';

class LocalAuthScreen extends StatefulWidget {
  static route(UserEntity u) =>
      CupertinoPageRoute(builder: (context) => LocalAuthScreen(user: u));

  final UserEntity user;

  const LocalAuthScreen({super.key, required this.user});

  @override
  State<LocalAuthScreen> createState() => _LocalAuthScreenState();
}

class _LocalAuthScreenState extends State<LocalAuthScreen> {
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthLoginWithBiometricsRequested());
  }

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
      body: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (previous, current) => current is AuthActionState,
        buildWhen: (previous, current) => current is! AuthActionState,
        listener: (context, state) {
          if (state is AuthLoggedOutActionState) {
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(builder: (context) => const SignupScreen()),
            );
          }
          else if (state is LocalAuthActionState) {
            if (state.didAuthenticate) {
              Navigator.pushReplacement(context, Home.route());
            }
            else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error authentication.'),
                  backgroundColor: Colors.red,
                )
              );
            }
          }
          else if (state is LocalAuthFailedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error authentication.'),
                backgroundColor: Colors.red,
              )
            );
            setState(() {
              errorMessage = state.failure.message;
            });
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person, size: 50),
                ),
                const SizedBox(height: 20),

                Text(widget.user.email, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),

                Text(
                  widget.user.id.split('-').first, // Displaying a part of the ID
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
                      context.read<AuthBloc>().add(AuthLoginWithBiometricsRequested());
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

                if(errorMessage.isNotEmpty) ...<Widget>[
                  Container(
                    // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border(left: BorderSide(color: Colors.red, width: 8))
                    ),
                    child: Text(
                      errorMessage,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  )
                ]
              ],
            ),
          );
        }
      ),
    );
  }
}
