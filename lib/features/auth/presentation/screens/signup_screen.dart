import 'package:authapp/features/auth/presentation/screens/widgets/auth_button.dart';
import 'package:authapp/features/auth/presentation/screens/widgets/auth_field.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 25,
              children: <Widget>[
                // Title
                Text('Sign Up', style: theme.textTheme.displaySmall),

                // Email field
                AuthField(label: 'email', controller: emailController),

                // Password field
                AuthField(label: 'password', controller: passwordController, isObsecureText: true,),

                // Signup button
                AuthButton(
                  onPressed: () => {

                  },
                  child: Text('Sign Up', style: theme.textTheme.titleSmall),
                ),

                RichText(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
