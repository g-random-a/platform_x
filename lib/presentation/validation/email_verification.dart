class Validators {
  String? isEmailValid(String? email) {
    if (email == "" || email == null) {
      return "Email address is required";
    }
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    bool value = emailRegex.hasMatch(email);

    if (!value) {
      return "please enter valid email address";
    }
    return null;
  }

  String? isNameValid(String? name) {
    // Check if the name contains only letters (uppercase or lowercase)
    if (name == '' || name == null) return 'name is required';
    final nameRegex = RegExp(r'^[a-zA-Z]+$');

    bool value = nameRegex.hasMatch(name);

    return value ? null : 'please enter valid name.';
  }

  String? isPasswordValid(String? psd) {
    // Check if the psd contains only letters (uppercase or lowercase)
    if (psd == '' || psd == null) return 'password is required';

    return null;
  }

  String? isOTPValid(String? otp) {
    // Check if the psd contains only letters (uppercase or lowercase)
    if (otp == '' || otp == null) return 'otp is required';
    return null;
  }
}
