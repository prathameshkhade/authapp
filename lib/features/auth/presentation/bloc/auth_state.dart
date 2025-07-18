part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}
class AuthActionState extends AuthState {}

final class AuthInitial extends AuthState {}

// Normal states
class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;

  AuthSuccess(this.message);
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}

// Actionable states