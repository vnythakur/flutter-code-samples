import 'package:flutter/material.dart';

import '../constants.dart';

/**
 * CUSTOM COMPONENT FOR CREATING FLAT BUTTON
 */
class AppBarFlatButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double fontSize;
  final Color color;
  final EdgeInsetsGeometry padding;

  AppBarFlatButton({
    @required this.text,
    @required this.onPressed,
    this.fontSize,
    this.color,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: padding ?? null,
      child: Text(
        text,
        style: TextStyle(
            color: color != null ? color : Color(kNavbarIconColor),
            fontSize: fontSize != null ? fontSize : 18.0,
            fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
    );
  }
}
