import 'package:food_delivery/src/features/auth/domain/entities/user.dart';
import 'package:food_delivery/src/features/auth/domain/repositories/auth_repository.dart';

/// Streams auth state changes — emits the signed-in user, or null when signed out.
class WatchAuthStateUseCase {
  const WatchAuthStateUseCase(this._repository);

  final AuthRepository _repository;

  Stream<AppUser?> call() => _repository.onAuthStateChanged;
}
