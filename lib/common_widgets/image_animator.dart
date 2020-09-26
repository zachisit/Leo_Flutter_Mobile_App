import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class ImageAnimation extends AnimationController {
  ImageAnimation({
    @required this.vsync,
  }) : super(
    duration:Duration(seconds: 2),
    vsync:vsync
  );

  final TickerProvider vsync;

  void stopRotation() => stop();

  void startRotation() => repeat();

  bool isActive() => isAnimating;
}