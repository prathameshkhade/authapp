part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}
class AuthActionState extends AuthState {}

final class AuthInitial extends AuthState {}

// Normal states
class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final String message;
  AuthSuccessState(this.message);
}

class AuthFailureState extends AuthState {
  final String message;
  AuthFailureState(this.message);
}

// Actionable states