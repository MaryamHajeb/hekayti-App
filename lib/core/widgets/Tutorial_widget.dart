import 'package:flutter/material.dart';
import 'package:hikayati_app/core/app_theme.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';

import '../util/Carecters.dart';
import 'CustemButten.dart';
import 'CustemButten2.dart';

class Tutorial_widget extends StatelessWidget {
  int carecters = 0;
  String text;
  Function onTap;
  int index;
  final hight;
  Tutorial_widget(
      {super.key,
      this.hight,
      required this.index,
      required this.text,
      required this.carecters,
      required this.onTap});
  ScreenUtil screenUtil = ScreenUtil();
  Carecters carectersobj = Carecters();
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Container(
        width: screenUtil.screenWidth * 1,
        height: hight ?? screenUtil.screenHeight * 1,
        child: Row(
          children: [
            Image.asset(
              carectersobj.happyListCarecters[carecters]["image"],
              height: screenUtil.screenHeight * .5,
              width: screenUtil.screenWidth * .2,
            ),
            Container(
              width: screenUtil.screenWidth * .3,
              height: screenUtil.screenHeight * .4,
              padding: EdgeInsets.all(screenUtil.screenWidth * .015),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: AppTheme.fontFamily,
                        ),
                      ),
                    ),
                    CustemButten2(
                        text: ""
                            "موافق",
                        ontap: () {
                          onTap();
                        })
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
