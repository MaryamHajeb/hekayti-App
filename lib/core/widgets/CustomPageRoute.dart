import 'package:flutter/material.dart';
class CustomPageRoute extends PageRouteBuilder{
  final Widget child;
  CustomPageRoute({
    required this.child,

}):super(
    transitionDuration: Duration(seconds: 1),
    pageBuilder: (context ,animation,secodaryAnimation)=>child ,
  );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,

    Animation<double> secondaryAnimation ,Widget child )=>
    ScaleTransition(
      scale: animation
      ,child: child,);



  }


