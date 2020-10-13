import 'package:flutter/material.dart';

import '../constants.dart';


/**
 * CUSTOM COMPONENT FOR CREATING SEGMENT TAB
 */
class CustomSegmentTab extends StatelessWidget {
  final String label;
  final BorderRadius borderRadius;
  final Function onChange;
  final bool isSelected;

  CustomSegmentTab({
    @required this.label,
    @required this.borderRadius,
    @required this.onChange,
    @required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onChange,
        child: Container(
          height: 40.0,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: isSelected
                ? Theme.of(context).primaryColor
                : Theme.of(context).accentColor,
          ),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
