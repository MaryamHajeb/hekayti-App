import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/CastemInput.dart';
import '../../../../core/widgets/CustemIcon.dart';
import '../../../../gen/assets.gen.dart';

class onboardingThree extends StatefulWidget {
  const onboardingThree({Key? key}) : super(key: key);

  @override
  State<onboardingThree> createState() => _onboardingThreeState();
}

class _onboardingThreeState extends State<onboardingThree> {
ScreenUtil screenUtil=ScreenUtil();
TextEditingController  nameChiled=TextEditingController();
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          CircleAvatar(maxRadius: 40,backgroundColor: Colors.white,child: Image.asset(Assets.assest.images.logo.path),),
          Text('حكايتي',style:AppTheme.textTheme.headline3 ),
          Text('قم  بإدخال اسم طفلك',style:AppTheme.textTheme.headline3 ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  height: screenUtil.screenHeight *.4,
                  width: screenUtil.screenWidth * .2,
                  child: Image.asset(Assets.assest.images.carecters.hana.happy.path)),
              Column(children: [
                CustemInput(
                  size: 200,
                  valdution: (value){
                    if(value.toString().isEmpty){
                      return'يرجئ منك ادخال اسم الطفل ';

                    }
                    return null;
                  },controler:nameChiled ,icon: Icon(Icons.boy,color: AppTheme.primaryColor,size: 40),text: 'اكتب اسم طفلك',type: TextInputType.text,)


              ],),
              Container(
                  height: screenUtil.screenHeight *.4,
                  width: screenUtil.screenWidth * .2,
                  child: Image.asset(Assets.assest.images.carecters.hasham.happy.path)),


            ],),


        ],
      );
  }
}
