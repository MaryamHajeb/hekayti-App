import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/CustemIcon.dart';

class onboardingFour extends StatefulWidget {
  const onboardingFour({Key? key}) : super(key: key);

  @override
  State<onboardingFour> createState() => _onboardingFourState();
}

class _onboardingFourState extends State<onboardingFour> {
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
                top: 25,
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
                      Text('حكايتي',style:AppTheme.textTheme.headline3 ),
                      Text('اختر  شخصيك المفضلة',style:AppTheme.textTheme.headline3 ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('images/girl4.png'),
                          Image.asset('images/girl2.png'),
                          Image.asset('images/girl3.png'),
                          Image.asset('images/boy4.png'),
                          Image.asset('images/boy2.png'),
                          Image.asset('images/boy3.png'),

                        ],),


                    ],
                  ),

                ),
              ),
            )),

      );
  }
}
