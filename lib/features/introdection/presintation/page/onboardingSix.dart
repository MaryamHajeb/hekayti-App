import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:hikayati_app/features/Regestrion/presintation/page/LoginPage.dart';
import 'package:hikayati_app/features/Regestrion/presintation/page/SignupPage.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/CustemIcon.dart';
import '../../../../core/widgets/CustomPageRoute.dart';

class onboardingSix extends StatefulWidget {
  const onboardingSix({Key? key}) : super(key: key);

  @override
  State<onboardingSix> createState() => _onboardingSixState();
}

class _onboardingSixState extends State<onboardingSix> {
  ScreenUtil screenUtil = ScreenUtil();
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
          child: Container(
        height: screenUtil.screenHeight * .9,
        width: screenUtil.screenWidth * .8,
        margin: EdgeInsets.only(
          top: 25,
        ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                CircleAvatar(
                  maxRadius: 40,
                  backgroundColor: Colors.white,
                  child: Image.asset('images/logo.png'),
                ),
                Text('حكايتي', style: AppTheme.textTheme.headline3),
                Text('هل تريد حفظ بياناتك معنا . ',
                    style: AppTheme.textTheme.headline3),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('images/boy1.png'),

                    Column(
                      children: [
                      ElevatedButton(
                        onPressed: () {

                          Navigator.push(
                              context,
                              CustomPageRoute(  child:   SignupPage()));

                        },
                        child: Text('إنشاء حساب',style: AppTheme.textTheme.bodyText1),

                        style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(AppTheme.primaryColor) ),
                      ),
                      ElevatedButton(
                        onPressed: () {


                            Navigator.push(
                                context,
                                CustomPageRoute(  child:   LoginPage()));

                        },
                        child: Text('تسجيل دخول',style: AppTheme.textTheme.bodyText1),
                        style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(AppTheme.primarySwatch.shade600) ),
                      ),
                    ],),
                    Image.asset('images/girl1.png'),

                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
