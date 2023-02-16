import 'package:dots_indicator/dots_indicator.dart';
import 'package:fashion/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/widgets/CustemButten.dart';
import '../../manger/model/onbording_model.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<onbording_model> onbording_list = [
    onbording_model(
        1,
        "تمتع بخدمة أضمن في شراء منتجاتك",
        "تمتع بخدمة أضمن في شراء منتجاتكتمتع بخدمة أضمن في شراء منتجاتكتمتع بخدمة أضمن في شراء منتجاتكتمتع بخدمة أضمن في شراء منتجاتك",
        "assets/images/onbording1.svg"),
    onbording_model(
        2,
        "قم بشراء جميع المنتجات والدفع عند التوصيل",
        "تمتع بخدمة أضمن في شراء منتجاتكتمتع بخدمة أضمن في شراء منتجاتكتمتع بخدمة أضمن في شراء منتجاتكتمتع بخدمة أضمن في شراء منتجاتك",
        "assets/images/onbording2.svg"),
  ];
  ScreenUtil _screenUtil =ScreenUtil();
  int currentIndexPage = 0;
  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height:   _screenUtil.screenHeight *.8,
                child: PageView.builder(
                  itemCount: onbording_list.length + 1,
                  itemBuilder: (context, index) {
                    return index == 2
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                currentIndexPage = index;
                                print(index);
                                print(currentIndexPage);
                              });
                            },
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                      SvgPicture.asset("assets/images/login.svg",
                                      semanticsLabel: 'Acme Logo'),
                                       SizedBox(height: 50,),
                                  Text(
                                    "لشراء منتجاتنا الرجاء تسجيل الدخول",
                                    style: AppTheme.textTheme.headline2,
                                  ),
                                       SizedBox(height: 150,),
                                  CustemButten(text: "ابدا التسوق ",ontap: (){},color: AppTheme.primaryColor),

                                  SizedBox(height: 30,),
                              CustemButten(text: "تسجيل الدخول",ontap: (){},color: Colors.white,textColor: AppTheme.primaryColor),
                                      SizedBox(height: 50,),
                                    ],
                              ),
                            ))
                        : InkWell(
                            onTap: () {
                              setState(() {
                                currentIndexPage = index;
                                print(index);
                                print(currentIndexPage);
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                    onbording_list[index].Image.toString(),
                                    semanticsLabel: 'Acme Logo'),
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  onbording_list[index].Title,
                                  style: AppTheme.textTheme.headline2,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 30.0, left: 30),
                                  child: Center(
                                      child: Text(
                                    onbording_list[index].SubTitle,
                                    style: AppTheme.textTheme.headline2,
                                    textAlign: TextAlign.center,
                                  )),
                                ),
                                SizedBox(
                                  height: 100,
                                ),
                                DotsIndicator(
                                  dotsCount: onbording_list.length,
                                  position: index.toDouble(),
                                  decorator: DotsDecorator(
                                    size: const Size.square(9.0),
                                    color: AppTheme.primaryColor,
                                    activeColor: AppTheme.primaryColor,
                                    activeSize: const Size(30.0, 9.0),
                                    activeShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0)),
                                  ),
                                )
                              ],
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
