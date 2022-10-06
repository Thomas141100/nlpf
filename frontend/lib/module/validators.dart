import 'package:flutter/foundation.dart';
import 'package:form_validator/form_validator.dart';

class Validators {
  static String? Function(String?) emailValidator() {
    if (kDebugMode) {
      return ValidationBuilder().minLength(1).maxLength(50).build();
    }
    return ValidationBuilder().email().maxLength(50).build();
  }

  static String? Function(String?) passwordValidator() {
    if (kDebugMode) {
      return ValidationBuilder().minLength(1).maxLength(50).build();
    }
    return ValidationBuilder()
        .regExp(RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"),
            "Password must have a minimum eight characters, at least one letter and one number")
        .maxLength(50)
        .build();
  }

  static String? Function(String?) generalValidator() {
    return ValidationBuilder().minLength(1).maxLength(25).build();
  }

  static firstnamelValidator() {
    if (kDebugMode) {
      return ValidationBuilder().minLength(1).maxLength(50).build();
    }
    return ValidationBuilder()
        .regExp(RegExp(r"^([A-Z])[a-z]+(-)?[a-z]+$"),
            "Names must contains only letters")
        .maxLength(50)
        .build();
  }

  static lastnamelValidator() {
     if (kDebugMode) {
      return ValidationBuilder().minLength(1).maxLength(50).build();
    }
    return ValidationBuilder()
        .regExp(RegExp(r"^([A-Z])[a-z]+(-)?[a-z]+$"),
            "Names must contains only letters")
        .maxLength(50)
        .build();
  }
}
