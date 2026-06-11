class AppValidations {
  static String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty || value.length < 3) {
      return "Name can't be less than 3 characters";
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null ||
        value.trim().isEmpty ||
        value.length < 3 ||
        !(value.contains("@"))) {
      return "Invalid Email";
    }
    return null;
  }

  static String? phoneNumberValidator(String? value) {
    if (value == null || value.trim().isEmpty || value.length < 11) {
      return "Invalid Phone Number";
    }
    return null;
  }

  static String? descibeValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Must Describe Your Feel..";
    }
    return null;
  }

  static String? addressValidator(String? value) {
    if (value == null || value.trim().isEmpty || value.length < 3) {
      return "Invalid Address";
    }
    return null;
  }

  static String? passwordValidator({String? value}) {
    if (value == null || value.trim().isEmpty || value.length < 8) {
      return "Password Can't be less than 8 characters";
    }
    return null;
  }

  static String? confirmPasswordValidator({
    String? value,
    required String password,
  }) {
    if (value != password) {
      return "Not Matched For Password";
    }
    return null;
  }
}
