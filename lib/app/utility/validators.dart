
abstract class StringValidator {
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator {

  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }

  bool isValidEmail(String value) {
    //@TODO
    return true;
  }

  //@TODO strip empty spaces of email
}

class EmailAndPasswordValidators {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final invalidEmailErrorText = 'Email cannot be empty!';
  final invalidPasswordErrorText = 'Password cannot be empty!';
}