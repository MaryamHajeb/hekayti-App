import 'package:flutter/material.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';

import '../../../../core/AppTheme.dart';
import '../../../../gen/assets.gen.dart';

class StarsWidget extends StatelessWidget {
  double star_progrees;
  int all_stars;
  int stars;
  final keythree;
  StarsWidget(
      {super.key,
      required this.star_progrees,
      required this.all_stars,
      required this.stars,
      required this.keythree});

  ScreenUtil screenUtil = ScreenUtil();
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Container(
        key: keythree,
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border.all(color: AppTheme.primarySwatch.shade600, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: screenUtil.screenWidth * .2,
        height: screenUtil.screenHeight * .1,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(
              height: 30,
            ),
            LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              color: Colors.transparent,
              valueColor:
                  AlwaysStoppedAnimation(AppTheme.primarySwatch.shade600),
              minHeight: 38,
              value: star_progrees,
            ),
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Image.asset(
                  Assets.images.start.path,
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  '$stars / $all_stars',
                  style: AppTheme.textTheme.displaySmall,
                ),
              ],
            )
          ],
        ));
    ;
  }
}
