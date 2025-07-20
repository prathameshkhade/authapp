import 'package:authapp/core/errors/server_exception.dart';
import 'package:authapp/features/auth/data/datasource/remote_data_source.dart';
import 'package:authapp/features/auth/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRemoteDataSourceImpl implements RemoteDataSource {
  final SupabaseClient supabaseClient;

  // Add a getter for the current user session.
  Session? get currentUserSession => supabaseClient.auth.currentSession;

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

      if (response.user == null || response.session == null) {
        throw ServerException('Invalid credentials');
      }

      // Verify session is active
      if (currentUserSession == null) {
        throw ServerException('Authentication failed - No active session');
      }

      final userModel = UserModel.fromJson(response.user!.toJson());
      return userModel;
    }
    catch (e) {
      throw ServerException(e.toString());
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

      if (response.user == null || response.session == null) {
        throw ServerException('Sign up failed');
      }

      return UserModel.fromJson(response.user!.toJson());
    }
    catch (e) {
      throw ServerException('Sign up failed: $e');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    debugPrint(supabaseClient.auth.currentUser!.toJson().toString());
    final user = UserModel.fromJson(supabaseClient.auth.currentUser!.toJson());
    debugPrint(user.toString());
    return user;
  }
}
