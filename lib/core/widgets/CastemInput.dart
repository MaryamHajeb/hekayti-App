import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../util/ScreenUtil.dart';

class CastemInput extends StatefulWidget {
  const CastemInput({Key? key}) : super(key: key);

  @override
  State<CastemInput> createState() => _CastemInputState();
}

class _CastemInputState extends State<CastemInput> {
  @override
  ScreenUtil screenUtil=ScreenUtil();
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Container(

        height: screenUtil.screenHeight *.1,
        width: screenUtil.screenWidth *.3,
        decoration: BoxDecoration(
            border: Border.all(width: 2,color: AppTheme.primarySwatch.shade400),
            color: AppTheme.primarySwatch.shade200,
            borderRadius: BorderRadius.circular(10)

        ),
        margin: EdgeInsets.only(top: 20, left: 50, right: 50),
        child: TextField(
          keyboardType: TextInputType.text,
          style: AppTheme.textTheme.headline6,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
          cursorColor: AppTheme.primaryColor,
        )

    );
  }
}
