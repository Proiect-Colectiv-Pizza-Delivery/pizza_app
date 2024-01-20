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

  static String? validatePositiveDouble(String? s) {
    if (s == null || s.isEmpty) {
      return "* Required";
    }
    try {
      double res = double.parse(s);
      if (res < 0) {
        return "Number must be greater than 0";
      }
    } catch (e) {
      return "Must be an number";
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

  static String? validateName(String? s) {
    if (s == null || s.isEmpty) {
      return "* Required";
    }
    if (!RegExp(r"^[a-zA-Z]+(?:[-'’][a-zA-Z]+)*$").hasMatch(s)) {
      return "First name may only contain ascii letters and -, ' and ’ characters";
    }
    return null;
  }

  static String? validateUsername(String? s) {
    if (s == null || s.isEmpty) {
      return "* Required";
    }
    if (!RegExp(r"\w*").hasMatch(s)) {
      return "Username may only contain ascii letters and underscore (_).";
    }
    return null;
  }

  static String? validatePhoneNumber(String? s) {
    if (s == null || s.isEmpty) {
      return "* Required";
    }
    if (!RegExp(r"^\b0\d{9}\b$").hasMatch(s) &&
        !RegExp(r"^\+\d{11}$").hasMatch(s)) {
      return "Please enter a valid phone number";
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

  static String? validateConfirmPass(
      String? s, String? s1,) {
    String? message = validatePass(s);
    if (message != null) {
      return message;
    }
    if (s != s1) {
      return "Confirmation password do not match.";
    }
    return null;
  }
}