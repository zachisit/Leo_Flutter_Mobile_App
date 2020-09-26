import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_leo/app/utility/validators.dart';
import 'package:flutter_leo/common_widgets/form_submit_button.dart';
import 'package:flutter_leo/common_widgets/platform_exception_alert_dialog.dart';
import 'package:flutter_leo/services/auth.dart';
import 'package:provider/provider.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _submitted = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  void _submit() async {
    print('submit called');
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    print('email  $_email and password: $_password');
    
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailPass(_email, _password);
      } else {
        await auth.createUserWithEmailPass(_email, _password);
      }
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Sign in failed',
        exception: e,
      ).show(context);
    } finally {
      setState(() {
        print('now not loading');
        _isLoading = false;
      });
    }
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email)
    ? _passwordFocusNode
    : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn ?
          EmailSignInFormType.register :
          EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
    _submitted = false;
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn ?
    'Sign In' :
    'Create an account';
    final secondaryText = _formType == EmailSignInFormType.signIn ?
    'Need an account? Register' :
    'Have an account? Sign In';
    bool submitEnabled = widget.emailValidator.isValid(_email) && widget.passwordValidator.isValid(_password) && !_isLoading;

    return [
      _buildEmailTextField(),
      SizedBox(
        height: 8.0
      ),
      _buildPasswordTextField(),
      SizedBox(
          height: 8.0
      ),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitEnabled ? _submit : null,
      ),
      FlatButton(
          onPressed: !_isLoading ? _toggleFormType : null,
          child: Text(secondaryText),
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    bool showErrorText = _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
        enabled: _isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      onChanged: (password) => _updateState(),
    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
        enabled: _isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
      onChanged: (email) => _updateState(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }

  void _updateState() {
    setState(() {
      //no manually update just to refresh screen
    });
  }
}
