import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../gen/assets.gen.dart';

class ChartCard extends StatefulWidget {
  const ChartCard({Key? key}) : super(key: key);

  @override
  State<ChartCard> createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  @override
  ScreenUtil screenUtil=ScreenUtil();

  Widget build(BuildContext context) {
    screenUtil.init(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(

        margin: EdgeInsets.only(right: 40,left: 40,top: 30),
        shape: ContinuousRectangleBorder(


            borderRadius: BorderRadius.all(Radius.circular(25))),
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: AppTheme.primaryColor,width: 2)
          ),
width: screenUtil.screenWidth *.6,
 height: screenUtil.screenHeight *.2,
            child: Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset(Assets.images.story1.path)),
            Text('مشت ليلى عبر الغابة ',style:AppTheme.textTheme.headline5,overflow: TextOverflow.clip, textDirection: TextDirection.rtl,textAlign: TextAlign.right),

            Text('90%',style:AppTheme.textTheme.headline3 ,textDirection: TextDirection.rtl,textAlign: TextAlign.right),


          ],
        )),
      ),
    );
  }
}
