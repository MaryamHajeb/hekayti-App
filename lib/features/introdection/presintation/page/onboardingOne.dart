import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/CustemIcon.dart';
import '../../../../gen/assets.gen.dart';

class onboardingOne extends StatefulWidget {
  const onboardingOne({Key? key}) : super(key: key);

  @override
  State<onboardingOne> createState() => _onboardingOneState();
}

class _onboardingOneState extends State<onboardingOne> {
ScreenUtil screenUtil=ScreenUtil();
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(maxRadius: 30,backgroundColor: Colors.white,child: Image.asset(Assets.images.logo.path),),
          Text('حكايتي',style:AppTheme.textTheme.headline3 ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Container(
                  height: screenUtil.screenHeight *.4,
                  width: screenUtil.screenWidth * .3,
                  child: Image.asset(Assets.images.carecters.abdu.left.path)),
              Container(
                  height: screenUtil.screenHeight *.4,
                  width: screenUtil.screenWidth * .3,
                  child: Image.asset(Assets.images.carecters.mariam.happy.path)),



            ],),
          Text('مرحبا بك.',style:AppTheme.textTheme.headline3 ),
          Text('في تطبيق حكايتي',style:AppTheme.textTheme.headline3 ),

        ],
      );
  }
}
