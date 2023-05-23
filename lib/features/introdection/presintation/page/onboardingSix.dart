import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:hikayati_app/features/Regestrion/presintation/page/LoginPage.dart';
import 'package:hikayati_app/features/Regestrion/presintation/page/SignupPage.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/CustemIcon.dart';
import '../../../../core/widgets/CustomPageRoute.dart';
import '../../../../gen/assets.gen.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        CircleAvatar(
          maxRadius: 40,
          backgroundColor: Colors.white,
          child: Image.asset(Assets.images.logo.path),
        ),
        Text('حكايتي', style: AppTheme.textTheme.headline3),
        Text('هل تريد حفظ بياناتك معنا . ',
            style: AppTheme.textTheme.headline3),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                height: screenUtil.screenHeight *.4,
                width: screenUtil.screenWidth * .2,
                child: Image.asset(Assets.images.carecters.mariam.sing.path)),

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
            Container(
                height: screenUtil.screenHeight *.4,
                width: screenUtil.screenWidth * .2,
                child: Image.asset(Assets.images.carecters.abdu.sing.path)),

          ],
        ),
      ],
    );
  }
}
