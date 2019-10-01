import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:capstone/main.dart';

class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  
  const SendButton({Key key, this.text, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: primaryColor,
      onPressed: callback,
      child: Text(text),
    );
  }
}