import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/CastemPersons.dart';
import '../../../../core/widgets/CustemIcon.dart';

class onboardingFour extends StatefulWidget {
  const onboardingFour({Key? key}) : super(key: key);

  @override
  State<onboardingFour> createState() => _onboardingFourState();
}

class _onboardingFourState extends State<onboardingFour> {
ScreenUtil screenUtil=ScreenUtil();
  @override
  List image=[
    'images/boy4.png',
    'images/boy3.png',
    'images/boy2.png',
    'images/girl4.png',
    'images/girl3.png',
    'images/girl2.png',
  ];
  int itemSelected =0;
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return
      Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
            child: Container(
              height:  screenUtil.screenHeight * .9,
              width:screenUtil.screenWidth *.8,
              margin: EdgeInsets.only(
                top: 25,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.only(bottom: 50),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          width: 4, color: AppTheme.primarySwatch.shade500),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      CircleAvatar(maxRadius: 40,backgroundColor: Colors.white,child: Image.asset('images/logo.png'),),
                      Text('حكايتي',style:AppTheme.textTheme.headline3 ),
                      Text('اختر  شخصيك المفضلة',style:AppTheme.textTheme.headline3 ),

                     Container(
                       height: screenUtil.screenHeight * .4,
                       width: double.infinity,
                       child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: image.length,itemBuilder: (context, index) {

                         return CastemPersons(image: image[index], onTap: (){
                           setState(() {
                             itemSelected=index;
                           });

                         }, isSelected: itemSelected==index?  true : false ,);

                       },),
                     )


                    ],
                  ),

                ),
              ),
            )),

      );
  }
}
