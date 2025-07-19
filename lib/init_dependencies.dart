import 'package:authapp/features/auth/data/datasource/remote_data_source.dart';
import 'package:authapp/features/auth/data/datasource/supabase_data_source_impl.dart';
import 'package:authapp/features/auth/data/repository/auth_repository.dart';
import 'package:authapp/features/auth/domain/repository/auth_repository.dart';
import 'package:authapp/features/auth/domain/usecase/user_sign_in.dart';
import 'package:authapp/features/auth/domain/usecase/user_sign_up.dart';
import 'package:authapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/config/app_secrets.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<RemoteDataSource>(
    () => SupabaseRemoteDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => UserSignUpUseCase(authRepository: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => UserSignInUseCase(authRepository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      userSignUpUseCase: serviceLocator(),
      userSignInUseCase: serviceLocator(),
    ),
  );
}
