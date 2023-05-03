import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/CastemLevel.dart';
import '../../../../core/widgets/CustemIcon.dart';
import '../../../../gen/assets.gen.dart';

class onboardingFive extends StatefulWidget {
  const onboardingFive({Key? key}) : super(key: key);

  @override
  State<onboardingFive> createState() => _onboardingFiveState();
}

class _onboardingFiveState extends State<onboardingFive> {
  List Levels = [
    {'num': 1, 'color': AppTheme.primarySwatch.shade800},
    {'num': 2, 'color': AppTheme.primarySwatch.shade600},
    {'num': 3, 'color': AppTheme.primarySwatch.shade400},
  ];
  int itemSelected = 10;
  ScreenUtil screenUtil = ScreenUtil();
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        CircleAvatar(
          maxRadius: 40,
          backgroundColor: Colors.white,
          child: Image.asset(Assets.assest.images.logo.path),
        ),
        Text('حكايتي', style: AppTheme.textTheme.headline3),
        Text('حدد مستوى  القصص التي تريدها لطفلك',
            style: AppTheme.textTheme.headline3),
        SizedBox(
          height: 20,
        ),
        Container(
          height: screenUtil.screenHeight * .3,
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: Levels.length,

            itemBuilder: (context, index) {
              return Row(
                children: [
                  SizedBox(width: 50,),
                  CustemLevel(
                    name: Levels[index]['num'],
                    onTap: () {
                      setState(() {
                        itemSelected = index;
                      });
                    },
                    isSelected: itemSelected == index ? true : false,
                    color: Levels[index]['color'],
                  ),
                  SizedBox(width: 70,)
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
