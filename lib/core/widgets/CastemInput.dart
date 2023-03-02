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
    return TextFormField(


      validator:widget.valdution,
      keyboardType: widget.type,
      style: AppTheme.textTheme.headline2,
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(

          constraints: BoxConstraints(maxWidth: 200,maxHeight: 40,minWidth: 20,minHeight: 40),
        filled: true,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: AppTheme.primaryColor,),borderRadius: BorderRadius.all(Radius.circular(5))),
        fillColor: AppTheme.primarySwatch.shade100,
        border: OutlineInputBorder(borderSide: BorderSide(width: 1),borderRadius: BorderRadius.all(Radius.circular(5))),
        prefixIcon: Icon(widget.icon.icon,color: AppTheme.primaryColor,size: 25),
        hintText: widget.text.toString(),
        hintStyle: TextStyle(color:Colors.grey,fontSize: 13),
          errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 1))
      ),
      cursorColor: AppTheme.primaryColor,
    );
  }
}
