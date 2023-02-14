import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/CustemIcon.dart';

class onboardingThree extends StatefulWidget {
  const onboardingThree({Key? key}) : super(key: key);

  @override
  State<onboardingThree> createState() => _onboardingThreeState();
}

class _onboardingThreeState extends State<onboardingThree> {
ScreenUtil screenUtil=ScreenUtil();
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return
            Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
            child: Container(
                height:  screenUtil.screenHeight * .9,
                width:screenUtil.screenWidth *.8,
              margin: EdgeInsets.only(
                top: 0,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.only(bottom: 50),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          width: 4, color: AppTheme.primarySwatch.shade500),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      CircleAvatar(maxRadius: 40,backgroundColor: Colors.white,child: Image.asset('images/logo.png'),),
                       Text('حكايتي',style:AppTheme.textTheme.bodySmall ),
                      Text('قم  بإدخال اسم طفلك',style:AppTheme.textTheme.bodySmall ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('images/boy1.png'),
                          Column(children: [

                            Container(

                                height: screenUtil.screenHeight *.1,
                                width: screenUtil.screenWidth *.3,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 2,color: AppTheme.primarySwatch.shade400),
                                    color: AppTheme.primarySwatch.shade200,
                                    borderRadius: BorderRadius.circular(10)

                                ),
                                margin: EdgeInsets.only(top: 20, left: 50, right: 50),
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  style: AppTheme.textTheme.headline6,
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent),
                                    ),
                                  ),
                                  cursorColor: AppTheme.primaryColor,
                                )

                            ),

                          ],),
                          Image.asset('images/girl1.png'),


                        ],),


                    ],
                  ),

                ),
              ),
            )),

    );
  }
}
