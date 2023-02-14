import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/CustemIcon.dart';

class onboardingFive extends StatefulWidget {
  const onboardingFive({Key? key}) : super(key: key);

  @override
  State<onboardingFive> createState() => _onboardingFiveState();
}

class _onboardingFiveState extends State<onboardingFive> {
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
          top: 0,
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
                Text('حكايتي', style: AppTheme.textTheme.bodySmall),
                Text('حدد مستوى  القصص التي تريدها لطفلك',
                    style: AppTheme.textTheme.bodySmall),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppTheme.primarySwatch.shade900,

                          borderRadius: BorderRadius.all(Radius.circular(11))),
                      height: screenUtil.screenHeight * .2,
                      width: screenUtil.screenWidth * .1,
                      child: Center(child: Text('1',style: AppTheme.textTheme.headline5,)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppTheme.primarySwatch.shade700,

                          borderRadius: BorderRadius.all(Radius.circular(11))),
                      height: screenUtil.screenHeight * .2,
                      width: screenUtil.screenWidth * .1,
                      child: Center(child: Text('2',style: AppTheme.textTheme.headline5,)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppTheme.primarySwatch.shade600,

                          borderRadius: BorderRadius.all(Radius.circular(11))),
                      height: screenUtil.screenHeight * .2,
                      width: screenUtil.screenWidth * .1,
                      child: Center(child: Text('3',style: AppTheme.textTheme.headline5,)),
                    ),


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
