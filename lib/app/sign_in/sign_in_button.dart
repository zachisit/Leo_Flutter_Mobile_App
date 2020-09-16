import 'package:flutter/material.dart';
import 'package:flutter_leo/common_widgets/button.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
    String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
}) : assert(text != null),
    super(
      child: Text(
          text,
          style: TextStyle(
              color:textColor,
              fontSize: 14
          )
      ),
      color: color,
      onPressed: onPressed
    );
}