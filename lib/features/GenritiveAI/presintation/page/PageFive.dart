import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:hikayati_app/features/introdection/presintation/manager/IntroScreenController.dart';
import '../../../../core/AppTheme.dart';

import '../../../../core/util/CharactersList.dart';
import '../../../../core/widgets/CustomLevelWidget.dart';
import '../../../../gen/assets.gen.dart';

class PageFive extends StatefulWidget {
  const PageFive({Key? key}) : super(key: key);

  @override
  State<PageFive> createState() => _PageFiveState();
}

class _PageFiveState extends State<PageFive> {
  CharactersList charactersList = CharactersList();

  ScreenUtil screenUtil = ScreenUtil();
  int selected = 0;
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
                  itemCount: charactersList.Levels.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenUtil.screenWidth * .03),
                      child: CustomLevelWidget(
                        name: charactersList.Levels[index]['num'],
                        onTap: () async {
                          selected = index;
                          controller.selectedLevel = index + 1;
                          controller.update();
                        },
                        isSelected: selected == index ? true : false,
                        color: charactersList.Levels[index]['color'],
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
