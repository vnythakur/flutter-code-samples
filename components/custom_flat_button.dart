import 'package:flutter/material.dart';


/**
 * CUSTOM COMPONENT FOR CREATING FLAT BUTTON
 */
class CustomFlatButton extends StatelessWidget {
  final String text;
  final Function handler;

  CustomFlatButton({this.text, this.handler});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      textColor: Theme.of(context).primaryColor,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
      ),
      onPressed: handler,
    );
  }
}
