import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:hikayati_app/features/Regestrion/date/model/userMode.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/Carecters.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/CastemCarecters.dart';
import 'package:hikayati_app/features/introdection/presintation/manager/IntroScreenController.dart';

class PageSix extends StatefulWidget {
  const PageSix({Key? key}) : super(key: key);

  @override
  State<PageSix> createState() => _PageSixState();
}

class _PageSixState extends State<PageSix> {
  ScreenUtil screenUtil = ScreenUtil();
  @override
  Carecters carecterslist = Carecters();

  Widget build(BuildContext context) {
    screenUtil.init(context);
    return GetBuilder<IntroScreenController>(
      init: IntroScreenController(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('اختر  شخصيك المفضلة', style: AppTheme.textTheme.displaySmall),
            Container(
              height: screenUtil.screenHeight * .4,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: carecterslist.listcarecters.length,
                itemBuilder: (context, index) {
                  return CustemCarecters(
                    image:
                        carecterslist.listcarecters[index]['image'].toString(),
                    onTap: () async {
                      controller.selectedCharacter = index;
                      controller.update();
                    },
                    isSelected:
                        controller.selectedCharacter == index ? true : false,
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
