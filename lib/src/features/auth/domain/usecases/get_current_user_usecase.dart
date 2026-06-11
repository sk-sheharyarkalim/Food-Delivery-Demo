import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/auth/domain/entities/user.dart';
import 'package:food_delivery/src/features/auth/domain/repositories/auth_repository.dart';

/// Returns the currently authenticated user, or null if signed out.
class GetCurrentUserUseCase {
  const GetCurrentUserUseCase(this._repository);

  final AuthRepository _repository;

  FutureEither<AppUser?> call() => _repository.getCurrentUser();
}
