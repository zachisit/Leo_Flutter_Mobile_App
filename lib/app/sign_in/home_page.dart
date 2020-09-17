import 'package:flutter/material.dart';
import 'package:flutter_leo/services/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({@required this.onSignOut, @required this.auth});

  final VoidCallback onSignOut;
  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
      onSignOut();
    } catch (e) {
      print(e.toString());
      //@TODO: show alert dialogue to user
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
              onPressed: _signOut,
              child: Text(
                  'Log Out',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                )
              )
          )
        ],
      ),
    );
  }
}
