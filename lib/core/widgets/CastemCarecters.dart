import 'package:flutter/material.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';

import '../app_theme.dart';

class CustemCarecters extends StatelessWidget {
  String image;
  Function onTap;
  bool isSelected;

  CustemCarecters({
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
            child: Image.asset(
              width: 200,
              height: 200,

              image,fit: BoxFit.contain,),
          )
        : GestureDetector(
            onTap: () {
              onTap();
            },
            child: Image.asset(
              height: 100,
              color: AppTheme.primarySwatch.shade500,
              width: 150,
              fit: BoxFit.fitHeight,
              image,
            ));
  }
}
