import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../util/ScreenUtil.dart';

class CustemInput extends StatefulWidget {
  final valdution;
  final icon;
  final text;
  final type;
  final onching;
  double size;
  final controler;


   CustemInput({Key? key,required this.valdution,  this.icon,required  this.text,  this.type,required this.controler,required this.size, this.onching}) : super(key: key);

  @override
  State<CustemInput> createState() => _CustemInputState();
}

class _CustemInputState extends State<CustemInput> {
  @override
  ScreenUtil screenUtil=ScreenUtil();
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Center(
      child: SizedBox(
        width:widget.size,
        height: 80,
        child: TextFormField(

          validator:widget.valdution,
          keyboardType: widget.type,
          style: AppTheme.textTheme.headline2,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          controller: widget.controler,
          decoration: InputDecoration(
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            fillColor: AppTheme.primarySwatch.shade300,
            filled: true,
            errorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),

              borderSide: BorderSide(color: Colors.transparent),
            ),
            prefixIcon: Icon(widget.icon.icon,color: AppTheme.primaryColor,size: 25),
            hintText: widget.text.toString(),
              hintStyle: TextStyle(color:Colors.grey,fontSize: 13),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),

              borderSide: BorderSide(color: Colors.transparent),
            ),


            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            )
          ),
          cursorColor: AppTheme.primaryColor,
        ),
      ),
    );
  }
}
