import 'package:education_app/constants.dart';
import 'package:flutter/material.dart';


/**
 * CUSTOM COMPONENT FOR CREATING TITLE
 */
class AppTitle extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;

  AppTitle(
      {@required this.text,
      this.size,
      this.fontWeight,
      this.color,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign == null ? null : textAlign,
      style: TextStyle(
        color: color ?? Color(kPrimaryTitleColor),
        fontSize: size != null ? size : 28.0,
        fontWeight: fontWeight ?? FontWeight.bold,
      ),
    );
  }
}
