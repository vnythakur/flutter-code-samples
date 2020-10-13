import 'package:flutter/material.dart';


/**
 * CUSTOM COMPONENT FOR CREATING SEGMENTS
 */class CustomSegment extends StatelessWidget {
  final List<Widget> tabs;

  CustomSegment(this.tabs);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        children: tabs,
      ),
    );
  }
}
