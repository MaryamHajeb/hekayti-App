import 'package:flutter/material.dart';

import 'package:hikayati_app/core/util/ScreenUtil.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/Carecters.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/CastemLevel.dart';
import '../../../Regestrion/date/model/userMode.dart';

class onboardingFive extends StatefulWidget {
  const onboardingFive({Key? key}) : super(key: key);

  @override
  State<onboardingFive> createState() => _onboardingFiveState();
}

class _onboardingFiveState extends State<onboardingFive> {
  Carecters carecters = Carecters();
  int itemSelected = 0;
  ScreenUtil screenUtil = ScreenUtil();
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 10,
        ),
        Text('حدد مستوى  القصص التي تريدها لطفلك :',
            style: AppTheme.textTheme.displaySmall),
        Container(
          margin: EdgeInsets.only(right: 20),
          height: screenUtil.screenHeight * .5,
          width: double.infinity,
          child: Center(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: carecters.Levels.length,
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustemLevel(
                      name: carecters.Levels[index]['num'],
                      onTap: () async {
                        setState(() {
                          itemSelected = index;
                        });

                        int dd = int.parse(
                            carecters.Levels[index]['num'].toString());
                        UserModel? usermodel =
                            getCachedDate('UserInformation', UserModel.init());

                        CachedDate(
                            'UserInformation',
                            UserModel(
                                user_name: usermodel?.user_name,
                                email: usermodel?.email,
                                level: dd,
                                character: usermodel?.character,
                                update_at: DateTime.now().toString(),
                                password: usermodel?.password,
                                id: usermodel?.id));
                      },
                      isSelected: itemSelected == index ? true : false,
                      color: carecters.Levels[index]['color'],
                    ),
                    SizedBox(
                      width: 70,
                    )
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
