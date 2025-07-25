import 'package:authapp/core/errors/failures.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';

import 'package:local_auth/local_auth.dart';

import '../../domain/repository/auth_repository.dart';


class LocalAuthRepositoryImpl implements LocalAuthRepository {
  final LocalAuthentication _localAuth;

  LocalAuthRepositoryImpl(this._localAuth);

@override
  Future<Either<Failure, bool>> authenticate() async {
    try {
      // First check if device supports biometrics
      final isSupported = await _localAuth.isDeviceSupported();
      if (!isSupported) {
        return Either.left(Failure('Device does not support biometric authentication'));
      }

      // Check available biometrics
      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      if (availableBiometrics.isEmpty) {
        return Either.left(Failure('No biometrics enrolled. Please set up fingerprint or face recognition in device settings'));
      }

      // Attempt authentication
      final didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to access the app',
        options: const AuthenticationOptions(
          useErrorDialogs: true, // Show system dialogs
          stickyAuth: true, // Prevent auth dialog dismissal
          biometricOnly: false // Force biometric auth
        )
      );

      return Either.right(didAuthenticate);
    }
    on PlatformException catch (e) {
      return Either.left(Failure(e.message.toString()));
    }
    catch (e) {
      return Either.left(Failure(e.toString()));
    }
  }
}