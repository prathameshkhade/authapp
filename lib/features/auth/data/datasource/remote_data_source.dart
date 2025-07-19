import 'package:authapp/features/auth/data/models/user_model.dart';

abstract interface class RemoteDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  });
}
