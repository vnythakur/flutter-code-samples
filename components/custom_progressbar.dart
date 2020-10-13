import 'package:flutter/material.dart';

import '../constants.dart';


/**
 * CUSTOM COMPONENT FOR CREATING PROGRESS BAR
 */
class CustomProgressbar extends StatelessWidget {
  final Color completeColor;
  final Color inCompleteColor;
  final double completeValue;
  final double inCompleteValue;
  final double inCompleteBarHeight;
  final double completeBarHeight;

  CustomProgressbar({
    this.completeColor,
    @required this.completeValue,
    @required this.inCompleteValue,
    this.inCompleteColor,
    this.inCompleteBarHeight,
    this.completeBarHeight,
  });

  @override
  Widget build(BuildContext context) {
    double inCompleteTopMargin = 0;
    double completeTopMargin = 0;

    double iHeight = inCompleteBarHeight ?? 20;
    double cHeight = completeBarHeight ?? 20;

    if (iHeight > cHeight) {
      completeTopMargin = (iHeight - cHeight) * 0.5;
    } else {
      inCompleteTopMargin = (cHeight - iHeight) * 0.5;
    }

    if (inCompleteBarHeight != null) {}

    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: inCompleteTopMargin),
          width: inCompleteValue,
          height: inCompleteBarHeight ?? 20,
          decoration: BoxDecoration(
            color: inCompleteColor != null
                ? inCompleteColor
                : Color(kSecondaryBackgroundColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: completeTopMargin),
          width: completeValue,
          height: completeBarHeight ?? 20,
          decoration: BoxDecoration(
            color: completeColor ?? Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ],
    );
  }
}
