part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}
class AuthActionState extends AuthState {}

final class AuthInitial extends AuthState {}

// Normal states
class AuthLoadingState extends AuthState {}

class AuthLoginSuccessActionState extends AuthActionState {
  final UserEntity userEntity;
  AuthLoginSuccessActionState(this.userEntity);
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

class AuthAlreadyLoggedInActionState extends AuthLoginSuccessActionState {
  AuthAlreadyLoggedInActionState(super.userEntity);
}

class AuthLoggedOutActionState extends AuthActionState {}

// returns the failure with message
class LocalAuthFailedActionState extends AuthActionState {
  final Failure failure;
  LocalAuthFailedActionState(this.failure);
}

class LocalAuthActionState extends AuthActionState {
  final bool didAuthenticate;
  LocalAuthActionState(this.didAuthenticate);
}
