import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/auth/domain/entities/user.dart';
import 'package:food_delivery/src/features/auth/domain/repositories/auth_repository.dart';

/// Signs the user in with their Google account via Firebase Auth.
class SignInWithGoogleUseCase {
  const SignInWithGoogleUseCase(this._repository);

  final AuthRepository _repository;

  FutureEither<AppUser> call() => _repository.signInWithGoogle();
}
