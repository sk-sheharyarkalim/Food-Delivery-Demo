import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:food_delivery/src/features/auth/data/models/user_model.dart';

import '../config/app_config.dart';
import '../utils/utils.dart';

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  FirebaseAuth get _firebaseAuth => AppConfig.firebaseAuth;
  GoogleSignIn get _googleSignIn => GoogleSignIn.instance;

  /// Stream of auth state changes. Emits the current user or null.
  Stream<UserModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((User? user) {
      return user == null ? null : UserModel.fromFirebaseUser(user);
    });
  }

  /// Signs the user in with their Google account and exchanges the Google
  /// credential for a Firebase session.
  FutureEither<UserModel> signInWithGoogle() async {
    return runTask(() async {
      final account = await _googleSignIn.authenticate();
      final credential = GoogleAuthProvider.credential(
        idToken: account.authentication.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) {
        throw Exception('Google sign-in failed: user record not found');
      }

      await AppConfig.firestore.collection('users').doc(user.uid).set({
        'displayName': user.displayName,
        'email': user.email,
        'photoUrl': user.photoURL,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      return UserModel.fromFirebaseUser(user);
    }, requiresNetwork: true);
  }

  FutureEitherVoid signOut() async {
    return runTask(() async {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
    }, requiresNetwork: true);
  }

  FutureEither<UserModel?> getCurrentUser() async {
    return runTask(() async {
      final user = _firebaseAuth.currentUser;
      return user == null ? null : UserModel.fromFirebaseUser(user);
    });
  }

  void dispose() {
    // Firebase manages its own streams
  }
}
