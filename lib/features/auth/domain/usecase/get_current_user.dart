import 'package:authapp/core/usecase/usecase.dart';
import 'package:authapp/features/auth/domain/entity/user_entity.dart';
import 'package:authapp/features/auth/domain/repository/auth_repository.dart';

class GetCurrentUserUseCase implements LocalAuthUseCase<UserEntity?, NoParams> {
  final AuthRepository authRepository;

  GetCurrentUserUseCase({required this.authRepository});

  @override
  Future<UserEntity?> call(NoParams params) async {
    return await authRepository.getCurrentUser();
  }
}

class NoParams {}
