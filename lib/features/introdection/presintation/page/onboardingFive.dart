import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/Carecters.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/CastemLevel.dart';
import '../../../../core/widgets/CustemIcon.dart';
import '../../../../gen/assets.gen.dart';

class onboardingFive extends StatefulWidget {
  const onboardingFive({Key? key}) : super(key: key);

  @override
  State<onboardingFive> createState() => _onboardingFiveState();
}

class _onboardingFiveState extends State<onboardingFive> {
  Carecters carecters=Carecters();
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
          child: Image.asset(Assets.images.logo.path),
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
            itemCount:carecters.Levels.length,

            itemBuilder: (context, index) {
              return Row(
                children: [
                  SizedBox(width: 50,),
                  CustemLevel(
                    name:carecters.Levels[index]['num'],
                    onTap: () async{
                      setState(() {
                        itemSelected = index;
                      });

                      int dd=int.parse(carecters.Levels[index]['id'].toString());
                      CachedDate('level',dd);


                    },
                    isSelected: itemSelected == index ? true : false,
                    color: carecters.Levels[index]['color'],
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
