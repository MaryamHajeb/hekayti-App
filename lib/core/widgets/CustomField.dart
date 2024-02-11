import 'package:flutter/material.dart';

import '../AppTheme.dart';
import '../util/ScreenUtil.dart';

class CustomField extends StatefulWidget {
  final valdution;
  final icon;
  final text;
  final type;
  final onching;
  double size;
  final controler;

  CustomField(
      {Key? key,
      required this.valdution,
      this.icon,
      required this.text,
      this.type,
      required this.controler,
      required this.size,
      this.onching})
      : super(key: key);

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  ScreenUtil screenUtil = ScreenUtil();
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Center(
      child: SizedBox(
        width: widget.size,
        height: 70,
        child: TextFormField(
          validator: widget.valdution,
          keyboardType: widget.type,
          style: AppTheme.textTheme.displayMedium,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          controller: widget.controler,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              fillColor: AppTheme.primarySwatch.shade200,
              errorStyle: TextStyle(
                color: AppTheme.primarySwatch,
                fontFamily: AppTheme.fontFamily,
                fontSize: 10,
              ),
              filled: true,
              errorBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              prefixIcon: widget.icon,
              hintText: widget.text.toString(),
              hintStyle: TextStyle(color: Colors.brown.shade300, fontSize: 13),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              )),
          cursorColor: AppTheme.primaryColor,
        ),
      ),
    );
  }
}
