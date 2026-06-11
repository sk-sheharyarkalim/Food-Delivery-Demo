import 'dart:async';

import 'package:food_delivery/src/features/auth/domain/entities/user.dart';
import 'package:food_delivery/src/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:food_delivery/src/features/auth/domain/usecases/watch_auth_state_usecase.dart';
import 'package:get/get.dart';

enum SessionStatus { unknown, authenticated, unauthenticated }

class SessionController extends GetxController {
  SessionController({
    required GetCurrentUserUseCase getCurrentUser,
    required WatchAuthStateUseCase watchAuthState,
  })  : _getCurrentUser = getCurrentUser,
        _watchAuthState = watchAuthState;

  final GetCurrentUserUseCase _getCurrentUser;
  final WatchAuthStateUseCase _watchAuthState;
  StreamSubscription<AppUser?>? _authSub;

  final Rx<SessionStatus> status = SessionStatus.unknown.obs;
  final Rx<AppUser?> user = Rx<AppUser?>(null);

  bool get isAuthenticated => status.value == SessionStatus.authenticated;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    final result = await _getCurrentUser();
    result.fold(
      (_) => status.value = SessionStatus.unauthenticated,
      (u) {
        if (u != null) {
          user.value = u;
          status.value = SessionStatus.authenticated;
        } else {
          status.value = SessionStatus.unauthenticated;
        }
      },
    );

    _authSub = _watchAuthState().listen((u) {
      if (u != null) {
        user.value = u;
        status.value = SessionStatus.authenticated;
      } else {
        user.value = null;
        status.value = SessionStatus.unauthenticated;
      }
    });
  }

  @override
  void onClose() {
    _authSub?.cancel();
    super.onClose();
  }
}
