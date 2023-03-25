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
    return Center(
      child: SizedBox(
        width: 200,

        child: TextFormField(


          validator:widget.valdution,
          keyboardType: widget.type,
          style: AppTheme.textTheme.headline2,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            fillColor: AppTheme.primarySwatch.shade300,
            filled: true,
            errorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),

              borderSide: BorderSide(color: Colors.transparent),
            ),
            prefixIcon: Icon(widget.icon.icon,color: AppTheme.primaryColor,size: 25),
            hintText: widget.text.toString(),
              hintStyle: TextStyle(color:Colors.grey,fontSize: 13),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),

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
