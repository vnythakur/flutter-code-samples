import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

/**
 * CUSTOM COMPONENT FOR CREATING TEXTAREA WITH CHARACTERS COUNT
 */
class CustomTextarea extends StatelessWidget {
  final Function onChanged;
  final TextEditingController controller;
  final String hint;
  final Color textColor;

  CustomTextarea({
    @required this.controller,
    @required this.onChanged,
    this.hint,
    this.textColor,
  });

  static const defaultBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(kAppBorderColor),
    ),
  );

  static const totalNumber = 100;

  getRemainingCharacter() {
    if (controller.value.text != null && controller.value.text != '') {
      return '${totalNumber - controller.value.text.length} characters remaining...';
    }
    return '$totalNumber characters remaining...';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        TextField(
          maxLines: 9,
          decoration: InputDecoration(
            enabledBorder: defaultBorder,
            focusedBorder: defaultBorder,
            hintText: hint == null ? '' : hint,
            hintStyle: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: textColor ?? Color(0xff777777),
          ),
          // maxLength: 10,
          inputFormatters: [LengthLimitingTextInputFormatter(totalNumber)],
          onChanged: onChanged,
          controller: controller,
          // maxLengthEnforced: true,
        ),
        Positioned(
          bottom: 4,
          right: 10,
          child: Container(
            child: Text(
              getRemainingCharacter(),
              style: TextStyle(color: Color(kAppBorderColor)),
            ),
          ),
        )
      ],
    );
  }
}
