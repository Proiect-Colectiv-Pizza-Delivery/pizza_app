class Validator {
  static String? validateEmpty(String? s) {
    if (s == null || s.isEmpty) {
      return "* Required";
    }
    return null;
  }

  static String? validatePrice(String? s) {
    if (s == null || s.isEmpty) {
      return "* Required";
    }
    try {
      int.parse(s);
    } catch (e) {
      return "Must be a integer";
    }

    return null;
  }

  static String? validatePositiveInt(String? s) {
    if (s == null || s.isEmpty) {
      return "* Required";
    }
    try {
      int res = int.parse(s);
      if (res < 0) {
        return "Integer must be greater than 0";
      }
    } catch (e) {
      return "Must be an integer";
    }

    return null;
  }

  static String? validateEmail(String? s) {
    if (s == null || s.isEmpty) {
      return "* Required";
    }
    bool emailValid = RegExp(r"^\S+@\S+\.\S+$").hasMatch(s);
    if (!emailValid) {
      return "Please enter a valid email address.";
    }
    return null;
  }

  static String? validatePass(String? s) {
    if (s == null || s.isEmpty) {
      return "* Required";
    }
    const String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])((?=.*?[\^$*.\[\]{}()?"!@#%&/\\,><:;|_~`=+-])|'
        r"(?=.*?['])).{8,64}$";
    RegExp passwordRegex = RegExp(pattern);
    if (!passwordRegex.hasMatch(s)) {
      return "Password must contain one uppercase and lowercase letter, one special character and one number.";
    } else {
      return null;
    }
  }
}
