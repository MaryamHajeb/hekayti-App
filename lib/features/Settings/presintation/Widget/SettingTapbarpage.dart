import 'package:flutter/material.dart';
import 'package:hikayati_app/features/Home/presintation/page/HomePage.dart';
import 'package:hikayati_app/features/Regestrion/date/model/userMode.dart';
import 'package:hikayati_app/features/introdection/presintation/page/Splach_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/util/Carecters.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/CastemCarecters.dart';
import '../../../../core/widgets/CastemInput.dart';
import '../../../../core/widgets/CastemLevel.dart';
import '../../../../core/widgets/CustemButten.dart';
import '../../../../core/widgets/CustemButten2.dart';
import '../../../../core/widgets/CustomPageRoute.dart';
import '../../../../main.dart';
import '../../../Regestrion/presintation/page/LoginPage.dart';
import '../../../Regestrion/presintation/page/SignupPage.dart';
import '../../../Regestrion/presintation/page/ResetPasswordPage.dart';

class SettingTapbarpage extends StatefulWidget {
  const SettingTapbarpage({Key? key}) : super(key: key);

  @override
  State<SettingTapbarpage> createState() => _SettingTapbarpageState();
}

class _SettingTapbarpageState extends State<SettingTapbarpage> {
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
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('  اسم الطفل :', style: AppTheme.textTheme.headline3),
              CustemInput(
                size: 200,
                valdution: (value) {
                  if (value.toString().isEmpty) {
                    return 'يرجئ منك ادخال اسم الطفل ';
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
              style: AppTheme.textTheme.headline3,
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
              style: AppTheme.textTheme.headline3,
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
                            CachedDate('level', carecterslist.Levels[index]['num']);
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
                  style: AppTheme.textTheme.headline3,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right),
              Checkbox(
                  value: chackboxStata,
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
          userModel != null
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: screenUtil.screenWidth* .4,
                      height: screenUtil.screenHeight *.2,
                      child: Column(
                        children: [
                          Row(children: [
                            Text('البريد الاكتروني :',style: AppTheme.textTheme.headline3),
                            SizedBox(width: 20,),
                            Text('${userModel?.email.toString()}',style: TextStyle(color: Colors.grey,fontFamily: AppTheme.fontFamily,fontSize: 14),
                            )
                          ]),
                          SizedBox(height: 20,),
                          Row(children: [
                            Text('كـلـمـه  الــمـررو  :',style: AppTheme.textTheme.headline3),
                            SizedBox(width: 20,),
                            InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      CustomPageRoute(  child:   ResetPasswordPage()));

                                },
                                child: Text('اعاده تعيين',style: AppTheme.textTheme.headline4,)),

                          ]),
                        ],
                      ),
                    ),

                    ElevatedButton(
                      onPressed: ()async {

                        SharedPreferences prefs;
                        prefs = await SharedPreferences.getInstance();
                        prefs.setBool('onbording', false);
                        db.deleteTable('stories');
                        db.deleteTable('stories_media');
                        db.deleteTable('completion');
                        db.deleteTable('accuracy');
                        CachedDate('nameChlied','');
                        CachedDate('Carecters',0);
                        CachedDate('level',1);
                        Navigator.pushReplacement(
                            context,
                            CustomPageRoute(  child:   MyApp()));

                      },
                      child: Text('تسجيل الخروج',style: AppTheme.textTheme.bodyText1),
                      style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(AppTheme.primarySwatch.shade500) ),
                    ),


                  ],
                )
              : Column(
                  children: [
                    Text('هل تريد حفظ بياناتك معنا     (اختياري)',
                        style: AppTheme.textTheme.headline3,
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
                              style: AppTheme.textTheme.bodyText1),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppTheme.primaryColor)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context, CustomPageRoute(child: LoginPage()));
                          },
                          child: Text('تسجيل دخول',
                              style: AppTheme.textTheme.bodyText1),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppTheme.primarySwatch.shade600)),
                        ),
                      ],
                    ),
                  ],
                ),
          SizedBox(
            height: 50,
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
                        'تم حفظ بيناتك بنجاح',(){Navigator.pop(context);});
                  } catch (e) {}
                },
              ),
              SizedBox(
                width: 20,
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
            height: 50,
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
    int? carectersnum = await int.parse(getCachedDate('Carecters', String).toString());
    int? levels = await int.parse(getCachedDate('level', String).toString()) ;
    String? t = await getCachedDate('nameChlied', String) ?? '';
    bool lisent = await getCachedDate('Listen_to_story', bool) ?? '';
    checkUserLoggedIn().fold((l) {
      userModel = l;
    }, (r) {
      userModel = null;
    });

    setState(() {
      nameChiled.text = t ?? '';
      itemSelected = carectersnum ?? 10;
      itemSelectedlevel = levels!;
      chackboxStata = lisent;
    });
  }

  saveNewSttings() async{
    int carecters =
        int.parse(carecterslist.listcarecters[itemSelected]['id'].toString());
    int level =
        int.parse(carecterslist.Levels[itemSelectedlevel]['num'].toString());
    CachedDate('Carecters', carecters);
    CachedDate('nameChlied', nameChiled.text);
    CachedDate('level', level);
    CachedDate('Listen_to_story', chackboxStata);
     if(userModel!=null&& await networkInfo.isConnected){

       db.updateUserDate(UserModel(user_name: nameChiled.text, email: userModel!.email.toString(), level: level.toString(), character: carecters.toString(), update_at:  DateTime.now().millisecondsSinceEpoch.toString(), password: userModel!.password, id: userModel!.id.toString()));
     }



  }
}
