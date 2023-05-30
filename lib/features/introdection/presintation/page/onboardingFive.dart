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
  int itemSelected = 0;
  ScreenUtil screenUtil = ScreenUtil();
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(height: 10,),

        Text('حدد مستوى  القصص التي تريدها لطفلك :',
            style: AppTheme.textTheme.headline3),

        Container(
          margin: EdgeInsets.only(right: 20),
          height: screenUtil.screenHeight * .5,
          width: double.infinity,
          child: Center(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount:carecters.Levels.length,

              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    CustemLevel(
                      name:carecters.Levels[index]['num'],
                      onTap: () async{
                        setState(() {
                          itemSelected = index;
                        });

                        int dd=int.parse(carecters.Levels[index]['id'].toString());
                        CachedDate('level',itemSelected);


                      },
                      isSelected: itemSelected == index ? true : false,
                      color: carecters.Levels[index]['color'],
                    ),
                    SizedBox(width: 70,)
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
