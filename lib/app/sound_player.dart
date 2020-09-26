import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import '../Sounds.dart';

class SoundPlayer {
  final AssetsAudioPlayer player = AssetsAudioPlayer();

  //get finished => player.playlistAudioFinished;

  get isFinished => player.playlistFinished;

  void playSound() {
    player.open(
        Audio(
            Sounds.returnRandomSoundPath()
        ),
        autoStart: true
    );
  }

  // StreamSubscription<dynamic> alertFinished() {
  //    return player.playlistFinished.listen(finished);
  // }
}