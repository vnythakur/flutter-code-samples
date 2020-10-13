import 'package:flutter/material.dart';

import '../constants.dart';

/**
 * CUSTOM COMPONENT FOR CREATING SECONDARY BUTTON
 */
class SecondaryButton extends StatelessWidget {
  final String text;
  final Function handler;

  SecondaryButton({this.text, this.handler});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.0,
      child: RaisedButton(
        color: Color(kSecondaryBackgroundColor),
        textColor: Theme.of(context).primaryColor,
        child: Text(
          text,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        onPressed: handler,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(8.0)),
        elevation: 0,
      ),
    );
  }
}
