import 'package:authapp/core/errors/failures.dart';
import 'package:authapp/core/errors/server_exception.dart';
import 'package:authapp/features/auth/data/datasource/remote_data_source.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> signInWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement signInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userId = await remoteDataSource.signInWithEmailPassword(
        email: email,
        password: password,
      );

      return Either.right(userId);
    } on ServerException catch (e) {
      return Either.left(Failure(e.message));
    }
  }
}
