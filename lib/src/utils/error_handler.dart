import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppErrorHandler {
  static String format(Object? error) {
    if (error == null) return 'An unexpected error occurred';
    if (error is String) return error;
    if (error is FirebaseAuthException) return error.message ?? error.code;
    if (error is FirebaseException) return error.message ?? error.code;
    if (error is DioException) return error.message ?? error.toString();
    return error.toString();
  }
}
