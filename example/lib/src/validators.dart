class validationMixin {
  String? validateName(String ? value) {
    String pattern = r'[A-Z]';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!) || value.isEmpty) {
      return 'Please enter a valid name';
    }
    return null;
  }

  String? validateVPA(String ? value) {
    if (!(value!.split('@').length == 2) || value.isEmpty) {
      return 'Please enter a valid UPI address';
    }
    return null;
  }

  String? validateAmt(String ? value) {
    String pattern = r'^[0-9]+$';
    RegExp regex = RegExp(pattern);
    if (/*!regex.hasMatch(pattern)||*/ value!.isEmpty) {
      return 'Please enter number only';
    }
    return null;
  }
}
