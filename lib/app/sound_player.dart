import 'package:assets_audio_player/assets_audio_player.dart';
import '../Sounds.dart';

class SoundPlayer {
  final AssetsAudioPlayer player = AssetsAudioPlayer();

  void playSound() {
    player.open(
        Audio(
            Sounds.returnRandomSoundPath()
        ),
        autoStart: true
    );
  }

   alertFinished() {
     player.playlistFinished.listen((finished) {
       if (finished) {
         print('stopped playing');
         //imageRotater.stopRotation();
         //return activeSoundStatus(false);
       }
     });
  }
}