class UserEntity {
  final String id;
  final String email;

  UserEntity(this.id, this.email);

  @override
  String toString() {
    return 'UserEntity(id: $id, email: $email)';
  }
}