import 'package:flutter/material.dart';

import '../app_theme.dart';

class CustemIcon extends StatefulWidget {
  const CustemIcon({Key? key}) : super(key: key);

  @override
  State<CustemIcon> createState() => _CustemIconState();
}

class _CustemIconState extends State<CustemIcon> {
  @override
  Widget build(BuildContext context) {
    return  Card(
     shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(

            color: Colors.white,
            border: Border.all(width: 3,color: AppTheme.primarySwatch.shade500),
            borderRadius: BorderRadius.all(Radius.circular(15))

        ),
        child: Center(child: IconButton(color: AppTheme.primarySwatch.shade500,icon: Icon(Icons.clear,size: 30),onPressed:(){} )),

      ),
    );
  }
}
