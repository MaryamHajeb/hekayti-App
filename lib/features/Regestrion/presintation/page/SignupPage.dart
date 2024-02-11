import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hikayati_app/features/Regestrion/date/model/userMode.dart';
import 'package:hikayati_app/features/introdection/presintation/manager/IntroScreenController.dart';
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
import '../../../Introdection/presintation/page/IntroScreen.dart';
import '../../../Settings/presintation/page/TabBarPage.dart';
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
  CharactersList CharactersListobj = CharactersList();
  ScreenUtil screenUtil = ScreenUtil();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController CofemPassword = TextEditingController();
  bool islogin = false;
  bool visible = false;
  final _signupFormKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Scaffold(body: GetBuilder<IntroScreenController>(
      builder: (controller) {
        return BlocProvider(
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
                final prefs = await SharedPreferences.getInstance();
                islogin = await prefs.getBool('onbording') ?? false;

                islogin
                    ? {
                        Navigator.push(
                            context, CustomPageRoute(child: TabBarPage()))
                      }
                    : {
                        print(state.successMessage),
                        controller.userModel?.id = state.successMessage,
                        controller.userModel?.email = email.text,
                        controller.userModel?.password = password.text,
                        controller.update(),
                        Navigator.push(
                            context,
                            CustomPageRoute(
                                child: IntroScreen(
                              index: 2,
                            )))
                      };
              }
            },
            builder: (_context, state) {
              if (state is RegisterError) {
                EasyLoading.showError("حدث خطأ يرجى المحاولة مرة اخرى");
              }

              return Directionality(
                textDirection: TextDirection.rtl,
                child: Center(
                    child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(),
                    height: screenUtil.screenHeight * 1,
                    width: screenUtil.screenWidth * 1,
                    margin: EdgeInsets.only(
                      top: 0,
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 4,
                                    color: AppTheme.primarySwatch.shade500),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: SingleChildScrollView(
                              child: Column(children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text('إنشاء حساب',
                                    style: AppTheme.textTheme.displayLarge),
                                SizedBox(
                                  height: 20,
                                ),
                                Form(
                                  key: _signupFormKey,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                            height:
                                                screenUtil.screenHeight * .4,
                                            width: screenUtil.screenWidth * .2,
                                            child: Image.asset(Assets.images
                                                .Characters.abdu.sing.path)),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  'البريد الإلكتروني',
                                                  style: AppTheme
                                                      .textTheme.displaySmall,
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
                                                  text: 'البريد الإلكتروني',
                                                  type: TextInputType.text,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  ' كلمة المرور',
                                                  style: AppTheme
                                                      .textTheme.displaySmall,
                                                ),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                CustomField(
                                                  size: 250,
                                                  valdution: (value) {
                                                    if (value
                                                        .toString()
                                                        .isEmpty) {
                                                      return 'الرجاء تعبئة الحقل';
                                                    }
                                                    if (value!.length < 6) {
                                                      return 'كلمة المرور تتكون من 6 حروف وارفام على الاقل';
                                                    }
                                                    return null;
                                                  },
                                                  controler: password,
                                                  text: 'كلمة المرور',
                                                  type: TextInputType.text,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  'تأكيد كلمة المرور',
                                                  style: AppTheme
                                                      .textTheme.displaySmall,
                                                ),
                                                CustomField(
                                                  size: 250,
                                                  valdution: (value) {
                                                    if (value
                                                        .toString()
                                                        .isEmpty) {
                                                      return 'الرجاء تعبئة الحقل';
                                                    }
                                                    if (value!.length < 6) {
                                                      return 'كلمة المرور تتكون من 6 حروف وارفام على الاقل';
                                                    }
                                                    if (password.text !=
                                                        CofemPassword.text) {
                                                      return 'تاكبد كلمة المرور لاتطابق كمله المرور  ';
                                                    }
                                                    return null;
                                                  },
                                                  controler: CofemPassword,
                                                  text: 'تأكيد كلمة المرور',
                                                  type: TextInputType.text,
                                                ),
                                              ],
                                            ),
                                            CustomButton(
                                              ontap: () async {
                                                if (_signupFormKey.currentState!
                                                    .validate()) {
                                                  if (await networkInfo
                                                      .isConnected) {
                                                    BlocProvider.of<
                                                                RegistrationBloc>(
                                                            _context)
                                                        .add(
                                                      Signup(
                                                        email: email.text
                                                            .toString(),
                                                        password: password.text,
                                                      ),
                                                    );
                                                  } else {
                                                    noInternt(context,
                                                        'تاكد من وجود انترنت');
                                                  }
                                                }
                                              },
                                              text: 'إنشاء',
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('هل لديك حساب مسبق ؟',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            AppTheme.fontFamily,
                                                        fontSize: 12)),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          CustomPageRoute(
                                                              child:
                                                                  LoginPage()));
                                                    },
                                                    child: Text('تسجيل دخول',
                                                        style: TextStyle(
                                                            color: AppTheme
                                                                .primaryColor,
                                                            fontFamily: AppTheme
                                                                .fontFamily,
                                                            fontSize: 13,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            decorationColor:
                                                                AppTheme
                                                                    .primaryColor,
                                                            decorationThickness:
                                                                2))),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                            height:
                                                screenUtil.screenHeight * .4,
                                            width: screenUtil.screenWidth * .2,
                                            child: Image.asset(Assets.images
                                                .Characters.mariam.sing.path)),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
              );
            },
          ),
        );
      },
    ));
  }
}
