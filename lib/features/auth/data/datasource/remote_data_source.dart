abstract interface class RemoteDataSource {
  Future<String> signUpWithEmailPassword({
    required String email,
    required String password,
  });

  Future<String> signInWithEmailPassword({
    required String email,
    required String password,
  });
}
