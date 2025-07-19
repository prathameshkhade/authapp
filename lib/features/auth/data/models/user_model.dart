import 'package:authapp/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(super.id, super.email);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(json['id'] ?? '', json['email'] ?? '');
  }
}
