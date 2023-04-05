import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/util/ScreenUtil.dart';
import 'onboardingFive.dart';
import 'onboardingFour.dart';
import 'onboardingOne.dart';
import 'onboardingSix.dart';
import 'onboardingThree.dart';
import 'onboardingTow.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Widget> imageList = [
    onboardingOne(),
    onboardingTow(),
    onboardingThree(),
    onboardingFour(),
    onboardingFive(),
    onboardingSix(),
  ];
  ScreenUtil _screenUtil = ScreenUtil();
  int currentIndexPage = 0;
  final _formKey = GlobalKey<FormState>();
  PageController pageController=PageController();
  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return Scaffold(
      body: Form(
        key:_formKey ,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: SingleChildScrollView(
            child: Container(
              decoration:  const BoxDecoration(
                image: DecorationImage(image: AssetImage('images/backgraond.png',),fit: BoxFit.fill),
              ),


              height: _screenUtil.screenHeight * 1,
              width:_screenUtil.screenWidth *1 ,
              child: PageView.builder(
                controller: pageController,
                allowImplicitScrolling: false,
                 physics: NeverScrollableScrollPhysics(),
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Center(
                      child: Stack(

                          children: [imageList[index],

                        Padding(
                          padding: const EdgeInsets.only(top: 350.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // InkWell(
                              //   onTap: (){
                              //   //
                              //     pageController.previousPage(duration: Duration(seconds: 3), curve: Curves.bounceInOut);
                              //
                              //   },
                              //   child: SvgPicture.asset(
                              //     color: AppTheme.primarySwatch.shade500,
                              //     'images/bottons/leftarrow.svg',
                              //   ),
                              // ),

                              DotsIndicator(
                                dotsCount: imageList.length,
                                position: index.toDouble(),
                                decorator: DotsDecorator(
                                  size: const Size.square(9.0),
                                  color: AppTheme.primaryColor,
                                  activeColor: AppTheme.primaryColor,
                                  activeSize: const Size(30.0, 9.0),
                                  activeShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
    //                            InkWell(
    //                              onTap: (){
    // if (_formKey.currentState!.validate()) {
    //     // If the form is valid, display a snackbar. In the real world,
    //   pageController.nextPage(duration: Duration(seconds: 5,), curve:Curves.linear);
    //
    //     // you'd often call a server or save the information in a database.
    // }
    //
    //                              },
    //                              child: SvgPicture.asset(
    //                               color: AppTheme.primarySwatch.shade500,
    //                               'images/bottons/rightarrow.svg',
    //
    //                           ),
    //                            ),

                            ],
                          ),
                        )

                      ]),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
