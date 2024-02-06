import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:hikayati_app/features/introdection/presintation/manager/IntroScreenController.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/util/Carecters.dart';
import '../../../../core/widgets/CastemLevel.dart';
import '../../../../gen/assets.gen.dart';

class PageFive extends StatefulWidget {
  const PageFive({Key? key}) : super(key: key);

  @override
  State<PageFive> createState() => _PageFiveState();
}

class _PageFiveState extends State<PageFive> {
  Carecters carecters = Carecters();

  ScreenUtil screenUtil = ScreenUtil();
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return GetBuilder<IntroScreenController>(
      init: IntroScreenController(),
      builder: (controller) {
        return Column(
          children: [
            CircleAvatar(
              maxRadius: 30,
              backgroundColor: Colors.white,
              child: Image.asset(Assets.images.logo.path),
            ),
            Text('حكايتي', style: AppTheme.textTheme.displaySmall),
            SizedBox(
              height: screenUtil.screenHeight * .05,
            ),
            Text('حدد مستوى  القصص التي تريدها لطفلك :',
                style: AppTheme.textTheme.displaySmall),
            SizedBox(
              height: screenUtil.screenHeight * .08,
            ),
            Container(
              height: screenUtil.screenHeight * .32,
              width: double.infinity,
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: carecters.Levels.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenUtil.screenWidth * .03),
                      child: CustemLevel(
                        name: carecters.Levels[index]['num'],
                        onTap: () async {
                          controller.selectedLevel = index;
                          controller.update();
                        },
                        isSelected:
                            controller.selectedLevel == index ? true : false,
                        color: carecters.Levels[index]['color'],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
