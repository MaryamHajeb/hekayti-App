import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:hikayati_app/features/Settings/presintation/page/TabBarPage.dart';
import '../../../../core/AppTheme.dart';
import '../../../../core/widgets/CustomField.dart';
import '../../../../core/widgets/CustomButton.dart';
import '../../../../core/widgets/CustomPageRoute.dart';
import '../../../../gen/assets.gen.dart';

class LockPage extends StatefulWidget {
  const LockPage({Key? key}) : super(key: key);

  @override
  State<LockPage> createState() => _LockPageState();
}

class _LockPageState extends State<LockPage> {
  ScreenUtil screenUtil = ScreenUtil();
  TextEditingController result = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  int num1 = Random().nextInt(50);
  int num2 = Random().nextInt(50);
  int num3 = Random().nextInt(50);
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/backgraond.png',
                ),
                fit: BoxFit.fill),
          ),
          height: screenUtil.screenHeight * 1,
          width: screenUtil.screenWidth * 1,
          child: Center(
              child: Container(
            height: screenUtil.screenHeight * .9,
            width: screenUtil.screenWidth * .8,
            margin: EdgeInsets.only(
              top: screenUtil.screenHeight * .05,
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
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CircleAvatar(
                          maxRadius: 40,
                          backgroundColor: Colors.white,
                          child: Image.asset(Assets.images.logo.path),
                        ),
                        Text('حكايتي', style: AppTheme.textTheme.displaySmall),
                        Text(
                            'لطفاً، قم بحل هذه المعادلة للضبط إعدادات التطبيق :',
                            style: AppTheme.textTheme.displaySmall),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                height: screenUtil.screenHeight * .4,
                                width: screenUtil.screenWidth * .2,
                                child: Image.asset(
                                    Assets.images.Characters.hana.happy.path)),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                      height: screenUtil.screenHeight * .1,
                                      width: screenUtil.screenWidth * .3,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: AppTheme
                                                  .primarySwatch.shade400),
                                          color: AppTheme.primarySwatch.shade50,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: EdgeInsets.only(
                                          bottom: 30,
                                          top: 0,
                                          left: 0,
                                          right: 50),
                                      child: Center(
                                          child: Text(
                                        '$num1 + $num2 + $num3   ',
                                        style: AppTheme.textTheme.displayLarge,
                                        textDirection: TextDirection.rtl,
                                      ))),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 30,
                                      ),
                                      CustomField(
                                        size: 200,
                                        valdution: (value) {
                                          if (value.toString().isEmpty) {
                                            return 'يرجى منك كتابه الحل';
                                          }
                                          if (int.parse(value.toString()) !=
                                              num1 + num2 + num3) {
                                            return 'يرجى منك كتابه الحل بشكل صحيح';
                                          }

                                          return null;
                                        },
                                        controler: result,
                                        icon: Icon(Icons.calculate),
                                        text: 'اكتب الحل ',
                                        type: TextInputType.number,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                                height: screenUtil.screenHeight * .4,
                                width: screenUtil.screenWidth * .2,
                                child: Image.asset(Assets
                                    .images.Characters.mohamed.happy.path)),
                          ],
                        ),
                        CustomButton(
                          ontap: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(context,
                                  CustomPageRoute(child: TabBarPage()));
                            }
                          },
                          text: 'تم',
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
