import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:hikayati_app/features/Home/presintation/page/HomePage.dart';
import 'package:hikayati_app/features/Regestrion/date/model/userMode.dart';
import 'package:hikayati_app/features/Regestrion/presintation/page/SignupPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/AppTheme.dart';
import '../../../../core/util/CharactersList.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/util/Common.dart';

import '../../../../core/widgets/CustomField.dart';
import '../../../../core/widgets/CustomButton.dart';
import '../../../../core/widgets/CustomPageRoute.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../injection_container.dart';
import '../../../../main.dart';
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
  bool isLodaing = false;
  ScreenUtil screenUtil = ScreenUtil();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController CofemPassword = TextEditingController();
  CharactersList CharactersListobj = CharactersList();

  bool? isbording;
  UserModel? userModel;
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Scaffold(
        body: BlocProvider(
      create: (context) => sl<RegistrationBloc>(),
      child: BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: (_context, state) async {
          if (state is RegistrationLoading) {
            return showDialog(
              barrierColor: Colors.black.withOpacity(.5),
              context: context,
              builder: (context) {
                return loadingApp('جاري تسجيل الحساب....');
              },
            );
          }
          if (state is RegisterLoaded) {
            isbording == null
                ? Navigator.push(context, CustomPageRoute(child: HomePage()))
                : Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
          }
          if (state is RegisterError) {
            EasyLoading.showError("هذا الحساب غير موجود");
          }
        },
        builder: (_context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
                child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(),
                height: screenUtil.screenHeight * 1,
                width: screenUtil.screenWidth * 1,
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
                            height: screenUtil.screenHeight * .4,
                            width: screenUtil.screenWidth * .2,
                            child: Image.asset(
                                Assets.images.Characters.mariam.sing.path)),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('تسجيل الدخول',
                                  style: AppTheme.textTheme.displayLarge),
                              SizedBox(
                                height: 30,
                              ),
                              SingleChildScrollView(
                                child: Form(
                                  key: _loginFormKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'البريد الإلكتروني    ',
                                            style:
                                                AppTheme.textTheme.displaySmall,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          CustomField(
                                            size: 250,
                                            valdution: (value) {
                                              if (value!.isEmpty) {
                                                return 'يجب ادخال عنوان البريد الالكتروني';
                                              } else if (!RegExp(
                                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                  .hasMatch(value)) {
                                                return "عذراً الإيميل الذي ادخلته غير صحيح";
                                              }

                                              return null;
                                            },
                                            controler: email,
                                            icon: Icon(Icons.email,
                                                color: AppTheme.primaryColor,
                                                size: 20),
                                            text: 'البريد الإلكتروني',
                                            type: TextInputType.text,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '                           كلمة المرور',
                                            style:
                                                AppTheme.textTheme.displaySmall,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          CustomField(
                                            size: 250,
                                            valdution: (value) {
                                              if (value.toString().isEmpty) {
                                                return 'الرجاء تعبئة الحقل';
                                              }
                                              if (value!.length < 6) {
                                                return 'كلمة المرور تتكون من 6 حروف وارفام على الاقل';
                                              }
                                              return null;
                                            },
                                            controler: password,
                                            icon: Icon(Icons.key,
                                                color: AppTheme.primaryColor,
                                                size: 20),
                                            text: 'كلمة المرور',
                                            type: TextInputType.text,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              CustomButton(
                                  ontap: () async {
                                    if (_loginFormKey.currentState!
                                        .validate()) {
                                      if (islogin == true) {
                                        if (await networkInfo.isConnected) {
                                          showImagesDialogWithCancleButten(
                                              context,
                                              '${CharactersListobj.confusedListCharactersList[userModel!.character]['image']}',
                                              'هل انت متاكد ؟'
                                                  'سوف تفقد جميع بياناتك الحاليه',
                                              () {}, () async {
                                            BlocProvider.of<RegistrationBloc>(
                                                    _context)
                                                .add(
                                              Login(
                                                email: email.text.toString(),
                                                password: password.text,
                                              ),
                                            );
                                            await Future.delayed(
                                                Duration(seconds: 20));

                                            setState(() {
                                              isLodaing = false;
                                            });
                                            print(
                                                '-----------------------------------------------');

                                            print(email.text);
                                            print(
                                                '-----------------------------------------------');
                                            setState(() {
                                              requestPending = true;
                                            });
                                            Navigator.push(
                                                context,
                                                CustomPageRoute(
                                                    child: HomePage()));
                                          });
                                        } else {
                                          noInternt(
                                              context, 'تاكد من وجود انترنت');
                                        }
                                      } else {
                                        print('ok');
                                        BlocProvider.of<RegistrationBloc>(
                                                _context)
                                            .add(
                                          Login(
                                            email: email.text.toString(),
                                            password: password.text,
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  text: 'تسجيل'),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('ليس لدئ حساب ? ',
                                      style: TextStyle(
                                          fontFamily: AppTheme.fontFamily,
                                          fontSize: 15)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            CustomPageRoute(
                                                child: SignupPage()));
                                      },
                                      child: Text('انشاء حساب',
                                          style: TextStyle(
                                              color: AppTheme.primaryColor,
                                              fontFamily: AppTheme.fontFamily,
                                              fontSize: 15,
                                              decorationColor:
                                                  AppTheme.primaryColor,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationThickness: 2))),
                                ],
                              ),
                            ]),
                        Container(
                            height: screenUtil.screenHeight * .4,
                            width: screenUtil.screenWidth * .2,
                            child: Image.asset(
                                Assets.images.Characters.abdu.sing.path)),
                      ],
                    ),
                  ),
                ),
              ),
            )),
          );
        },
      ),
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOnbording();
  }

  getOnbording() async {
    var prefs = await SharedPreferences.getInstance();
    isbording = await prefs.getBool('onbording');

    // userModel = await getCachedData(
    //   key: 'UserInformation',
    //   retrievedDataType: UserModel.init(),
    //   returnType: UserModel,
    // );
    // ;
  }
}
