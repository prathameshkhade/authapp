import 'package:authapp/features/auth/presentation/widgets/auth_button.dart';
import 'package:authapp/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  static route() => CupertinoPageRoute(builder: (context) => const SigninScreen());

  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
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
                Text('Sign In', style: theme.textTheme.displaySmall),

                // Email field
                AuthField(label: 'email', controller: emailController),

                // Password field
                AuthField(label: 'password', controller: passwordController, isObsecureText: true,),

                // Signup button
                AuthButton(
                  onPressed: () => {

                  },
                  child: Text('Sign In', style: theme.textTheme.titleSmall),
                ),

                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account. ',
                      style: theme.textTheme.bodySmall,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign up',
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
        ),
      ),
    );
  }
}
