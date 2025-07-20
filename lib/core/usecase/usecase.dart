import 'package:fpdart/fpdart.dart';
import '../errors/failures.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

abstract interface class LocalAuthUseCase<SuccessType, Params> {
  Future<SuccessType> call(Params params);
}