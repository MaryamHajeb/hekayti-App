import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/features/Home/presintation/page/HomePage.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/Carecters.dart';
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
  Carecters carectersobj =Carecters();
  int  Carecters_id=0;
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
    if (state is RegistrationLoading) {
      setState(() {
        requestPending = false;
      });
      Center(child: CircularProgressIndicator(color: AppTheme.primaryColor,),);
    }
          if (state is RegisterLoaded) {
            setState(() {
              requestPending = false;
            });
            showImagesDialog(context,"${carectersobj.showCarecters[Carecters_id ?? 0]['image'] ?? 0}",'تم انشاء حساب بنجاح يمكنك الان تسجيل دخولك ');

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
                            SizedBox(height: 20,),

                            Text('إنشاء حساب',style:AppTheme.textTheme.headline1 ),
                            SizedBox(height: 20,),

                            Form(
                              key: _signupFormKey,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        height: screenUtil.screenHeight *.4,
                                        width: screenUtil.screenWidth * .2,
                                        child: Image.asset(Assets.images.carecters.abdu.sing.path)),
                                  ),

                                  Expanded(
                                    flex: 2,
                                    child: Column(

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
                                              },controler:email ,text: 'البريد الإلكتروني',type: TextInputType.text,),

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
                                              },controler:password ,text: 'كلمة المرور',type: TextInputType.text,),



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
                                                if (value.toString().isEmpty) {
                                                  return 'الرجاء تعبئة الحقل';
                                                }
                                                if (value!.length < 6) {
                                                  return 'كلمه المرور تتكون من 6 حروف وارفام على الاقل';
                                                }
                                                if(password.text !=CofemPassword.text){
                                                  return 'تاكبد كلمه المرور لاتطابق كمله المرور  ';

                                                }
                                                return null;
                                              },controler:CofemPassword ,text: 'تأكيد كلمة المرور',type: TextInputType.text,),



                                          ],),
                                        SizedBox(height: 10,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('هل لديك حساب مسبق ؟',style: TextStyle(fontFamily: AppTheme.fontFamily,fontSize: 15)),
                                            SizedBox(width: 10,),
                                            InkWell(

                                                onTap: (){
                                                  Navigator.push(
                                                      context,
                                                      CustomPageRoute(  child:   LoginPage()));

                                                },
                                                child: Text('تسجيل دخول',style: TextStyle(color: AppTheme.primaryColor,fontFamily: AppTheme.fontFamily,fontSize: 15))),

                                          ],
                                        ),
                                        SizedBox(height: 20,),

                                      ],),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        height: screenUtil.screenHeight *.4,
                                        width: screenUtil.screenWidth * .2,
                                        child: Image.asset(Assets.images.carecters.mariam.sing.path)),
                                  ),

                                ],
                              ),
                            ),
                            CustemButten(ontap: (){
                                     if(_signupFormKey.currentState!.validate() ){
                              BlocProvider.of<RegistrationBloc>(_context).add(
                                Signup(
                                  email: email.text.toString(),
                                  password: password.text,
                                ),
                              );}
                            },text: 'إنشاء',),
                            SizedBox(height: 30,),

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Carecters_id=  getCachedDate('Carecters',String);
  }
}
