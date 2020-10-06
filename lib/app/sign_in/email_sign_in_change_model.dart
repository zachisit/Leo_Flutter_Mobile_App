import 'package:flutter/cupertino.dart';
import 'package:flutter_leo/app/utility/validators.dart';
import 'package:flutter_leo/services/auth.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailSignInChangeModel({
    @required this.auth,
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });
  final AuthBase auth;
  String email;
  String password;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);

    try {
      if (formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailPass(email, password);
      } else {
        await auth.createUserWithEmailPass(email, password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn ?
    'Sign In' :
    'Create an account';
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signIn ?
    'Need an account? Register' :
    'Have an account? Sign In';
  }

  bool get canSubmit {
    return emailValidator.isValid(email) && passwordValidator.isValid(password) && !isLoading;
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);

    return showErrorText
        ? invalidPasswordErrorText
        : null;
  }

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText
        ? invalidEmailErrorText
        : null;
  }

  void updateEmail(String email) => updateWith(email:email);

  void updatePassword(String password) => updateWith(password: password);

  void toggleFormType() {
    final formType = this.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;

    updateWith(
      email: '',
      password: '',
      submitted: false,
      isLoading: false,
      formType: formType,
    );
  }

  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
      this.email = email ?? this.email;
      this.password = password ?? this.password;
      this.formType = formType ?? this.formType;
      this.isLoading = isLoading ?? this.isLoading;
      this.submitted = submitted ?? this. submitted;
      notifyListeners();
  }
}