import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  /// Stream of auth state changes. Emits AppUser when authenticated, null when not.
  Stream<AppUser?> get onAuthStateChanged;

  /// Sign in with a Google account via Firebase Auth.
  FutureEither<AppUser> signInWithGoogle();

  /// Sign out the current user.
  FutureEitherVoid signOut();

  /// Returns the currently authenticated user, or null if signed out.
  FutureEither<AppUser?> getCurrentUser();
}
