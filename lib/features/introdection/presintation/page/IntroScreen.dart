import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/features/Home/presintation/page/HomePage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/CustomPageRoute.dart';
import '../../../../gen/assets.gen.dart';
import '../../../Regestrion/presintation/page/LoginPage.dart';
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
  List<Widget> onboardingList = [
    onboardingOne(),
    onboardingTow(),
    onboardingThree(),
    onboardingFour(),
    onboardingFive(),
    onboardingSix(),
  ];
  ScreenUtil _screenUtil = ScreenUtil();
  int currentIndexPage = 0;
  int carectersnum=10;
  final _formKey = GlobalKey<FormState>();
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assest/images/backgraond.png',
                  ),
                  fit: BoxFit.fill),
            ),
            height: _screenUtil.screenHeight * 1,
            width: _screenUtil.screenWidth * 1,
            child: PageView.builder(
              controller: pageController,
              allowImplicitScrolling: false,
              physics: NeverScrollableScrollPhysics(),
              itemCount: onboardingList.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Column(
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Center(

                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(

                                  height:  _screenUtil.screenHeight * .95,
                                  width:_screenUtil.screenWidth *.85,

                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 4, color: AppTheme.primarySwatch.shade500),
                                          borderRadius: BorderRadius.all(Radius.circular(15))),
                                      child: Column(children: [
                                        Expanded(
                                          flex: 9,
                                            child: onboardingList[index]),
                                        SizedBox(height: 0,),
                                        Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: Expanded(
                                            flex: 2,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    //
                                                    pageController.previousPage(
                                                        duration: Duration(seconds: 1),
                                                        curve: Curves.bounceInOut);
                                                  },
                                                  child: Image.asset(
                                                    color: AppTheme.primarySwatch.shade500,
                                                    'assest/images/left_arrow.png',
                                                  ),
                                                ),

                                                DotsIndicator(
                                                  dotsCount: onboardingList.length,
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
                                                InkWell(
                                                  onTap: () async{
                                                    initdata();

                                                    if (_formKey.currentState!.validate()){
                                                      // If the form is valid, display a snackbar. In the real world,

                                                      if(index ==3){
                                                       if(carectersnum <  5){

                                                         pageController.nextPage(
                                                             duration: Duration(
                                                               seconds: 1,
                                                             ),
                                                             curve: Curves.linear);

                                                       }
                                                       else{

                                                         print('يرجئ اختيار شخصيه');
                                                         showImagesDialog(context,Assets.assest.images.carecters.abdu.sad.path,'يرجئ اختيار شخصيه');
                                                       }
                                                       
                                                       }

                                                      else{


                                                        print(index);
                                                        index==5 ?

                                                        Navigator.push(
                                                            context,
                                                            CustomPageRoute(  child:   HomePage()))
                                                            :
                                                        pageController.nextPage(
                                                            duration: Duration(
                                                              seconds: 1,
                                                            ),
                                                            curve: Curves.linear);

                                                      }

                                                      // you'd often call a server or save the information in a database.
                                                    }
                                                  },
                                                  child: Image.asset(
                                                    color: AppTheme.primarySwatch.shade500,
                                                    'assest/images/right_arrow.png',
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        )
                                      ], ),

                                    ),
                                  ),
                                ),
                              )),

                        ),

                  ]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initdata();
  }
  initdata()async{

    int   Carecters=await   getCachedDate('Carecters',String) ?? 10;
    carectersnum=Carecters;




  }
}
