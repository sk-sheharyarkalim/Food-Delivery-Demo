import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/auth/domain/repositories/auth_repository.dart';

/// Signs the current user out.
class SignOutUseCase {
  const SignOutUseCase(this._repository);

  final AuthRepository _repository;

  FutureEitherVoid call() => _repository.signOut();
}
