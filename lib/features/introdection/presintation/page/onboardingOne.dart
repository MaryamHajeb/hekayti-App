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
            Center(
              child: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
              child: Container(
                  height:  screenUtil.screenHeight * .9,
                  width:screenUtil.screenWidth *.8,
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
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(maxRadius: 40,backgroundColor: Colors.white,child: Image.asset(Assets.assest.images.logo.path),),
                          Text('حكايتي',style:AppTheme.textTheme.headline3 ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                Container(
                              height: screenUtil.screenHeight *.4,
                              width: screenUtil.screenWidth * .3,
                              child: Image.asset(Assets.assest.images.carecters.abdu.happy.path)),
                                Container(
                              height: screenUtil.screenHeight *.4,
                              width: screenUtil.screenWidth * .3,
                              child: Image.asset(Assets.assest.images.carecters.mariam.happy.path)),



                              ],),
                          Text('مرحبا بك.',style:AppTheme.textTheme.headline3 ),
                          Text('في تطبيق حكايتي',style:AppTheme.textTheme.headline3 ),

                        ],
                      ),
                    ),

                  ),
                ),
              )),

    ),
            );
  }
}
