import 'package:flutter/material.dart';

import '../constants.dart';


/**
 * CUSTOM COMPONENT FOR CREATING TEXT
 */
class AppText extends StatelessWidget {
  final String text;
  final double size;
  final bool noOpacity;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;

  AppText(
      {@required this.text,
      this.size,
      this.noOpacity,
      this.fontWeight,
      this.textAlign,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign == null ? null : textAlign,
      style: TextStyle(
        color: color ??
            Color(
              noOpacity == null || noOpacity == false
                  ? kPrimaryTextColor
                  : kPrimaryTextColorNoOpac,
            ),
        fontSize: size != null ? size : 18.0,
        fontWeight: fontWeight ?? FontWeight.normal,        
      ),
    );
  }
}
