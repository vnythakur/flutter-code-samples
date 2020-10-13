import 'package:flutter/material.dart';

import '../constants.dart';

/**
 * CUSTOM COMPONENT FOR ICON BUTTON
 */
class AppBarIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final double iconSize;
  final Color color;

  AppBarIconButton({
    @required this.icon,
    @required this.onPressed,
    this.iconSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: color != null ? color : Color(kNavbarIconColor),
        size: iconSize != null ? iconSize : IconTheme.of(context).size,
      ),
      onPressed: onPressed,
    );
  }
}
