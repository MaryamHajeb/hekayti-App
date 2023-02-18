
import 'package:flutter/material.dart';

import '../app_theme.dart';

class CastemPersons extends StatelessWidget {
  String  image;
  Function onTap;
  bool isSelected;

  CastemPersons({
    required this.image,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? GestureDetector(
      onTap: (){
        onTap();
      },
          child: Container(child: Image.asset(image)),
        )
        : GestureDetector(
      onTap: (){
        onTap();
      },
          child: Container(child: Image.asset(image,
        )));
  }
}
