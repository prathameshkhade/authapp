import 'package:authapp/core/errors/server_exception.dart';
import 'package:authapp/features/auth/data/datasource/remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRemoteDataSourceImpl implements RemoteDataSource {
  final SupabaseClient supabaseClient;

  SupabaseRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<String> signInWithEmailPassword({required String email, required String password}) {
    // TODO: implement signInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword({required String email, required String password}) async {
    try {
      final res = await supabaseClient.auth.signUp(
        email: email,
        password: password
      );

      if (res.user == null) throw ServerException('User is null');
      return res.user!.id;
    }
    catch (e) {
      throw ServerException(e.toString());
    }
  }

}
