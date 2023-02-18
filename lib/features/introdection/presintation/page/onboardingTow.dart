import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/CustemIcon.dart';

class onboardingTow extends StatefulWidget {
  const onboardingTow({Key? key}) : super(key: key);

  @override
  State<onboardingTow> createState() => _onboardingTowState();
}

class _onboardingTowState extends State<onboardingTow> {
ScreenUtil screenUtil=ScreenUtil();
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
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          width: 4, color: AppTheme.primarySwatch.shade500),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      CircleAvatar(maxRadius: 40,backgroundColor: Colors.white,child: Image.asset('images/logo.png'),),
                       Text('حكايتي',style:AppTheme.textTheme.headline3 ),
                      Text('لطفاً، قم بحل هذه المعادلة للضبط إعدادات التطبيق :',style:AppTheme.textTheme.headline3 ),

                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/boy1.png'),
                            Column(children: [
                              Container(
                                  height: screenUtil.screenHeight *.1,
                                  width: screenUtil.screenWidth *.3,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 2,color: AppTheme.primarySwatch.shade400),
                                      color: AppTheme.primarySwatch.shade50,
                                      borderRadius: BorderRadius.circular(10)

                                  ),
                                  margin: EdgeInsets.only(bottom: 30,top: 0, left: 50, right: 50),
                                  child: Center(child: Text('=7*8+5-6*3',style: AppTheme.textTheme.bodyLarge,textDirection: TextDirection.rtl,))),
                              Row(children: [
                                ElevatedButton(

                                  onPressed: () {},
                                  child: Text('تم',style: TextStyle(fontWeight: FontWeight.bold)),

                                  style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(AppTheme.primarySwatch.shade600) ),
                                ),
                                Container(
                                    height: screenUtil.screenHeight *.1,
                                    width: screenUtil.screenWidth *.2,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 2,color: AppTheme.primarySwatch.shade400),
                                        color: AppTheme.primarySwatch.shade200,
                                        borderRadius: BorderRadius.circular(10)

                                    ),
                                    margin: EdgeInsets.only(top: 5, left: 0, right: 30),
                                    child: TextFormField(
                                         validator: (value){
                                           if(value == null){
                                             return 'gggg';
                                           }
                                         },
                                      keyboardType: TextInputType.number,
                                      style: AppTheme.textTheme.headline6,
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent),
                                        ),
                                      ),
                                      cursorColor: AppTheme.primaryColor,
                                    )),


                              ],)



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
