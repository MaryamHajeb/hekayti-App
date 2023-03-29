import 'package:hikayati_app/core/app_theme.dart';
import 'package:flutter/material.dart';

class PrimaryText extends StatelessWidget {
  String text;
  Color textColor;
  double fontSize;
  TextAlign textAlign;
  FontWeight fontWeight;
  TextDirection textDirection;

  PrimaryText(
      {required this.text,
      required this.textColor,
      required this.fontSize,
      this.textAlign = TextAlign.center,
      this.fontWeight = FontWeight.normal,
      this.textDirection = TextDirection.rtl});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontFamily: AppTheme.fontFamily,
      ),
      textDirection: textDirection,
      textAlign: textAlign,
    );
  }
}
