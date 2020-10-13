import 'package:education_app/components/app_text.dart';
import 'package:flutter/material.dart';

import '../constants.dart';


/**
 * CUSTOM COMPONENT FOR CREATING CHIPS
 */
class CustomChip extends StatelessWidget {
  final String label;

  CustomChip({@required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Color(kChipBgColor),
      label: AppText(
        text: label,
        color: Color(kChipTextColor),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
    );
  }
}
