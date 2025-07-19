import 'package:authapp/core/errors/failures.dart';
import 'package:authapp/features/auth/domain/entity/user_entity.dart';
import 'package:authapp/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/usecase/usecase.dart';

class UserSignInUseCaseParams {
  final String email;
  final String password;

  UserSignInUseCaseParams(this.email, this.password);
}

class UserSignInUseCase implements UseCase<UserEntity, UserSignInUseCaseParams> {
  final AuthRepository authRepository;

  UserSignInUseCase({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> call(
    UserSignInUseCaseParams params,
  ) async {
    return await authRepository.signInWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}
