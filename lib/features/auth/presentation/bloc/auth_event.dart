part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignUpEvent({required this.email, required this.password});
}

class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignInEvent({required this.email, required this.password});
}

/// To check if user is authenticated or not?
class AuthCheckUserLoggedInEvent extends AuthEvent {}

// Logout the current session
class AuthLogoutEvent extends AuthEvent {}

// request for local auth and returns the user if authenticated
class AuthLoginWithBiometricsRequested extends AuthEvent {
  // final UserEntity user;
  // AuthLoginWithBiometricsRequested(this.user);
}