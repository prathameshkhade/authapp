import 'package:authapp/core/errors/failures.dart';
import 'package:authapp/core/errors/server_exception.dart';
import 'package:authapp/features/auth/data/datasource/remote_data_source.dart';
import 'package:authapp/features/auth/domain/entity/user_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signInWithEmailPassword(
        email: email,
        password: password,
      );

      return Either.right(user);
    }
    on ServerException catch (e) {
      return Either.left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signUpWithEmailPassword(
        email: email,
        password: password,
      );

      return Either.right(user);
    } on ServerException catch (e) {
      return Either.left(Failure(e.message));
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return await remoteDataSource.getCurrentUser();
  }
}
