import 'package:authapp/features/auth/data/datasource/remote_data_source.dart';
import 'package:authapp/features/auth/data/datasource/supabase_data_source_impl.dart';
import 'package:authapp/features/auth/data/repository/auth_repository.dart';
import 'package:authapp/features/auth/domain/repository/auth_repository.dart';
import 'package:authapp/features/auth/domain/usecase/get_current_user.dart';
import 'package:authapp/features/auth/domain/usecase/logout_use_case.dart';
import 'package:authapp/features/auth/domain/usecase/user_sign_in.dart';
import 'package:authapp/features/auth/domain/usecase/user_sign_up.dart';
import 'package:authapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:authapp/secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/config/app_secrets.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
    authOptions: FlutterAuthClientOptions(
      localStorage: SecureStorage()
    )
  );
  sl.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  sl
    // datasource
    ..registerFactory<RemoteDataSource>(
      () => SupabaseRemoteDataSourceImpl(sl()),
    )
    // auth repo
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()),
    )
    // Usecase
    ..registerFactory(() => UserSignUpUseCase(authRepository: sl()))
    ..registerFactory(() => UserSignInUseCase(authRepository: sl()))
    ..registerFactory(() => GetCurrentUserUseCase(authRepository: sl()))
    ..registerFactory(() => LogoutUseCase(authRepository: sl()))
    // bloc
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        userSignUpUseCase: sl(),
        userSignInUseCase: sl(),
        getCurrentUseCase: sl(),
        logoutUseCase: sl(),
      ),
    );
}
