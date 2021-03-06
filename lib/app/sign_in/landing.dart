import 'package:flutter/material.dart';
import 'package:flutter_leo/app/image_action_provider.dart';
import 'package:flutter_leo/app/sign_in/home_page.dart';
import 'package:flutter_leo/app/sign_in/sign_in_page.dart';
import 'package:flutter_leo/services/auth.dart';
import 'package:flutter_leo/user/user.dart';
import 'package:provider/provider.dart';

class LandingPageState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('--- error ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;

            if (user == null) {
              return SignInPage.create(context);
            }
            return ChangeNotifierProvider(
              create: (BuildContext context) => ImageActionProvider(),
              child: HomePageAction(),
            );
          } else {
            // no data in the snapshot
            // either we have not yet received
            // first value, or received
            // an error
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
