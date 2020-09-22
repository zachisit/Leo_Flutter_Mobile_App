import 'package:flutter/material.dart';
//import 'package:audioplayer/audioplayer.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import "dart:math";
import 'package:flutter_leo/Sounds.dart';
import 'package:flutter_leo/app/sign_in/landing.dart';
import 'package:flutter_leo/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

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
}
