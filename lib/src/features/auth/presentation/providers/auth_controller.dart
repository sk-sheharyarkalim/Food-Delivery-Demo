import 'package:food_delivery/src/imports/core_imports.dart';

import 'package:food_delivery/src/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:food_delivery/src/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  AuthController({
    required SignInWithGoogleUseCase signInWithGoogle,
    required SignOutUseCase signOut,
  })  : _signInWithGoogle = signInWithGoogle,
        _signOut = signOut;

  final SignInWithGoogleUseCase _signInWithGoogle;
  final SignOutUseCase _signOut;

  final status = AppStatus.initial.obs;

  Future<void> signInWithGoogle() async {
    status.value = AppStatus.loading;

    final result = await _signInWithGoogle();
    result.fold(
      (failure) {
        status.value = AppStatus.failure;
        showGlobalToast(message: failure.message, status: 'error');
      },
      (user) {
        status.value = AppStatus.success;
        Get.offAllNamed<void>(AppRoutes.dashboard);
      },
    );
  }

  Future<void> signOut() async {
    status.value = AppStatus.loading;

    final result = await _signOut();
    result.fold(
      (failure) {
        status.value = AppStatus.failure;
        showGlobalToast(message: failure.message, status: 'error');
      },
      (_) {
        status.value = AppStatus.initial;
        Get.offAllNamed<void>(AppRoutes.login);
      },
    );
  }
}
