import "dart:math";


class Sounds {
  String asset;

  static returnRandomSoundPath<String>() => returnAvailableSoundPaths()[Random().nextInt(returnAvailableSoundPaths().length)];

  static List<String> returnAvailableSoundPaths() {
    return [
      'assets/sounds/911.mp3',
      'assets/sounds/alive.mp3',
      'assets/sounds/boobs.mp3',
      'assets/sounds/buggers.mp3',
      'assets/sounds/rat-turds.mp3',
      'assets/sounds/beelzibub.mp3',
      //'assets/sounds/test.mp3',
      'assets/sounds/sharted.mp3',
      'assets/sounds/fleegles.mp3',
      'assets/sounds/exit-left.mp3',
      'assets/sounds/Breasteses.mp3',
      'assets/sounds/didnt-do-it.mp3',
      'assets/sounds/braunsweiger.mp3',
      'assets/sounds/fun-bags.mp3',
      'assets/sounds/sewer-gas.mp3',
      'assets/sounds/ScurvyRat.mp3',
      'assets/sounds/ildargit.mp3',
    ];
  }

}