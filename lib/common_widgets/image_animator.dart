import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class ImageAnimation extends AnimationController {
  ImageAnimation({
    @required this.duration,
    @required this.vsync,
  }) : super(
    duration:duration,
    vsync:vsync
  );
  final bool _isActive = false;
  final Duration duration;
  final TickerProvider vsync;

  void stopRotation() => this.stop();

  void startRotation() {
    print('start rotat');
    print(this.duration);

    this.repeat();
  }

  bool getActiveState() => _isActive;
}