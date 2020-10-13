import 'package:flutter/material.dart';


/**
 * CUSTOM COMPONENT FOR CREATING CIRCULAR BADGE
 */
class CustomCircularBadge extends StatelessWidget {
  final Color color;
  final String image;

  CustomCircularBadge({@required this.color, @required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72.0,
      height: 72.0,
      child: Card(
        elevation: 2.0,
        color: color,
        shape: CircleBorder(),
        child: Center(
          child: Image.asset(image),
        ),
      ),
    );
  }
}
