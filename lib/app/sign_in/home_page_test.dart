import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leo/common_widgets/image_animator.dart';
import 'package:flutter_leo/common_widgets/platform_alert_dialog.dart';
import 'package:flutter_leo/services/auth.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../Sounds.dart';

class HomePageAction extends StatefulWidget {

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      PlatformAlertDialog(
        title: 'Sign out failed',
        content: e.toString(),
        defaultActionText: 'OK',
      ).show(context);
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to log out?',
      cancelActionText: 'Nope',
      defaultActionText: 'Sure',
    ).show(context);

    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  _HomePageActionState createState() => _HomePageActionState();
}

class _HomePageActionState extends State<HomePageAction>
    with SingleTickerProviderStateMixin {
  ImageAnimation imageRotater;
  String _img = 'assets/images/cat_normal.png';
  bool _active = false;

  @override
  void initState() {
    imageRotater =
        ImageAnimation(
            vsync: this,
        )..repeat();

    super.initState();
    imageRotater.stopRotation();
  }

  bool getActiveState() => _active;


  void activeSoundStatus(bool isPlaying) {
    var file, active;

    switch (isPlaying) {
      case true:
      //file = 'assets/images/cat_active.png';
        file = 'assets/images/cat_normal.png'; //@TODO: change back to active
        active = true;
        break;
      case false:
        file = 'assets/images/cat_normal.png';
        active = false;
        break;
    }

    setState(() {
      _img = file;
      _active = active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          //title: Text('Home Page'),
          backgroundColor: Colors.pink[100],
          actions: <Widget>[
            FlatButton(
                onPressed: () => widget._confirmSignOut(context),
                child: Text('Log Out',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black54,
                    )
                )
            )
          ],
        ),
        body: Center(
            child: GestureDetector(
          onTap: () {
            imageRotater.startRotation();
            final assetsAudioPlayer = AssetsAudioPlayer();
            assetsAudioPlayer.open(Audio(Sounds.returnRandomSoundPath()),
                autoStart: true);

            activeSoundStatus(true);

            assetsAudioPlayer.playlistFinished.listen((finished) {
              if (finished) {
                print('stopped playing');
                imageRotater.stopRotation();
                return activeSoundStatus(false);
              }
            });

            // assetsAudioPlayer.current.listen((current) {
            //   _duration = current.audio.duration.inSeconds;
            //   print(_duration);
            // });
          }, // onTap
          child: AnimatedBuilder(
            animation: imageRotater,
            builder: (_, child) {
              var d = (getActiveState() != false)
                  ? imageRotater.value * 2 * math.pi
                  : 0.0;
              return Transform.rotate(
                angle: d,
                child: child,
              );
            },
            child: Image.asset(
              //@TODO move to method
              _img,
              width: 280,
              fit: BoxFit.cover,
            ),
          ),
            ),
        ),
    );
  }
}
