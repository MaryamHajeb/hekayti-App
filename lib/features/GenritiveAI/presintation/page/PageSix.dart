import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:hikayati_app/features/Regestrion/date/model/userMode.dart';

import '../../../../core/AppTheme.dart';
import '../../../../core/util/CharactersList.dart';
import '../../../../core/util/Common.dart';
import '../../../../core/widgets/CustomCharacters.dart';
import 'package:hikayati_app/features/introdection/presintation/manager/IntroScreenController.dart';

import '../Widget/StoryThemeWidget.dart';

class PageSix extends StatefulWidget {
  const PageSix({Key? key}) : super(key: key);

  @override
  State<PageSix> createState() => _PageSixState();
}

class _PageSixState extends State<PageSix> {
  ScreenUtil screenUtil = ScreenUtil();
  @override
  CharactersList CharactersListlist = CharactersList();


  Widget build(BuildContext context) {
    screenUtil.init(context);
    return GetBuilder<IntroScreenController>(
      init: IntroScreenController(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('حدد نوع الرسم  لقصتك:', style: AppTheme.textTheme.displaySmall),
            Container(
              height: screenUtil.screenHeight * .4,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: CharactersListlist.StoryThemeList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StoryThemeWidget(
                      name:CharactersListlist.StoryThemeList[index]['name'].toString() ,
                      image:
                          CharactersListlist.StoryThemeList[index]['image'].toString(),
                      onTap: () async {
                        controller.selectedCharacter = index;
                        controller.update();
                      },
                      isSelected:
                          controller.selectedCharacter == index ? true : false,
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
