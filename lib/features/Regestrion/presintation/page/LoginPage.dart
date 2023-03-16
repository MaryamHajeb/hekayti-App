import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/widgets/CastemInput.dart';

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [



                      Image.asset('images/boy1.png'),


                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                        CircleAvatar(maxRadius: 40,backgroundColor: Colors.white,child: Image.asset('images/logo.png'),),
                        Text('تسجيل الدخول',style:AppTheme.textTheme.headline3 ),
                         SizedBox(height: 50,),


                        Padding(
                          padding: const EdgeInsets.only(left: 100.0,right: 50),
                          child: Column(
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
                                  },controler:email ,icon: Icon(Icons.email,color: AppTheme.primaryColor,size: 40),text: '',type: TextInputType.text,),



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
                                  },controler:password ,icon: Icon(Icons.key,color: AppTheme.primaryColor,size: 40),text: '',type: TextInputType.text,),



                                ],),
                              SizedBox(height: 20,),


                            ],),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('ليس لدئ حساب ? '),
                            Text('انشاء حساب',style: TextStyle(color: AppTheme.primaryColor)),

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
