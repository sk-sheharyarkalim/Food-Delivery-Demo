import 'package:food_delivery/src/services/services.dart';
import 'package:food_delivery/src/utils/utils.dart';

import 'package:food_delivery/src/features/auth/domain/entities/user.dart';
import 'package:food_delivery/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService = AuthService.instance;

  @override
  Stream<AppUser?> get onAuthStateChanged {
    return _authService.authStateChanges.map((userModel) => userModel?.toEntity());
  }

  @override
  FutureEither<AppUser> signInWithGoogle() async {
    final result = await _authService.signInWithGoogle();
    return result.map((userModel) => userModel.toEntity());
  }

  @override
  FutureEitherVoid signOut() {
    return _authService.signOut();
  }

  @override
  FutureEither<AppUser?> getCurrentUser() async {
    final result = await _authService.getCurrentUser();
    return result.map((userModel) => userModel?.toEntity());
  }
}
