import 'dart:async';

import 'package:authapp/features/auth/domain/entity/user_entity.dart';
import 'package:authapp/features/auth/domain/usecase/user_sign_up.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUseCase _userSignUpUseCase;

  AuthBloc({required UserSignUpUseCase userSignUpUseCase})
    : _userSignUpUseCase = userSignUpUseCase,
      super(AuthInitial()) {
    on<AuthSignUpEvent>(onAuthSignUpEvent);
  }

  FutureOr<void> onAuthSignUpEvent(
    AuthSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    debugPrint(
      'emitted AuthLoadingState with email: ${event.email} & password: ${event.password}',
    );
    final res = await _userSignUpUseCase(
      UserSignUpParams(email: event.email, password: event.password),
    );

    res.fold(
      (failure) {
        debugPrint('User sign up failed with message: ${failure.message}');
        emit(AuthInitial());
        emit(AuthNotifyActionState(failure.message, isError: true));
        emit(AuthFailureActionState(failure.message));
      },
      (userEntity) {
        debugPrint('User signed up successfully with UID: $userEntity');
        emit(AuthNotifyActionState('User signed up successfully', isError: false));
        emit(AuthSuccessState(userEntity));
      }
    );
  }
}
