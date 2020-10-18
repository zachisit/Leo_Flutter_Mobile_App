import 'package:flutter/material.dart';
import 'package:flutter_leo/app/sound_player.dart';
import 'package:flutter_leo/common_widgets/image_animator.dart';
import 'package:flutter_leo/common_widgets/platform_alert_dialog.dart';
import 'package:flutter_leo/services/auth.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../image_action_provider.dart';

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

  @override
  void initState() {
    imageRotater = ImageAnimation(
      vsync: this,
    )..repeat();

    super.initState();
    imageRotater.stopRotation();
  }

  @override
  void dispose() {
    imageRotater.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageAction = Provider.of<ImageActionProvider>(context);

    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        //title: Text('Home Page'),
        backgroundColor: Colors.pink[100],
        actions: <Widget>[
          FlatButton(
            onPressed: () => widget._confirmSignOut(context),
            child: Text(
              'Log Out',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: GestureDetector(
          onTap: () async {
            imageRotater.startRotation();
            final assetsAudioPlayer = SoundPlayer();
            assetsAudioPlayer.playSound();
            imageAction.setPlayingStatus(true);
            assetsAudioPlayer.isFinished.listen((finished) {
              if (finished) {
                print('stopped playing');
                imageRotater.stopRotation();
                imageAction.setPlayingStatus(false);
              }
            });
          }, // onTap
          child: AnimatedBuilder(
            animation: imageRotater,
            builder: (_, child) {
              return Transform.rotate(
                angle: (imageAction.isPlayingStatus != false)
                    ? imageRotater.value * 2 * math.pi
                    : 0.0,
                child: child,
              );
            },
            child: Image.asset(
              imageAction.image,
              width: 280,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
