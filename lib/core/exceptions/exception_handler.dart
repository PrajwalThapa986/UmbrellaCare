import 'package:firebase_auth/firebase_auth.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:umbrella_care/core/exceptions/app_exceptions.dart';

class ExceptionHandler {
  ExceptionHandler._();

  static final ExceptionHandler _instance = ExceptionHandler._();

  factory ExceptionHandler() => _instance;

  static String parseError(dynamic e) {
    if (e is WeakPasswordException) {
      return "Password too weak";
    } else if (e is AccountAlreadyExistException) {
      return "Account already exists";
    } else if (e is FirebaseAuthException) {
      return "Firebase Exception : ${e.message}";
    } else {
      return e.toString();
    }
  }
}
