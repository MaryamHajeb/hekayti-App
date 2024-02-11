import 'package:flutter/material.dart';

import '../AppTheme.dart';
import '../util/ScreenUtil.dart';

class CustomFieldForSearch extends StatefulWidget {
  final valdution;
  final icon;
  final text;
  final type;
  final onching;
  double size;
  final controler;

  CustomFieldForSearch(
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
  State<CustomFieldForSearch> createState() => _CustomFieldForSearchState();
}

class _CustomFieldForSearchState extends State<CustomFieldForSearch> {
  @override
  ScreenUtil screenUtil = ScreenUtil();
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Center(
        child: SizedBox(
          width: widget.size,
          height: 80,
          child: TextFormField(
            onChanged: widget.onching,
            validator: widget.valdution,
            keyboardType: widget.type,
            style: AppTheme.textTheme.displayMedium,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            controller: widget.controler,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                prefixIcon: widget.icon,
                hintText: widget.text.toString(),
                hintStyle:
                    TextStyle(color: Colors.brown.shade300, fontSize: 13),
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
      ),
    );
  }
}
