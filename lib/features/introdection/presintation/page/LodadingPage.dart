import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../gen/assets.gen.dart';

class LodadingPage extends StatefulWidget {
  const LodadingPage({Key? key}) : super(key: key);

  @override
  State<LodadingPage> createState() => _LodadingPageState();
}

class _LodadingPageState extends State<LodadingPage> {
  @override
  ScreenUtil _screenUtil = ScreenUtil();

  Widget build(BuildContext context) {
    _screenUtil.init(context);

    return Scaffold(body: Column(
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
                height: _screenUtil.screenHeight *.4,
                width: _screenUtil.screenWidth * .3,
                child: Image.asset(Assets.images.carecters.abdu.left.path)),
            Container(
                height: _screenUtil.screenHeight *.4,
                width: _screenUtil.screenWidth * .3,
                child: Image.asset(Assets.images.carecters.mariam.happy.path)),



          ],),
        Text('مرحبا بك.',style:AppTheme.textTheme.headline3 ),
        Text('في تطبيق حكايتي',style:AppTheme.textTheme.headline3 ),

      ],
    ),);
  }
}
