import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/features/Home/presintation/page/HomePage.dart';
import 'package:hikayati_app/features/Regestrion/presintation/page/SignupPage.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/widgets/CastemInput.dart';
import '../../../../core/widgets/CustemButten.dart';
import '../../../../core/widgets/CustomPageRoute.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  ScreenUtil screenUtil=ScreenUtil();
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController CofemPassword = TextEditingController();
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Scaffold(body:  Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
          child: SingleChildScrollView(
            child: Container(

              decoration: BoxDecoration(


              ),
              height:  screenUtil.screenHeight * 1,
              width:screenUtil.screenWidth *1,
              margin:  EdgeInsets.only(
                top: 0,
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
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [



                      Image.asset('images/boy1.png'),


                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                        CircleAvatar(maxRadius: 40,backgroundColor: Colors.white,child: Image.asset('images/logo.png'),),
                        Text('تسجيل الدخول',style:AppTheme.textTheme.headline3 ),
                         SizedBox(height: 40,),


                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('البريد الإلكتروني',style: AppTheme.textTheme.headline3,),
                                SizedBox(width: 20,),
                                CastemInput(valdution: (value){
                                  if(value.toString().isEmpty){
                                    return'يرجئ منك ادخال اسم الطفل ';

                                    }
                                  return null;
                                },controler:email ,icon: Icon(Icons.email,color: AppTheme.primaryColor,size: 40),text: 'البريد الإلكتروني',type: TextInputType.text,),



                              ],),
                            SizedBox(height: 20,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('                           كلمة المرور',style: AppTheme.textTheme.headline3,),
                                SizedBox(width: 20,),
                                CastemInput(valdution: (value){
                                  if(value.toString().isEmpty){
                                    return'يرجئ منك ادخال اسم الطفل ';

                                  }
                                  return null;
                                },controler:password ,icon: Icon(Icons.key,color: AppTheme.primaryColor,size: 40),text: 'كلمة المرور',type: TextInputType.text,),



                              ],),
                            SizedBox(height: 20,),


                          ],),
                        CustemButten(ontap: (){
                          Navigator.push(
                              context,
                              CustomPageRoute(  child:   HomePage()));

                        },text: 'تسجيل'),

                            SizedBox(height: 10,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('هل لديك حساب مسبق ؟',style: TextStyle(fontFamily: AppTheme.fontFamily,fontSize: 10)),
                                   SizedBox(width: 40,),
                                InkWell(

                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          CustomPageRoute(  child:   SignupPage()));

                                    },
                                    child: Text('تسجيل دخول',style: TextStyle(color: AppTheme.primaryColor,fontFamily: AppTheme.fontFamily,fontSize: 10))),

                              ],
                            ),

                      ]),

                      Image.asset('images/girl1.png'),

                    ],
                  ),

                ),
              ),
            ),
          )),

    )

      ,);
  }
}
