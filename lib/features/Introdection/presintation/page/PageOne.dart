import 'package:flutter/material.dart';

import 'package:hikayati_app/core/util/ScreenUtil.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/common.dart';
import '../../../../gen/assets.gen.dart';
import '../../../Regestrion/date/model/userMode.dart';

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  ScreenUtil screenUtil = ScreenUtil();
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          maxRadius: 30,
          backgroundColor: Colors.white,
          child: Image.asset(Assets.images.logo.path),
        ),
        Text('حكايتي', style: AppTheme.textTheme.displaySmall),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                height: screenUtil.screenHeight * .4,
                width: screenUtil.screenWidth * .3,
                child: Image.asset(Assets.images.carecters.abdu.left.path)),
            Container(
                height: screenUtil.screenHeight * .4,
                width: screenUtil.screenWidth * .3,
                child: Image.asset(Assets.images.carecters.mariam.happy.path)),
          ],
        ),
        Text('مرحبا بك.', style: AppTheme.textTheme.displaySmall),
        Text('في تطبيق حكايتي', style: AppTheme.textTheme.displaySmall),
      ],
    );
  }
}
