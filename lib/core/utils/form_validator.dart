class FormValidator {
  static String? validateEmptyField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "$fieldName must not be empty!";
    } else {
      return null;
    }
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter field is required!";
    }
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (emailValid == false) {
      return "Enter a valid email address!";
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required!";
    } else if (value.length < 8) {
      return "Password should be at least 8 characters long!";
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(
    String? value,
    String password,
  ) {
    if (value == null || value.isEmpty) {
      return "Confirm Password is required!";
    } else if (value != password) {
      return "Confirm Password must be same as Password!";
    } else {
      return null;
    }
  }
}
