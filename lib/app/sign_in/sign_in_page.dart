import 'package:flutter/material.dart';
import 'package:flutter_leo/app/sign_in/email_sign_in.dart';
import 'package:flutter_leo/app/sign_in/sign_in_button.dart';
import 'package:flutter_leo/services/auth.dart';

class SignInPage extends StatelessWidget {
  SignInPage({@required this.auth});
  final AuthBase auth;

  Future<void> _signInAnon() async {
    try {
      await auth.signInAnon();
      //@TODO show dialogue
    } catch (e) {
      print('hereee');
      print(e.toString());
      //@TODO: show alert dialogue to user
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
      //@TODO show dialogue
    } catch (e) {
      print('hereee');
      print(e.toString());
      //@TODO: show alert dialogue to user
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(auth: auth),
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
            child: Column(
              // centered in the verical alignment
              mainAxisAlignment: MainAxisAlignment.center,
                // allow the width of the column stretch 100% across
                // the horizontal/cross axis alignement
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
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
                    onPressed: _signInWithGoogle,
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
                    onPressed: _signInAnon,
                  ),
                ],
            ),
          )
      );
  }
}
