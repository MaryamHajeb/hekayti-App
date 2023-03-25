import 'package:flutter/material.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';

import '../app_theme.dart';

class CastemPersons extends StatelessWidget {
  String image;
  Function onTap;
  bool isSelected;

  CastemPersons({
    required this.image,
    required this.onTap,
    required this.isSelected,
  });
ScreenUtil screenUtil =ScreenUtil();
  @override
  Widget build(BuildContext context) {
screenUtil.init(context);
    return isSelected
        ? GestureDetector(
            onTap: () {
              onTap();
            },
            child: Container(
              padding: EdgeInsets.only(right: 20),
                height: screenUtil.screenHeight * .2,
                width: screenUtil.screenWidth *.25,
                child: Image.asset(image,fit: BoxFit.contain,)),
          )
        : GestureDetector(
            onTap: () {
              onTap();
            },
            child: Container(
                child: Container(
                    padding: EdgeInsets.only(right: 30),

                    height: screenUtil.screenHeight * .2,
                    width: screenUtil.screenWidth *.17,
                    child: Image.asset(
                      width: 150,
                      height: 150,

              image,
            ))));
  }
}
