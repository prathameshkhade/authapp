import 'package:authapp/core/errors/failures.dart';
import 'package:authapp/features/auth/domain/entity/user_entity.dart';
import 'package:authapp/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';


import '../../../../core/usecase/usecase.dart';

class UserLoginUseCaseParams {
  final String email;
  final String password;

  UserLoginUseCaseParams(this.email, this.password);
}

class UserLoginUseCase implements UseCase<UserEntity, UserLoginUseCaseParams> {
  final AuthRepository authRepository;

  UserLoginUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(
    UserLoginUseCaseParams params,
  ) async {
    return await authRepository.signInWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}
