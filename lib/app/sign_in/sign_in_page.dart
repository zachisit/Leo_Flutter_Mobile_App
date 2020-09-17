import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leo/app/sign_in/sign_in_button.dart';
import 'package:flutter_leo/services/auth.dart';
import 'package:flutter_leo/user/user.dart';

class SignInPage extends StatelessWidget {
  SignInPage({@required this.onSignIn, @required this.auth});

  final Function(User) onSignIn;
  final AuthBase auth;


  Future<void> _signInAnon() async {
    print('here');
    try {
      print('hi');
      User user = await auth.signInAnon();

      print(user.uid);
      onSignIn(user);
    } catch (e) {
      print('hereee');
      print(e.toString());
      //@TODO: show alert dialogue to user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'Howdy',
            style: TextStyle(
              //@TODO center text
            )
          ),
          elevation: 2.0,
        ),
        body: _buildContent()
    );
  }

  Widget _buildContent() {
    return Container(
          color: Colors.pink[100],
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
                    )
                  ),
                  SizedBox(height: 50),
                  SignInButton(
                    text: 'Sign in With Google',
                    color: Colors.blue[300],
                    textColor: Colors.black87,
                    onPressed: () {},
                  ),
                  SizedBox(height: 10),
                  SignInButton(
                    text: 'Sign in With Facebook',
                    color: Colors.yellow[100],
                    textColor: Colors.black87,
                    onPressed: () {},
                  ),
                  SizedBox(height: 10),
                  SignInButton(
                    text: 'Sign in With Email',
                    color: Colors.orange[100],
                    textColor: Colors.black87,
                    onPressed: () {},
                  ),
                  SizedBox(height: 10),
                  Text(
                    'or',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  SignInButton(
                    text: 'Go anonoymous',
                    color: Colors.green[100],
                    textColor: Colors.black87,
                    onPressed: _signInAnon,
                  ),
                ]
            ),
          )
      );
  }
}
