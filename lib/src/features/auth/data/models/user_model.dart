import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:food_delivery/src/features/auth/domain/entities/user.dart';

/// Data-layer representation of an authenticated user, mapped from
/// [firebase_auth.User].
class UserModel extends AppUser {
  const UserModel({
    required super.id,
    required super.email,
    super.name,
    super.photoUrl,
  });

  factory UserModel.fromFirebaseUser(firebase_auth.User user) => UserModel(
        id: user.uid,
        email: user.email ?? '',
        name: user.displayName,
        photoUrl: user.photoURL,
      );

  AppUser toEntity() => AppUser(id: id, email: email, name: name, photoUrl: photoUrl);
}
