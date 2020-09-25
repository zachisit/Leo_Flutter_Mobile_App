import 'package:flutter/material.dart';
import 'package:flutter_leo/app/sign_in/email_sign_in.dart';
import 'package:flutter_leo/app/sign_in/sign_in_button.dart';
import 'package:flutter_leo/common_widgets/platform_alert_dialog.dart';
import 'package:flutter_leo/services/auth.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {

  Future<void> _signInAnon(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInAnon();
      //@TODO show dialogue
    } catch (e) {
      PlatformAlertDialog(
        title: 'Sign in failed',
        content: e.toString(),
        defaultActionText: 'OK',
      ).show(context);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signInWithGoogle();
      //@TODO show dialogue
    } catch (e) {
      PlatformAlertDialog(
        title: 'Sign in failed',
        content: e.toString(),
        defaultActionText: 'OK',
      ).show(context);
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
                    Text(
                        'Sign In',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32.0,
                          color: Colors.white,
                        )
                    ),
                    SizedBox(height: 50),
                    SignInButton(
                      text: 'Sign in With Google',
                      color: Colors.pink[100],
                      textColor: Colors.black87,
                      onPressed: () => _signInWithGoogle(context),
                    ),
                    SizedBox(height: 10),
                    SignInButton(
                      text: 'Sign in With Email',
                      color: Colors.yellow[100],
                      textColor: Colors.black87,
                      onPressed: () => _signInWithEmail(context),
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
                      onPressed: () => _signInAnon(context),
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
                      'v1.0.324',
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
}
