import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hikayati_app/features/Home/presintation/page/HomePage.dart';
import 'package:hikayati_app/features/Regestrion/date/model/userMode.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/Carecters.dart';
import '../../../../core/util/Encrypt.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/CastemInput.dart';
import '../../../../core/widgets/CustemButten.dart';
import '../../../../core/widgets/CustomPageRoute.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../injection_container.dart';
import '../manager/registration_bloc.dart';
import 'package:intl/intl.dart' as intl;

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  bool requestPending = false;
  Carecters carectersobj =Carecters();
  ScreenUtil screenUtil=ScreenUtil();
TextEditingController userpassword = TextEditingController();
TextEditingController newpassword = TextEditingController();
TextEditingController CofemPassword = TextEditingController();
  final _signupFormKey = GlobalKey<FormState>();

  UserModel? userModel;

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
            Navigator.push(
                context,
                CustomPageRoute(  child:   HomePage()));

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

                            Text('اعاده تعيين كلمة المرور ',style:AppTheme.textTheme.headline1 ),
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
                                    flex: 3,
                                    child: Column(

                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text('كلمة المرور الحالية',style: AppTheme.textTheme.headline3,),

                                            CustemInput(
                                              size: 250,
                                              valdution: (value){
                                                if (value!.isEmpty) {
                                                  return 'الرجاء تعبئة الحقل';
                                                }

                                                if (Encryption.instance.checkIsCorrect(userpassword.text, userModel!.password.toString())!=0 ) {
                                                  return 'كلمة المرور غير صحيحة';
                                                }



                                                return null;
                                              },controler:userpassword ,text: 'كلمة المرور الحاليه',type: TextInputType.text,),

                                          ],),
                                        SizedBox(height: 10,),

                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text('  كلمة المرور الجديدة',style: AppTheme.textTheme.headline3,),
                                            CustemInput(
                                              size: 250,
                                              valdution: (value){
                                                if (value.toString().isEmpty) {
                                                  return 'الرجاء تعبئة الحقل';
                                                }
                                                if (value!.length < 8) {
                                                  return 'كلمة المرور الجديدة تتكون من 8 حروف وارفام على الاقل';
                                                }
                                                return null;
                                              },controler:newpassword ,text: '  كلمة المرور الجديدة',type: TextInputType.text,),



                                          ],),
                                        SizedBox(height: 10,),

                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(' تأكيد كلمة المرور            ',style: AppTheme.textTheme.headline3,),

                                            CustemInput(
                                              size: 250,

                                              valdution: (value){
                                                if (value.toString().isEmpty) {
                                                  return 'الرجاء تعبئة الحقل';
                                                }
                                                if (value!.length < 6) {
                                                  return 'كلمة المرور تتكون من 6 حروف وارفام على الاقل';
                                                }
                                                if(newpassword.text !=CofemPassword.text){
                                                  return 'تاكبد كلمة المرور لاتطابق كمله المرور';

                                                }
                                                return null;
                                              },controler:CofemPassword ,text: ' تأكيد كلمة المرور الجديدة',type: TextInputType.text,),



                                          ],),
                                        SizedBox(height: 10,),

                                        CustemButten(ontap: (){
                                          if(_signupFormKey.currentState!.validate()){
                                            CachedDate('UserInformation',UserModel(user_name: userModel!.user_name, email: userModel!.email, level: userModel!.level, character: userModel!.character, update_at: intl.DateFormat('yyyy-MM-ddTHH:mm:ss.ssssZ').format(DateTime.now().toUtc()), password: newpassword.text, id: userModel!.id));

                                          }
                                        },text: 'تعديل',),



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
                            SizedBox(height: 10,),

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
    userModel = getCachedDate('UserInformation', UserModel.init());
   print(userModel!.password);
  }
}
