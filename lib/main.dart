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
       //home: SignInPage()
       //  home: Scaffold(
       //    appBar: AppBar(
       //      title: const Text('Wild Ones'),
       //    ),
       //      body:HomePageAction()
       //  )
        //home: HomePageAction(),
        );
  }
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Asset Image'),
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         color: Colors.purple[100]
//         child: Image.asset(
//           'assets/images/make_sound_normal.png'
//         ),
//       ),
//     );
//   }
// }

class HomePageAction extends StatefulWidget {
  @override
  _HomePageActionState createState() => _HomePageActionState();
}

class _HomePageActionState extends State<HomePageAction> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _img = 'assets/images/make_sound_normal.png';
  bool _active = false;
  int _duration;

  void activeSoundStatus(bool isPlaying) {
    var file, active;

    switch (isPlaying) {
      case true:
        file = 'assets/images/make_sound_active.png';
        active = true;
        break;
      case false:
        file = 'assets/images/make_sound_normal.png';
        active = false;
        break;
    }

    setState(() {
      _img = file;
      _active = active;
    });
  }

  // AlertDialog tmpFunction() {
  //   print('Function Called.');
  //
  //   return AlertDialog(
  //     title: Text('AlertDialog Title'),
  //     content: SingleChildScrollView(
  //       child: ListBody(
  //         children: <Widget>[
  //           Text('This is a demo alert dialog.'),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Future<File> readCounter() async {
  //   try {
  //     final File file = await FilePicker.getFile();
  //
  //     return file;
  //   } catch (e) {
  //     // If encountering an error, return 0.
  //     print(e);
  //     //return 0;
  //   }
  // }0

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final assetsAudioPlayer = AssetsAudioPlayer();
        assetsAudioPlayer.open(Audio(Sounds.returnRandomSoundPath()),
            autoStart: true);

        activeSoundStatus(true);
        //assetsAudioPlayer.

        assetsAudioPlayer.playlistFinished.listen((finished) {
          if (finished) {
            return activeSoundStatus(false);
          }
        });
        print('------ here -----');
        assetsAudioPlayer.current.listen((current) {
          _duration = current.audio.duration.inSeconds;
          print('----- he ----');
          print(_duration);
        });
      },
      child: Center(
        child: Column(
          children: <Widget>[
            RotationTransition(turns: Tween(begin: 0.0,end: 1.0).animate(_controller),
              child: Image.asset(
                _img,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
          ],
        )

        // child: AnimatedContainer(
        //   //width: _active ? 200.0 : 100.0,
        //   width: 200,
        //   //height: _active ? 100.0 : 200.0,
        //   //color: _active ? Colors.red : Colors.blue, //@TODO set background color of parent
        //   alignment:
        //       _active ? Alignment.center : AlignmentDirectional.topCenter,
        //   duration: Duration(seconds: 2), //@TODO determine length of audio file
        //   //  curve: Curves.fastOutSlowIn,
        //   child: Image.asset(
        //     _img,
        //     width: 200,
        //     fit: BoxFit.cover,
        //   ),
        // ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: Colors.lightBlue,
    //   appBar: AppBar(
    //     title: Text('Make Leo Speak'),
    //   ),
    //     body: SafeArea(
    //         child: Center(
    //             child: Column(children: [
    //               GestureDetector(
    //                 onTap: () {
    //                   final assetsAudioPlayer = AssetsAudioPlayer();
    //                   assetsAudioPlayer.open(
    //                       Audio(getRandomElement(imagePaths)),
    //                       autoStart: true
    //                   );
    //
    //                   activeSoundStatus(true);
    //
    //                   assetsAudioPlayer.playlistFinished.listen((finished){
    //                     if (finished) {
    //                       print('=== is it sinifhsed');
    //                       activeSoundStatus(false);
    //                     }
    //                   });
    //                 },
    //                 child: Image.asset(
    //                   _img,
    //                   width: 200,
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //             ]
    //             )
    //         )
    //     )
    // );
  }
}
