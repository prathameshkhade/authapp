import 'dart:async';

import 'package:authapp/features/auth/domain/usecase/user_sign_up.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUseCase _userSignUpUseCase;

  AuthBloc(UserSignUpUseCase userSignUpUseCase)
    : _userSignUpUseCase = userSignUpUseCase,
      super(AuthInitial()) {
    on<AuthSignUpEvent>(onAuthSignUpEvent);
  }

  FutureOr<void> onAuthSignUpEvent(
    AuthSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _userSignUpUseCase(
      UserSignUpParams(email: event.email, password: event.password),
    );

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (uid) => emit(AuthSuccess(uid)),
    );
  }
}
