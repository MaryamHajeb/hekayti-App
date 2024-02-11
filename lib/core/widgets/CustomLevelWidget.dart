import 'package:flutter/material.dart';

import '../AppTheme.dart';
import '../util/ScreenUtil.dart';

class CustomLevelWidget extends StatelessWidget {
  int name;
  Function onTap;
  bool isSelected;
  Color color;

  CustomLevelWidget({
    required this.name,
    required this.color,
    required this.onTap,
    required this.isSelected,
  });

  @override
  ScreenUtil screenUtil = ScreenUtil();

  Widget build(BuildContext context) {
    screenUtil.init(context);
    return isSelected
        ? GestureDetector(
            onTap: () {
              onTap();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 3, color: AppTheme.primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(11))),
              height: screenUtil.screenHeight * .3,
              width: screenUtil.screenWidth * .18,
              child: Center(
                  child: Text(
                name.toString(),
                style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              )),
            ),
          )
        : GestureDetector(
            onTap: () {
              onTap();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(Radius.circular(11))),
              height: screenUtil.screenHeight * .3,
              width: screenUtil.screenWidth * .18,
              child: Center(
                  child: Text(
                name.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              )),
            ));
  }
}
