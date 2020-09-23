import 'package:flutter/material.dart';
//import 'package:audioplayer/audioplayer.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import "dart:math";
import 'package:flutter_leo/Sounds.dart';
import 'package:flutter_leo/app/sign_in/landing.dart';
import 'package:flutter_leo/app/utility/connection_status_notifiy.dart';
import 'package:flutter_leo/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasNetworkConnection;
  bool _fallbackViewOn;

  @override
  void initState() {
    print('init state');
    super.initState();
    _hasNetworkConnection = false;
    _fallbackViewOn = false;

    ConnectionStatusSingleton connectionStatus =
    ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(_updateConnectivity);
  }

  /// @TODO
  /// move to Utility and trigger when internet connection change
  void _showDialog(String title,String content ,BuildContext context) {
    print('show dialgout');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text('hi'),
              content: new Text(content),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text("Close"))
              ]
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Make Leo Speak',
        theme: ThemeData( //@TODO why not passed into widgets?
          primarySwatch: Colors.teal,
          backgroundColor: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          //buttonColor: Colors.blue,
        ),
      home: LandingPageState(
          auth: Auth()
      ),
    );
  }

  void _updateConnectivity(dynamic hasConnection) {
    print('top');
    _showDialog('hi', 'hiii', context); //test
    if (!_hasNetworkConnection) {
      print('no internet');
      if (!_fallbackViewOn) {
        //navigatorKey.currentState.pushNamed(FallbackConnection.route);
        print('no internet');
        setState(() {
          _fallbackViewOn = true;
          _hasNetworkConnection = hasConnection;
        });
      }
    } else {
      print('has internet');
      if (_fallbackViewOn) {
        print('fallback view');
        //navigatorKey.currentState.pop(context);
        setState(() {
          _fallbackViewOn = false;
          _hasNetworkConnection = hasConnection;
        });
      }
    }
  }
}
