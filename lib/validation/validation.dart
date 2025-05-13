
class Validators {

  ///First name Validation
  static String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'First name is required';
    }

    final nameRegex = RegExp(r'^[A-Z][a-zA-Z]*$');

    if (!nameRegex.hasMatch(value)) {
      return 'First letter must be capital and only letters allowed';
    }

    return null; // valid
  }

  /// Last name Validation
  static String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Last name is required';
    }

    final nameRegex = RegExp(r'^[A-Z][a-zA-Z]*$');

    if (!nameRegex.hasMatch(value)) {
      return 'First letter must be capital and only letters allowed';
    }

    return null;
  }


  /// Date Validation
  static String? validateDateOfBirth(DateTime? dob) {
    if (dob == null) {
      return 'Date of birth is required';
    }

    final today = DateTime.now();
    final age = today.year - dob.year - ((today.month < dob.month || (today.month == dob.month && today.day < dob.day)) ? 1 : 0);

    if (age < 13) {
      return 'You must be at least 13 years old';
    }

    return null;
  }

  ///UserName
  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }
    return null; // valid
  }

  ///Password

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');

    if (!passwordRegex.hasMatch(value)) {
      return 'Password must be 8+ characters,\ninclude upper/lowercase, number & symbol';
    }

    return null;
  }

  ///ConfirmPassword
  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }



}
