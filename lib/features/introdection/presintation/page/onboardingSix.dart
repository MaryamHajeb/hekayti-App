import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/CustemIcon.dart';

class onboardingSix extends StatefulWidget {
  const onboardingSix({Key? key}) : super(key: key);

  @override
  State<onboardingSix> createState() => _onboardingSixState();
}

class _onboardingSixState extends State<onboardingSix> {
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
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          width: 4, color: AppTheme.primarySwatch.shade500),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 15,),
                      CircleAvatar(maxRadius: 40,backgroundColor: Colors.white,child: Image.asset('images/logo.png'),),
                       Text('حكايتي',style:AppTheme.textTheme.bodySmall ),
                          Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            // SvgPicture.asset(
                            //   allowDrawingOutsideViewBox: true,
                            //   'images/characters/boy1-3.svg',
                            //
                            // ),

                          ],),

                      Text('مرحبا بك.',style:AppTheme.textTheme.bodySmall ),
                      Text('في تطبيق حكايتي',style:AppTheme.textTheme.headline5 ),

                    ],
                  ),

                ),
              ),
            )),

    );
  }
}
