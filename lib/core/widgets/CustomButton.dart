import 'package:flutter/material.dart';

import '../AppTheme.dart';

class CustomButton extends StatelessWidget {
  CustomButton({Key? key, required this.ontap, required this.text})
      : super(key: key);
  Function ontap;
  final text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(9))),
            padding: EdgeInsets.all(0),
            backgroundColor: AppTheme.primaryColor,
            side: BorderSide(
              color: Colors.white,
            )),
        onPressed: () {
          ontap();
        },
        child: Container(
            width: 60,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    width: 3, color: AppTheme.primarySwatch.shade200),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Center(
                child: Text(text,
                    style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        color: AppTheme.primaryColor,
                        fontSize: 14)))));
  }
}
