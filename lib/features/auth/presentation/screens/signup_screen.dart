import 'package:authapp/core/common/loader.dart';
import 'package:authapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:authapp/features/auth/presentation/screens/signin_screen.dart';
import 'package:authapp/features/auth/presentation/widgets/auth_button.dart';
import 'package:authapp/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        buildWhen: (previous, current) => current is! AuthActionState,
        listenWhen: (previous, current) => current is AuthActionState,
        listener: (context, state) {
          if (state is AuthNotifyActionState) {
            if (!state.isError) {
              emailController.clear();
              passwordController.clear();
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: state.isError ? Colors.red : Colors.green,
              ),
            );
          }
          else if (state is AuthSuccessActionState) {
            // Navigate to Login
            Future.delayed(const Duration(milliseconds: 300));
            Navigator.push(context, SigninScreen.route());
          }
        },
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Loader();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Title
                  Text('Sign Up', style: theme.textTheme.displaySmall),
                  const SizedBox(height: 25),

                  // Email field
                  AuthField(label: 'email', controller: emailController),
                  const SizedBox(height: 25),

                  // Password field
                  AuthField(
                    label: 'password',
                    controller: passwordController,
                    isObsecureText: true,
                  ),
                  const SizedBox(height: 25),

                  // Signup button
                  AuthButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        debugPrint('${emailController.text}, ${passwordController.text}');
                        context.read<AuthBloc>().add(
                          AuthSignUpEvent(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ),
                        );
                      }
                    },
                    child: Text('Sign Up', style: theme.textTheme.titleSmall),
                  ),
                  const SizedBox(height: 25),

                  GestureDetector(
                    onTap: () => Navigator.push(context, SigninScreen.route()),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account. ',
                        style: theme.textTheme.bodySmall,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign In',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}