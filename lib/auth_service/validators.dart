class Validators {
  static bool validateFields(
      {required String name,
      required String phone,
      required String email,
      required String password,
      required String confirmPassword}) {
    // Check if name is empty
    if (name.isEmpty) {
      return false;
    } else if (name.length < 4) {
      return false;
    }

    // Check if phone is empty
    if (phone.isEmpty) {
      return false;
    } else if (!RegExp(r"^03\d{9}$").hasMatch(phone) &&
        !RegExp(r"^\+92\d{10}$").hasMatch(phone)) {
      return false;
    }

    // Check if email is empty
    if (email.isEmpty) {
      false;
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email)) {
      return false;
    }

    // Check if password is empty
    if (password.isEmpty) {
      return false;
    } else if (password.length < 8 ||
        !RegExp(r'[A-Z]').hasMatch(password) ||
        !RegExp(r'[a-z]').hasMatch(password) ||
        !RegExp(r'[0-9]').hasMatch(password) ||
        !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return false;
    }
    if (password != confirmPassword) {
      false;
    }
    // All validations passed
    return true;
  }
}
