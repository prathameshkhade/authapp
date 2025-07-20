import 'dart:async';

import 'package:authapp/features/auth/domain/entity/user_entity.dart';
import 'package:authapp/features/auth/domain/usecase/get_current_user.dart';
import 'package:authapp/features/auth/domain/usecase/logout_use_case.dart';
import 'package:authapp/features/auth/domain/usecase/user_sign_in.dart';
import 'package:authapp/features/auth/domain/usecase/user_sign_up.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUseCase _userSignUpUseCase;
  final UserSignInUseCase _userSignInUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthBloc({
    required UserSignUpUseCase userSignUpUseCase,
    required UserSignInUseCase userSignInUseCase,
    required GetCurrentUserUseCase getCurrentUseCase,
    required LogoutUseCase logoutUseCase,
  }) : _userSignUpUseCase = userSignUpUseCase,
       _userSignInUseCase = userSignInUseCase,
       _getCurrentUserUseCase = getCurrentUseCase,
       _logoutUseCase = logoutUseCase,
       super(AuthInitial()) {
    on<AuthSignUpEvent>(_onAuthSignUpEvent);
    on<AuthSignInEvent>(_onAuthSignInEvent);
    on<AuthCheckUserLoggedInEvent>(_onAuthCheckUserLoggedInEvent);
    on<AuthLogoutEvent>(_onAuthLogoutEvent);
  }

  FutureOr<void> _onAuthSignUpEvent(
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
        emit(
          AuthNotifyActionState('User signed up successfully!', isError: false),
        );
        emit(AuthLoginSuccessActionState(userEntity));
      },
    );
  }

  FutureOr<void> _onAuthSignInEvent(
    AuthSignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final res = await _userSignInUseCase(
      UserSignInUseCaseParams(event.email, event.password),
    );

    res.fold(
      (failure) {
        emit(AuthInitial());
        emit(AuthNotifyActionState(failure.message, isError: true));
        emit(AuthFailureActionState(failure.message));
      },
      (user) {
        emit(AuthNotifyActionState('Successfully signed in!', isError: false));
        emit(AuthLoginSuccessActionState(user));
      },
    );
  }

  FutureOr<void> _onAuthCheckUserLoggedInEvent(
    AuthCheckUserLoggedInEvent event,
    Emitter<AuthState> emit,
  ) async {
    // emit(AuthLoadingState());
    final user = await _getCurrentUserUseCase(NoParams());
    if (user != null) {
      Future.delayed(const Duration(milliseconds: 250));
      emit(AuthAlreadyLoggedInActionState(user));
    }
  }

  FutureOr<void> _onAuthLogoutEvent(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _logoutUseCase(NoParams());
    emit(AuthLoggedOutActionState());
  }
}
