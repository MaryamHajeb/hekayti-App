import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/CastemInput.dart';
import '../../../../core/widgets/CustemIcon.dart';

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
            Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
            child: Container(
                height:  screenUtil.screenHeight * .9,
                width:screenUtil.screenWidth *.8,
              margin:  EdgeInsets.only(
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
                      Text('قم  بإدخال اسم طفلك',style:AppTheme.textTheme.headline3 ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset('images/boy1.png'),
                          Column(children: [
                            CastemInput(
                              size: 200,
                              valdution: (value){
                              if(value.toString().isEmpty){
                                return'يرجئ منك ادخال اسم الطفل ';

                              }
                              return null;
                            },controler:nameChiled ,icon: Icon(Icons.boy,color: AppTheme.primaryColor,size: 40),text: 'اكتب اسم طفلك',type: TextInputType.text,)


                          ],),
                          Image.asset('images/girl1.png'),


                        ],),


                    ],
                  ),

                ),
              ),
            )),

    );
  }
}
