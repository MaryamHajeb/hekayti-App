import 'dart:isolate';
import 'dart:ui';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hikayati_app/features/Home/presintation/page/HomePage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/Carecters.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/CustomPageRoute.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../main.dart';
import '../../../Regestrion/date/model/userMode.dart';
import '../../../Regestrion/presintation/page/LoginPage.dart';
import 'onboardingFive.dart';
import 'onboardingFour.dart';
import 'onboardingOne.dart';
import 'onboardingSix.dart';
import 'onboardingThree.dart';
import 'onboardingTow.dart';

class IntroScreen extends StatefulWidget {
  int index;

  IntroScreen({Key? key,required this.index}) : super(key: key);
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Widget> onboardingList = [
    onboardingOne(),
    onboardingSix(),
    onboardingTow(),
    onboardingThree(),
    onboardingFour(),
    onboardingFive(),
  ];
  ScreenUtil _screenUtil = ScreenUtil();
  Carecters carectersobj =Carecters();

  int currentIndexPage = 0;
  int carectersnum=10;
 String levelnum ='';
  ReceivePort _port = ReceivePort();
int progress=0;
  bool  isLoading =false;
  int?  Carecters_id=0;
  UserModel? userModel;
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
                    'assets/images/backgraond.png',
                  ),
                  fit: BoxFit.fill),
            ),
            height: _screenUtil.screenHeight * 1,
            width: _screenUtil.screenWidth * 1,
            child: PageView.builder(
              controller: pageController,
              allowImplicitScrolling: false,
            //  physics: NeverScrollableScrollPhysics(),
              itemCount: onboardingList.length,
              itemBuilder: (context, index) {
                if(widget.index!=0){
                index=widget.index;
                currentIndexPage=widget.index;
                print(index);
                widget.index=0;
                print(index);


                }
                return Stack(
                  children: [
                    isLoading   ?Directionality( textDirection: TextDirection.rtl,child: initApp('جاري تحميل القصص  ')):

                    Center(
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
                                              flex: 10,
                                                child: onboardingList[index]),

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
                                                            duration: Duration(milliseconds: 1000),
                                                            curve: Curves.fastOutSlowIn);
                                                      },
                                                      child: Image.asset(
                                                          color: AppTheme.primarySwatch.shade400,
                                                        Assets.images.leftArrow.path,
                                                        width: 30,
                                                        height: 30,
                                                        fit: BoxFit.fill,
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

                                                        if (_formKey.currentState!.validate()){
                                                          // If the form is valid, display a snackbar. In the real world,





                                                            print(index);
                                                            if(index==3){

                                                              // CachedDate('Carecters',0);
                                                              // CachedDate('collected_stars',0);
                                                              // CachedDate('all_stars',0);
                                                               CachedDate('Listen_to_story',true);


                                                            }if(index==2){

                                                            }


                                                            SharedPreferences prefs;
                                                            index==5 ?
                                                            {
                                                               userModel = getCachedDate('UserInformation',UserModel.init() ),

                                                              if(await networkInfo
                                                                  .isConnected)
                                                                {

                                                                  prefs =
                                                                  await SharedPreferences
                                                                      .getInstance(),
                                                                  prefs.setBool(
                                                                      'onbording',
                                                                      true),
                                                                  setState(() {
                                                                    isLoading =
                                                                    true;
                                                                  }),


                                                                   db.initApp(userModel!.level.toString(),'1'),

                                                                  await Future
                                                                      .delayed(
                                                                      Duration(seconds: 20)),
                                                                  setState(() {
                                                                    isLoading =
                                                                    false;
                                                                  }),

                                                                  Navigator
                                                                      .push(
                                                                      context,
                                                                      CustomPageRoute(
                                                                          child: HomePage()))
                                                                }else{
                                                                showImagesDialog(context,'${carectersobj.showCarecters[Carecters_id!]['image']}','تاكد من وجود انترنت اول مره من اجل تحميل القصص',(){ Navigator.pop(context);})
                                                              }
                                                            }

                                                               :
                                                            pageController.nextPage(
                                                                duration: Duration(
                                                                  seconds: 1,
                                                                ),
                                                                curve: Curves.fastOutSlowIn);

                                                          }

                                                          // you'd often call a server or save the information in a database.

                                                      },
                                                      child: Image.asset(
                                                        color: AppTheme.primarySwatch.shade800,

                                                        Assets.images.rightArrow.path,
                                                        width: 30,
                                                        height: 30,
                                                        fit: BoxFit.fill,
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
                    ),
                  ],
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


  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();

  }
}
