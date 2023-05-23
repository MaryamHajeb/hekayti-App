import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/features/Home/presintation/page/HomePage.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/CastemInput.dart';
import '../../../../core/widgets/CustemButten.dart';
import '../../../../core/widgets/CustomPageRoute.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../injection_container.dart';
import '../manager/registration_bloc.dart';
import 'LoginPage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  bool requestPending = false;

  ScreenUtil screenUtil=ScreenUtil();
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController CofemPassword = TextEditingController();
  final _signupFormKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Scaffold(body:   BlocProvider(
      create: (context) => sl<RegistrationBloc>(),
      child: BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: (_context, state) {
          if (state is RegisterLoaded) {
            setState(() {
              requestPending = false;
            });
            showSnackBar(
              context: context,
              title: state.successMessage,
              bkColor: Colors.green,
              callBackFunction: () {
                setState(() {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return LoginPage();
                  }));
                });
              },
            );

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
                        child: SingleChildScrollView(
                          child: Column(children: [
                            CircleAvatar(maxRadius: 40,backgroundColor: Colors.white,child: Image.asset(Assets.images.logo.path),),
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
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('البريد الإلكتروني',style: AppTheme.textTheme.headline3,),

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
                                      SizedBox(height: 0,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('كلمة المرور',style: AppTheme.textTheme.headline3,),
                                          SizedBox(width: 0,),
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
                                      SizedBox(height: 0,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('تأكيد كلمة المرور',style: AppTheme.textTheme.headline3,),

                                          CustemInput(
                                            size: 250,
                                            valdution: (value){
                                              if(value.toString().isEmpty){
                                                return'يرجئ منك ادخال اسم الطفل ';

                                              }
                                              return null;
                                            },controler:CofemPassword ,icon: Icon(Icons.key,color: AppTheme.primaryColor,size: 20),text: 'تأكيد كلمة المرور',type: TextInputType.text,),



                                        ],),
                                      SizedBox(height: 0,),

                                    ],),
                                ),


                                Expanded(

                                  child: Form(
                                    key:  _signupFormKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('أو  تسجيل    الدخول   ب',style: AppTheme.textTheme.headline5,),
                                        SizedBox(height: 20,),

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
                                        SizedBox(height: 20,),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text('هل لديك حساب مسبق ؟',style: TextStyle(fontFamily: AppTheme.fontFamily,fontSize: 10)),
                                            InkWell(

                                                onTap: (){
                                                  Navigator.push(
                                                      context,
                                                      CustomPageRoute(  child:   LoginPage()));

                                                },
                                                child: Text('تسجيل دخول',style: TextStyle(color: AppTheme.primaryColor,fontFamily: AppTheme.fontFamily,fontSize: 10))),

                                          ],
                                        ),
                                      ],),
                                  ),
                                ),


                              ],),
                            CustemButten(ontap: (){
                              // if (_signupFormKey.currentState!.validate()) {
                              //   BlocProvider.of<RegistrationBloc>(_context).add(
                              //     Signup(
                              //         email: email.text,
                              //         password: password.text
                              //
                              //     ),
                              //   );
                              //   setState(() {
                              //     requestPending = true;
                              //   });
                              // } else {
                              //   print('error');
                              // }
                              Navigator.push(
                                  context,
                                  CustomPageRoute(  child:   HomePage()));
                            },text: 'إنشاء',)

                          ]),
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
