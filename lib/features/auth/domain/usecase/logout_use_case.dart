import 'package:authapp/core/usecase/usecase.dart';
import 'package:authapp/features/auth/domain/usecase/get_current_user.dart';

import '../repository/auth_repository.dart';

class LogoutUseCase implements LocalAuthUseCase<void, NoParams> {
  final AuthRepository authRepository;

  LogoutUseCase({required this.authRepository});

  @override
  Future<void> call(NoParams params) async {
    await authRepository.logout();
  }

}