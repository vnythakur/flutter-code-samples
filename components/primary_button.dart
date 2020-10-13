import 'package:education_app/constants.dart';
import 'package:flutter/material.dart';

enum Shape { rounded, block }


/**
 * CUSTOM COMPONENT FOR CREATING PRIMARY BUTTON
 */
class PrimaryButton extends StatelessWidget {
  final String text;
  final Function handler;
  final Shape shape;

  PrimaryButton({
    this.text,
    this.handler,
    this.shape = Shape.rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.0,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        textColor: Color(kAppBackgroundColor),
        child: Text(
          text,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        onPressed: handler,
        shape: RoundedRectangleBorder(
            borderRadius:
                new BorderRadius.circular(shape == Shape.rounded ? 8.0 : 0)),
        elevation: 0,
      ),
    );
  }
}
