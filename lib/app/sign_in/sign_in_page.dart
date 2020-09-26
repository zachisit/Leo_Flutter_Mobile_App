import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_leo/app/sign_in/email_sign_in.dart';
import 'package:flutter_leo/app/sign_in/sign_in_button.dart';
import 'package:flutter_leo/common_widgets/platform_exception_alert_dialog.dart';
import 'package:flutter_leo/services/auth.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign In Failed',
      exception: exception,
    ).show(context);
  }

  Future<void> _signInAnon(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInAnon();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      setState(() {
        _isLoading = true;
      });
      await auth.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (context) => EmailSignInPage(),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildContent(context)
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
        color: Colors.indigo,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                width: MediaQuery.of(context).size.width*(90/100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height:100),
                    SizedBox(
                      height: 50.0,
                      child: _buildHeader(),
                    ),
                    SizedBox(height: 50),
                    SignInButton(
                      text: 'Sign in With Google',
                      color: Colors.pink[100],
                      textColor: Colors.black87,
                      onPressed: _isLoading ? null : () => _signInWithGoogle(context),
                    ),
                    SizedBox(height: 10),
                    SignInButton(
                      text: 'Sign in With Email',
                      color: Colors.yellow[100],
                      textColor: Colors.black87,
                      onPressed: _isLoading ? null : () => _signInWithEmail(context),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'or',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    SignInButton(
                      text: 'Go anonoymous',
                      color: Colors.green[100],
                      textColor: Colors.black87,
                      onPressed: _isLoading ? null : () => _signInAnon(context),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom:0,
                width: MediaQuery.of(context).size.width*(90/100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'v1.0.325',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget _buildHeader() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator()
      );
    }
    return Text(
        'Sign In',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 32.0,
          color: Colors.white,
        )
    );
  }
}
