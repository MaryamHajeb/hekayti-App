import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:hikayati_app/features/Regestrion/date/model/userMode.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/CastemInput.dart';
import '../../../../gen/assets.gen.dart';
import 'package:hikayati_app/features/introdection/presintation/manager/IntroScreenController.dart';

class PageFour extends StatefulWidget {
  const PageFour({Key? key}) : super(key: key);

  @override
  State<PageFour> createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  ScreenUtil screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return GetBuilder<IntroScreenController>(
      init: IntroScreenController(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              maxRadius: 30,
              backgroundColor: Colors.white,
              child: Image.asset(Assets.images.logo.path),
            ),
            Text('حكايتي', style: AppTheme.textTheme.displaySmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: screenUtil.screenHeight * .4,
                  width: screenUtil.screenWidth * .2,
                  child: Image.asset(Assets.images.carecters.hasham.happy.path),
                ),
                Column(
                  children: [
                    Text('قم بإدخال اسم طفلك',
                        style: AppTheme.textTheme.displaySmall),
                    SizedBox(
                      height: screenUtil.screenHeight * .05,
                    ),
                    CustemInput(
                      size: 200,
                      onching: (value) {
                        controller.userModel!.user_name = value.toString();
                        controller.update();
                      },
                      valdution: (value) {
                        if (value.toString().isEmpty) {
                          return 'يرجى منك ادخال اسم الطفل ';
                        } else if (!RegExp(
                                r"^([\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z]+)$")
                            .hasMatch(value)) {
                          return "لا يمكن ان يحتوي اسم الطفل على ارقام او رموز";
                        }
                        return null;
                      },
                      controler:
                          controller.name, // Use a TextEditingController here
                      text: 'مثال  :  محمد',
                      type: TextInputType.text,
                    )
                  ],
                ),
                Container(
                  height: screenUtil.screenHeight * .4,
                  width: screenUtil.screenWidth * .2,
                  child: Image.asset(Assets.images.carecters.hana.happy.path),
                ),
              ],
            ),
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
}
