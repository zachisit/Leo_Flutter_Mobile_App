import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({
    this.child,
    this.color,
    this.onPressed,
    this.borderRadius: 2.0,
    this.elevation: 12.0,
    this.height: 50.0,
  });
  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final double elevation;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.height,
        child: RaisedButton(
          child: this.child,
          onPressed: this.onPressed,
          color: this.color,
          elevation: this.elevation,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(this.borderRadius),
              )
          ),
        )
    );
  }
}
