// signup_validation.dart

String? validateUsername(String? value) {
  if (value?.isEmpty ?? true) {
    return 'Please enter your username';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value?.isEmpty ?? true) {
    return 'Please enter your email';
  }

  // Basic email format validation using regular expression
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  if (!emailRegex.hasMatch(value!)) {
    return 'Invalid email format';
  }

  return null;
}

String? validatePassword(String? value) {
  if (value?.isEmpty ?? true) {
    return 'Please enter your password';
  }

  // Add any additional password validation logic here
  return null;
}

String? validateConfirmPassword(String? password, String? confirmPassword) {
  if (confirmPassword?.isEmpty ?? true) {
    return 'Please confirm your password';
  }

  if (password != confirmPassword) {
    return 'Passwords do not match';
  }

  return null;
}
