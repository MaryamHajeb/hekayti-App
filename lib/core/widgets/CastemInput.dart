import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../util/ScreenUtil.dart';

class CastemInput extends StatefulWidget {
  final valdution;
  final icon;
  final text;
  final type;
  final size;
  final controler;


   CastemInput({Key? key,required this.valdution, required this.icon,required  this.text,  this.type,required this.controler, this.size}) : super(key: key);

  @override
  State<CastemInput> createState() => _CastemInputState();
}

class _CastemInputState extends State<CastemInput> {
  @override
  ScreenUtil screenUtil=ScreenUtil();
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Container(
        width: screenUtil.screenWidth *.3,
        decoration: BoxDecoration(
            border: Border.all(width: 2,color: AppTheme.primarySwatch.shade400),
            color: AppTheme.primarySwatch.shade200,
            borderRadius: BorderRadius.circular(10)

        ),
        child: Center(
          child: TextFormField(

            validator:widget.valdution,
            keyboardType: widget.type,
            style: AppTheme.textTheme.bodyText1,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              prefixIcon: Icon(widget.icon.icon,color: AppTheme.primaryColor,size: 25),
              hintText: widget.text.toString(),
                hintStyle: TextStyle(color:Colors.grey,fontSize: 13),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),


              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              )
            ),
            cursorColor: AppTheme.primaryColor,
          ),
        )

    );
  }
}
