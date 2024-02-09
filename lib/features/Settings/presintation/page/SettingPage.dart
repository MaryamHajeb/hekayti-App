import 'package:flutter/material.dart';
import 'package:hikayati_app/features/Home/presintation/page/HomePage.dart';
import 'package:hikayati_app/features/Regestrion/date/model/userMode.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/util/Carecters.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/CastemCarecters.dart';
import '../../../../core/widgets/CastemInput.dart';

import '../../../../core/widgets/CustemButten.dart';
import '../../../../core/widgets/CustemButten2.dart';
import '../../../../core/widgets/CustomPageRoute.dart';
import '../../../../main.dart';
import 'package:hikayati_app/core/widgets/CastemLevel.dart';
import '../../../Regestrion/presintation/page/LoginPage.dart';
import '../../../Regestrion/presintation/page/SignupPage.dart';
import '../../../Regestrion/presintation/page/ResetPasswordPage.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Carecters carecterslist = Carecters();

  TextEditingController nameChiled = TextEditingController();
  int itemSelected = 0;
  int itemSelectedlevel = 0;
  bool chackboxStata = true;
  Carecters carectersobj = Carecters();

  UserModel? userModel;

  ScreenUtil screenUtil = ScreenUtil();
  Widget build(BuildContext context) {
    screenUtil.init(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: screenUtil.screenHeight * .05,
                  left: screenUtil.screenWidth * .05,
                  right: screenUtil.screenWidth * .05,
                ),
                child: Text('  اسم الطفل  :',
                    style: AppTheme.textTheme.displaySmall),
              ),
              CustemInput(
                size: 200,
                valdution: (value) {
                  if (value.toString().isEmpty) {
                    return 'يرجى منك ادخال اسم الطفل ';
                  } else if (!RegExp(
                          r"^([\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z]+)$")
                      .hasMatch(value)) {
                    return "لا يمكن ان يحتوي اسم الطفل على ارقام او رموز";
                  }
                  return null;
                },
                controler: nameChiled,
                text: 'اكتب اسم طفلك',
                type: TextInputType.text,
              ),
            ],
          ),
          Divider(
            color: AppTheme.primaryColor,
          ),
          SizedBox(
            height: 20,
          ),
          Text('الـشخـصـيـات  :',
              style: AppTheme.textTheme.displaySmall,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right),
          SizedBox(
            height: 30,
          ),
          Container(
            height: screenUtil.screenHeight * .4,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: carecterslist.listcarecters.length,
              itemBuilder: (context, index) {
                return CustemCarecters(
                  image: carecterslist.listcarecters[index]['image'].toString(),
                  onTap: () async {
                    setState(() {
                      itemSelected = index;
                    });
                  },
                  isSelected: itemSelected == index ? true : false,
                );
              },
            ),
          ),
          Divider(
            color: AppTheme.primaryColor,
          ),
          SizedBox(
            height: 20,
          ),
          Text('مـسـتـوى الـقـصـص   :',
              style: AppTheme.textTheme.displaySmall,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right),
          Container(
            height: screenUtil.screenHeight * .4,
            width: double.infinity,
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: carecterslist.Levels.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      CustemLevel(
                        name: carecterslist.Levels[index]['num'],
                        onTap: () {
                          setState(() {
                            itemSelectedlevel = index;
                          });
                        },
                        isSelected: itemSelectedlevel == index ? true : false,
                        color: carecterslist.Levels[index]['color'],
                      ),
                      SizedBox(
                        width: 70,
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          Divider(
            color: AppTheme.primaryColor,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('خاصية الاستماع للقصص',
                  style: AppTheme.textTheme.displaySmall,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right),
              Checkbox(
                  value: chackboxStata,
                  checkColor: Colors.brown,
                  activeColor: AppTheme.primarySwatch.shade400,
                  hoverColor: AppTheme.primaryColor,
                  focusColor: AppTheme.primaryColor,
                  overlayColor: MaterialStateProperty.all(
                      AppTheme.primarySwatch.shade400),
                  onChanged: (value) {
                    setState(() {
                      chackboxStata = value!;
                    });
                  }),
            ],
          ),
          Divider(
            color: AppTheme.primaryColor,
          ),
          SizedBox(
            height: 20,
          ),
          userModel?.email != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: screenUtil.screenWidth * .4,
                      height: screenUtil.screenHeight * .2,
                      child: Column(
                        children: [
                          Row(children: [
                            Text('البريد الاكتروني :',
                                style: AppTheme.textTheme.displaySmall),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              '${userModel?.email.toString()}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: AppTheme.fontFamily,
                                  fontSize: 14),
                            )
                          ]),
                          SizedBox(
                            height: 20,
                          ),
                          Row(children: [
                            Text('كـلـمـه  الــمـررو  :',
                                style: AppTheme.textTheme.displaySmall),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CustomPageRoute(
                                          child: ResetPasswordPage()));
                                },
                                child: Text(
                                  'اعاده تعيين',
                                  style: TextStyle(
                                      decorationColor: AppTheme.primaryColor,
                                      color: AppTheme.primaryColor,
                                      fontFamily: AppTheme.fontFamily,
                                      fontSize: 13,
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 2),
                                )),
                          ]),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        showImagesDialogWithCancleButten(
                            context,
                            '${carectersobj.confusedListCarecters[int.parse(userModel!.character.toString())]['image']}',
                            'هل حقا تريد تسجيل الخروج', () {
                          Navigator.pop(context);
                        }, () async {
                          cachedData(data: 'onbording', key: 'true');
                          db.deleteTable('stories');
                          db.deleteTable('stories_media');
                          db.deleteTable('completion');
                          db.deleteTable('accuracy');
                          Navigator.pushReplacement(
                              context, CustomPageRoute(child: MyApp()));
                        });
                      },
                      child: Text('تسجيل الخروج',
                          style: AppTheme.textTheme.bodyLarge),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppTheme.primarySwatch.shade500)),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Text('هل تريد حفظ بياناتك معنا     (اختياري)',
                        style: AppTheme.textTheme.displaySmall,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context, CustomPageRoute(child: SignupPage()));
                          },
                          child: Text('إنشاء حساب',
                              style: AppTheme.textTheme.bodyLarge),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppTheme.primaryColor)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context, CustomPageRoute(child: LoginPage()));
                          },
                          child: Text('تسجيل دخول',
                              style: AppTheme.textTheme.bodyLarge),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppTheme.primarySwatch.shade600)),
                        ),
                      ],
                    ),
                  ],
                ),
          SizedBox(
            height: screenUtil.screenHeight * .02,
          ),
          Divider(
            color: AppTheme.primaryColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustemButten(
                text: 'حفظ',
                ontap: () async {
                  try {
                    saveNewSttings();
                    showImagesDialog(
                        context,
                        '${carectersobj.FaceCarecters[itemSelected]['image']}',
                        'تم حفظ بيناتك بنجاح', () {
                      Navigator.pop(context);
                    });
                    await Future.delayed(Duration(seconds: 1));
                    Navigator.pushReplacement(
                        context, CustomPageRoute(child: HomePage()));
                  } catch (e) {}
                },
              ),
              SizedBox(
                width: screenUtil.screenHeight * .02,
              ),
              CustemButten2(
                text: 'رجوع',
                ontap: () async {
                  Navigator.push(context, CustomPageRoute(child: HomePage()));
                },
              ),
            ],
          ),
          SizedBox(
            height: screenUtil.screenHeight * .02,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCarecters();
  }

  initCarecters() async {
    userModel = await getCachedData(
      key: 'UserInformation',
      retrievedDataType: UserModel.init(),
      returnType: UserModel.init(),
    );

    bool lisent = await getCachedData(
            key: 'Listen_to_story',
            returnType: bool,
            retrievedDataType: bool) ??
        true;

    setState(() {
      nameChiled.text = userModel!.user_name;
      itemSelected = int.parse(userModel!.character.toString());
      itemSelectedlevel = int.parse(userModel!.level.toString()) - 1;
      print(itemSelectedlevel);
      print('itemSelectedlevel');

      chackboxStata = lisent;
    });
  }

  saveNewSttings() async {
    cachedData(
        data: 'UserInformation',
        key: UserModel(
            user_name: nameChiled.text,
            email: userModel!.email,
            level: (itemSelectedlevel + 1).toString(),
            character: itemSelected.toString(),
            update_at: DateTime.now().toString(),
            password: userModel!.password,
            id: userModel!.id));

    if (userModel!.id != null && await networkInfo.isConnected) {
      db.updateUserDate(UserModel(
          user_name: nameChiled.text,
          email: userModel!.email,
          level: (itemSelectedlevel + 1).toString(),
          character: itemSelected.toString(),
          update_at: DateTime.now().toString(),
          password: userModel!.password,
          id: userModel!.id));
    }
    cachedData(key: 'Listen_to_story', data: chackboxStata);
  }
}
