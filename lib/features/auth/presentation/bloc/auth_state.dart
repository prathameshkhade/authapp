part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthActionState extends AuthState {}

final class AuthInitial extends AuthState {}

// Normal states
class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final UserEntity userEntity;
  AuthSuccessState(this.userEntity);
}

class AuthFailureActionState extends AuthActionState {
  final String message;
  AuthFailureActionState(this.message);
}

// Actionable states
class AuthNotifyActionState extends AuthActionState {
  final String message;
  final bool isError;

  AuthNotifyActionState(this.message, {this.isError = false});
}
