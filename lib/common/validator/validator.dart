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

  static String? validateDate(String? s) {
    if (s == null || s.isEmpty) {
      return "* Required";
    }
    if (!RegExp(r"^\d{4}-\d{2}-\d{2}$").hasMatch(s)) {
      return "Exp Date must be of format yyyy-MM-dd";
    }

    if (DateTime.tryParse(s) == null) {
      return "Please enter a valid date";
    }
    return null;
  }

  static String? validateEmail(String? s) {
    if (s == null || s.isEmpty) {
      return "* Required";
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(s)) {
      return "Please enter a valid email";
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
}
