import 'package:authapp/core/errors/failures.dart';
import 'package:authapp/core/usecase/usecase.dart';
import 'package:authapp/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Represents the parameters required for user sign-up.
class UserSignUpParams {
  final String email;
  final String password;

  UserSignUpParams({required this.email, required this.password});
}

class UserSignUpUseCase implements UseCase<String, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUpUseCase({required this.authRepository});

  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}
