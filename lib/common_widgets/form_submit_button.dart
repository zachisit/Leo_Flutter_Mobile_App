import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leo/common_widgets/button.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    @required String text,
    VoidCallback onPressed,
}) : super(
    child: Text(
      text,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 20.0
      ),
    ),
      height: 44.0,
      color: Colors.green[100],
      borderRadius: 4.0,
      onPressed: onPressed
  );
}