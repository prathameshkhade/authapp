part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}
class AuthActionState extends AuthState {}

final class AuthInitial extends AuthState {}

// Normal states
class AuthLoadingState extends AuthState {}

class AuthSuccessActionState extends AuthActionState {
  final UserEntity userEntity;
  AuthSuccessActionState(this.userEntity);
}

// Actionable states
class AuthFailureActionState extends AuthActionState {
  final String message;
  AuthFailureActionState(this.message);
}

class AuthNotifyActionState extends AuthActionState {
  final String message;
  final bool isError;
  AuthNotifyActionState(this.message, {this.isError = false});
}
