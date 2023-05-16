import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/features/Home/presintation/page/HomePage.dart';
import 'package:hikayati_app/features/Regestrion/presintation/page/SignupPage.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/util/common.dart';

import '../../../../core/widgets/CastemInput.dart';
import '../../../../core/widgets/CustemButten.dart';
import '../../../../core/widgets/CustomPageRoute.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../injection_container.dart';
import '../manager/registration_bloc.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  bool requestPending = false;
  final _loginFormKey = GlobalKey<FormState>();

  ScreenUtil screenUtil=ScreenUtil();
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController CofemPassword = TextEditingController();
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Scaffold(body:


    BlocProvider(
      create: (context) => sl<RegistrationBloc>(),
      child: BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: (_context, state) {
          if (state is RegisterLoaded) {
            setState(() {
              requestPending = false;
            });
            showSnackBar(context: context,title: state.successMessage,bkColor: Colors.green,callBackFunction: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
            });
          } else if (state is RegisterError) {
            setState(() {
              requestPending = false;
            });
            showSnackBar(
              context: context,
              title: state.errorMessage,
            );
          }
        },
        builder: (_context, state) {
          return Directionality(
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



                            Container(
                                height: screenUtil.screenHeight *.4,
                                width: screenUtil.screenWidth * .2,
                                child: Image.asset(Assets.assest.images.carecters.mariam.sing.path)),


                            Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(maxRadius: 40,backgroundColor: Colors.white,child: Image.asset(Assets.assest.images.logo.path),),
                                  Text('تسجيل الدخول',style:AppTheme.textTheme.headline3 ),
                                  SizedBox(height: 30,),


                                  SingleChildScrollView(
                                    child: Form(
                                      key: _loginFormKey,
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
                                              CustemInput(
                                                size: 250,
                                                valdution: (value){
                                                  if (value!.isEmpty) {
                                                    return 'يجب ادخال عنوان البريد الالكتروني';
                                                  } else if (!RegExp(
                                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                      .hasMatch(value)) {
                                                    return "عذراً الإيميل الذي ادخلته غير صحيح";
                                                  }

                                                  return null;

                                                },controler:email ,icon: Icon(Icons.email,color: AppTheme.primaryColor,size: 20),text: 'البريد الإلكتروني',type: TextInputType.text,),



                                            ],),

                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('                           كلمة المرور',style: AppTheme.textTheme.headline3,),
                                              SizedBox(width: 20,),
                                              CustemInput(
                                                size: 250,
                                                valdution: (value){
                                                  if (value.toString().isEmpty) {
                                                    return 'الرجاء تعبئة الحقل';
                                                  }
                                                  if (value!.length < 6) {
                                                    return 'كلمه المرور تتكون من 6 حروف وارفام على الاقل';
                                                  }
                                                  return null;
                                                },controler:password ,icon: Icon(Icons.key,color: AppTheme.primaryColor,size: 20),text: 'كلمة المرور',type: TextInputType.text,),



                                            ],),


                                        ],),
                                    ),
                                  ),
                                  CustemButten(ontap: (){

                                    if (_loginFormKey.currentState!.validate()) {
                                      print('ok');
                                      BlocProvider.of<RegistrationBloc>(_context).add(
                                        Login(
                                          email: email.text.toString(),
                                          password: password.text,
                                        ),
                                      );
                                      print('-----------------------------------------------');

                                        print(email.text);
                                        print('-----------------------------------------------');
                                      setState(() {
                                        requestPending = true;
                                      });
                                    } else {
                                      print('error');
                                    }


                                  },text: 'تسجيل'),

                                  SizedBox(height: 10,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('ليس لدئ حساب ? ',style: TextStyle(fontFamily: AppTheme.fontFamily,fontSize: 10)),
                                      SizedBox(width: 40,),
                                      InkWell(

                                          onTap: (){
                                            Navigator.push(
                                                context,
                                                CustomPageRoute(  child:   SignupPage()));

                                          },
                                          child: Text('انشاء حساب',style: TextStyle(color: AppTheme.primaryColor,fontFamily: AppTheme.fontFamily,fontSize: 10))),

                                    ],
                                  ),

                                ]),

                            Container(
                                height: screenUtil.screenHeight *.4,
                                width: screenUtil.screenWidth * .2,
                                child: Image.asset(Assets.assest.images.carecters.abdu.sing.path)),

                          ],
                        ),

                      ),
                    ),
                  ),
                )),

          );
        },
      ),
    ),

      );
  }
}
