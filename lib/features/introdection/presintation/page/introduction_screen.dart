import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/app_theme.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:hikayati_app/features/introdection/presintation/page/onboardingFive.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/widgets/CustemIcon.dart';
import '../../../../core/widgets/CustomPageRoute.dart';
import 'onboardingFour.dart';
import 'onboardingOne.dart';
import 'onboardingSix.dart';
import 'onboardingThree.dart';
import 'onboardingTow.dart';

class introduction_screen extends StatefulWidget {
  introduction_screen({Key? key}) : super(key: key);

  @override
  State<introduction_screen> createState() => _introduction_screenState();
}

class _introduction_screenState extends State<introduction_screen> {
  List<Widget> imageList = [
    onboardingOne(),
    onboardingTow(),
    onboardingThree(),
    onboardingFour(),
    onboardingFive(),
    onboardingSix(),

  ];
  ScreenUtil screenUtil = ScreenUtil();
  int currentIndex = 0;
  final CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(children: [
              Stack(
                children: [
             Container(

               height: screenUtil.screenHeight *1,
               width: screenUtil.screenWidth *1,
               decoration:  const BoxDecoration(

                 image: DecorationImage(image: AssetImage('images/backgraond.png',),fit: BoxFit.fill),
               ),
             ),
                  InkWell(
                    onTap: () {
                      print(currentIndex);
                    },
                    child: Center(
                        child: Container(

                             width: screenUtil.screenWidth *1,
                             height: screenUtil.screenHeight *1,
                          child: CarouselSlider(
                           disableGesture: true,
                            items: imageList,
                            options: CarouselOptions(
                              viewportFraction: 1,
                              reverse: false,
                              initialPage: 0,
                              enlargeCenterPage: true,
                              disableCenter: false,
                              padEnds: true,
                              enlargeFactor: 100,
                              enableInfiniteScroll: true,
                              pageSnapping: true,
                              animateToClosest: true,
                              pauseAutoPlayOnTouch: false,
                              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                              scrollPhysics: BouncingScrollPhysics(),
                              pauseAutoPlayInFiniteScroll: false,
                              pauseAutoPlayOnManualNavigate: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                            ),
                          ),
                        )),
                  ),
                 currentIndex ==5?Padding(
                   padding: const EdgeInsets.only(top: 340.0,right: 200),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       InkWell(
                         onTap: (){
                           setState(() {
                             currentIndex =currentIndex+1;

                           });
                         },
                         child: SvgPicture.asset(
                           color: AppTheme.primarySwatch.shade500,
                           'images/bottons/leftarrow.svg',
                         ),
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: imageList.asMap().entries.map((entry) {
                           return GestureDetector(
                             onTap: () =>
                                 carouselController.animateToPage(entry.key),
                             child: Container(
                               width: currentIndex == entry.key ? 17 : 7,
                               height: 7.0,
                               margin: const EdgeInsets.symmetric(
                                 horizontal: 3.0,
                               ),
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),
                                   color: currentIndex == entry.key
                                       ? AppTheme.primaryColor
                                       : Colors.grey),
                             ),
                           );
                         }).toList(),
                       ),

                     ],
                   ),
                 ):
                 currentIndex ==0?
                  Padding(
                    padding: const EdgeInsets.only(top: 340.0,left: 200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: imageList.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () =>
                                  carouselController.animateToPage(entry.key),
                              child: Container(
                                width: currentIndex == entry.key ? 17 : 7,
                                height: 7.0,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3.0,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: currentIndex == entry.key
                                        ? AppTheme.primaryColor
                                        : Colors.grey),
                              ),
                            );
                          }).toList(),
                        ),
                        SvgPicture.asset(
                          color: AppTheme.primarySwatch.shade500,
                          'images/bottons/rightarrow.svg',
                        ),
                      ],
                    ),
                  ):Padding(
                   padding: const EdgeInsets.only(top: 340.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       SvgPicture.asset(
                         color: AppTheme.primarySwatch.shade500,
                         'images/bottons/leftarrow.svg',
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: imageList.asMap().entries.map((entry) {
                           return GestureDetector(
                             onTap: () =>
                                 carouselController.animateToPage(entry.key),
                             child: Container(
                               width: currentIndex == entry.key ? 17 : 7,
                               height: 7.0,
                               margin: const EdgeInsets.symmetric(
                                 horizontal: 3.0,
                               ),
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),
                                   color: currentIndex == entry.key
                                       ? AppTheme.primaryColor
                                       : Colors.grey),
                             ),
                           );
                         }).toList(),
                       ),
                       SvgPicture.asset(
                         color: AppTheme.primarySwatch.shade500,
                         'images/bottons/rightarrow.svg',
                       ),
                     ],
                   ),
                 )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void onDone(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ON_BOARDING', false);
    // Navigator.pushReplacement(
    //     context,
    //     CustomPageRoute( ));
  }
}
