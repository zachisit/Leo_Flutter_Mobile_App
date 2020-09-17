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
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          backgroundColor: Colors.pink[100],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      home: LandingPageState(
          auth: Auth()
      ),
    );
  }
}
