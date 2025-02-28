class AppExceptions implements Exception {
  AppExceptions(this.message, {required this.prefix});

  final String message;
  final String prefix;
}

class AccountAlreadyExistException extends AppExceptions {
  AccountAlreadyExistException(String message)
      : super(message, prefix: "Firebase Exception : ");
}

class WeakPasswordException extends AppExceptions {
  WeakPasswordException(String message)
      : super(message, prefix: "Firebase Exception : ");
}
