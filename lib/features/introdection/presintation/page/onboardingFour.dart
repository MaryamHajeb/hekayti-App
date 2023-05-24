import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/Carecters.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/CastemCarecters.dart';
import '../../../../core/widgets/CustemIcon.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../main.dart';

class onboardingFour extends StatefulWidget {
  const onboardingFour({Key? key}) : super(key: key);

  @override
  State<onboardingFour> createState() => _onboardingFourState();
}

class _onboardingFourState extends State<onboardingFour> {
ScreenUtil screenUtil=ScreenUtil();
  @override
  Carecters carecterslist =Carecters();
 static int itemSelected =10;
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('اختر  شخصيك المفضلة',style:AppTheme.textTheme.headline1 ),
          Container(
            height: screenUtil.screenHeight * .4,
            width: double.infinity,
            child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: carecterslist.listcarecters.length,itemBuilder: (context, index) {

              return CustemCarecters(image: carecterslist.listcarecters[index]['image'].toString(), onTap: ()async{
                setState(() {
                  itemSelected=index;

                });

                int dd=int.parse(carecterslist.listcarecters[index]['id'].toString());
                CachedDate('Carecters',dd);

              }, isSelected: itemSelected==index?  true : false ,);

            },),
          )


        ],
      );
  }
}
