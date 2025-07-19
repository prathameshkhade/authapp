import 'package:authapp/core/errors/server_exception.dart';
import 'package:authapp/features/auth/data/datasource/remote_data_source.dart';
import 'package:authapp/features/auth/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRemoteDataSourceImpl implements RemoteDataSource {
  final SupabaseClient supabaseClient;

  SupabaseRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw ServerException('Sign in failed');
      }
      final userModel = UserModel.fromJson(response.user!.toJson());
      debugPrint('User model: $userModel');
      return userModel;
    }
    catch (e) {
      throw ServerException('Sign in failed: $e');
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Sign up failed');
      }

      return UserModel.fromJson(response.user!.toJson());
    }
    catch (e) {
      throw ServerException('Sign up failed: $e');
    }
  }
}
