import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hikayati_app/core/app_theme.dart';
import 'package:hikayati_app/features/Home/presintation/page/HomePage.dart';
import 'package:hikayati_app/features/introdection/presintation/page/IntroScreen.dart';
import 'package:hikayati_app/gen/assets.gen.dart';

import '../../../../main.dart';

class Splach_screen extends StatefulWidget {
  @override
  _Splach_screenState createState() => _Splach_screenState();
}

class _Splach_screenState extends State<Splach_screen>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  AnimationController? _controller;
  Animation<double>? animation1;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller!, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller!.forward();

    Timer(Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.4;
      });
    });

    Timer(Duration(seconds: 2), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(Duration(seconds: 4), () {
      setState(() {
        Navigator.pushReplacement(context, PageTransition( islogin ?    HomePage():IntroScreen()));
      });
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                AnimatedContainer(

                    duration: Duration(milliseconds: 2000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: _height / _fontSize,

                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 2000),
                  opacity: _textOpacity,
                  child: Text(
                    'حكايتي',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: AppTheme.fontFamily,
                      fontSize: animation1!.value,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: AnimatedOpacity(

              duration: Duration(milliseconds: 2000),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 2000),
                curve: Curves.fastLinearToSlowEaseIn,
                height: 120,
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 3,color: Colors.white),
                  color: Colors.white.withOpacity(.9),
                  borderRadius: BorderRadius.circular(100),
                ),
                // child: Image.asset('assets/images/file_name.png')
                child: CircleAvatar(
                    radius: 50,
                    child: Image.asset(Assets.images.logo.path)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageTransition extends PageRouteBuilder {
  final Widget page;

  PageTransition(this.page)
      : super(
    pageBuilder: (context, animation, anotherAnimation) => page,
    transitionDuration: Duration(milliseconds: 2000),
    transitionsBuilder: (context, animation, anotherAnimation, child) {
      animation = CurvedAnimation(
        curve: Curves.fastLinearToSlowEaseIn,
        parent: animation,
      );
      return Align(
        alignment: Alignment.bottomCenter,
        child: SizeTransition(
          sizeFactor: animation,
          child: page,
          axisAlignment: 0,
        ),
      );
    },
  );
}
