import 'package:flutter/material.dart';
import 'package:flutter_leo/app/sign_in/home_page.dart';
import 'package:flutter_leo/app/sign_in/home_page_test.dart';
import 'package:flutter_leo/app/sign_in/sign_in_page.dart';
import 'package:flutter_leo/services/auth.dart';
import 'package:flutter_leo/user/user.dart';

class LandingPageState extends StatefulWidget {
  LandingPageState({@required this.auth});
  final AuthBase auth;
  @override
  _LandingPageStateState createState() => _LandingPageStateState();
}

class _LandingPageStateState extends State<LandingPageState> {

  User _user;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async {
    User user = await widget.auth.currentUser();
    _updateUser(user);
  }

  /// If null passed in, we are invalidating the
  ///  state of the user to be null
  void _updateUser(User user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('landing');
    if (_user == null) {
      return SignInPage(
        onSignIn: _updateUser,
        auth: widget.auth,
      );
    }

    //return HomePageAction();

    // return HomePage(
    //   onSignOut: () => _updateUser(null),
    //   auth: widget.auth
    // );

    return HomePageAction(
      onSignOut: () => _updateUser(null),
      auth: widget.auth
    );
  }
}
