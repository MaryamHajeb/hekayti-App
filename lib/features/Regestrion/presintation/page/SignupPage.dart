import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/widgets/CastemInput.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
                  child: Column(children: [
                    CircleAvatar(maxRadius: 40,backgroundColor: Colors.white,child: Image.asset('images/logo.png'),),
                    Text('إنشاء حساب',style:AppTheme.textTheme.headline3 ),
                     SizedBox(height: 20,),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('البريد الإلكتروني',style: AppTheme.textTheme.headline3,),

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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('كلمة المرور',style: AppTheme.textTheme.headline3,),

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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('تأكيد كلمة المرور',style: AppTheme.textTheme.headline3,),

                              CastemInput(valdution: (value){
                                if(value.toString().isEmpty){
                                  return'يرجئ منك ادخال اسم الطفل ';

                                }
                                return null;
                              },controler:email ,icon: Icon(Icons.email,color: AppTheme.primaryColor,size: 40),text: '',type: TextInputType.text,),



                            ],),
                            SizedBox(height: 20,),

                        ],),
                      ),


                       Expanded(

                         child: Column(
                           mainAxisSize: MainAxisSize.min,
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                           Text('أو  تسجيل    الدخول   ب',style: AppTheme.textTheme.headline5,),
                             Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                               SvgPicture.asset(
                                 'images/bottons/save.svg',

                               ),
                               SvgPicture.asset(
                                 'images/bottons/save.svg',

                               ),
                               SvgPicture.asset(
                                 'images/bottons/save.svg',

                               ),
                             ],),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 Text('ليس لدئ حساب ? '),
                                 Text('انشاء حساب',style: TextStyle(color: AppTheme.primaryColor)),

                               ],
                             ),
                         ],),
                       )



                    ],)


                  ]),

                ),
              ),
            ),
          )),

    )

      ,);
  }
}
