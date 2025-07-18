import 'package:authapp/core/config/app_secrets.dart';
import 'package:authapp/core/config/theme.dart';
import 'package:authapp/features/auth/data/datasource/supbase_data_source_impl.dart';
import 'package:authapp/features/auth/data/repository/auth_repository.dart';
import 'package:authapp/features/auth/domain/usecase/user_sign_up.dart';
import 'package:authapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:authapp/features/auth/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            userSignUpUseCase: UserSignUpUseCase(
              authRepository: AuthRepositoryImpl(
                remoteDataSource: SupabaseRemoteDataSourceImpl(supabase.client),
              ),
            ),
          ),
        ),
      ],
      child: const AuthApp(),
    ),
  );
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