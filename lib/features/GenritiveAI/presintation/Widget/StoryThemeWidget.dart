import 'package:flutter/material.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';

import '../../../../core/AppTheme.dart';

class StoryThemeWidget extends StatelessWidget {
  String image;
  Function onTap;
  bool isSelected;
 String name;
  StoryThemeWidget({
    required this.image,
    required this.onTap,
    required this.isSelected,
    required this.name
  });
  ScreenUtil screenUtil = ScreenUtil();
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return isSelected
        ? GestureDetector(
            onTap: () {
              onTap();
            },
            child: Column(
              children: [
                Image.asset(
                  width: 170,
                  height: 170,
                  image,
                  fit: BoxFit.contain,
                ),
                Text(name, style: AppTheme.textTheme.displaySmall)
              ]
            ),
          )
        : GestureDetector(
            onTap: () {
              onTap();
            },
            child: Opacity(
              opacity: .2,
              child: Image.asset(
                height: 100,
                width: 150,
                fit: BoxFit.fitHeight,
                image,
              ),
            ));
  }
}
