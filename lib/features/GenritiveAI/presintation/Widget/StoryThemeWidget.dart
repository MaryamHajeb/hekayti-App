import 'package:flutter/material.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';

class CustomCharacters extends StatelessWidget {
  String image;
  Function onTap;
  bool isSelected;

  CustomCharacters({
    required this.image,
    required this.onTap,
    required this.isSelected,
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
            child: Image.asset(
              width: 200,
              height: 200,
              image,
              fit: BoxFit.contain,
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
