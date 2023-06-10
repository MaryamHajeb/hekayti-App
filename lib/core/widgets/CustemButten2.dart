import 'package:flutter/material.dart';

import '../app_theme.dart';

class CustemButten2 extends StatelessWidget {

   CustemButten2({Key? key,required this.ontap,required this.text}) : super(key: key);
  Function ontap;
  final text;
  @override
  Widget build(BuildContext context) {
    return                      ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9))),
            padding: EdgeInsets.all(0),
            backgroundColor: Color(0xFFF7BCA3),side: BorderSide( color: Colors.white,)),

        onPressed: (){
          ontap();
    }, child: Container(
        width: 60,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 3,color: AppTheme.primarySwatch.shade200),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Center(child: Text(text,style: TextStyle(fontSize: 14,fontFamily: AppTheme.fontFamily,color:Color(0xFFF7BCA3)),))));

  }
}
