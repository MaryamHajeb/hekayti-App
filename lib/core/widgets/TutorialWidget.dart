import 'package:flutter/material.dart';
import 'package:hikayati_app/core/AppTheme.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:hikayati_app/core/widgets/SecondaryCustomButton.dart';
import '../util/CharactersList.dart';

class TutorialWidget extends StatelessWidget {
  int Characters = 0;
  String text;
  Function onTap;
  int index;
  final hight;
  TutorialWidget(
      {super.key,
      this.hight,
      required this.index,
      required this.text,
      required this.Characters,
      required this.onTap});
  ScreenUtil screenUtil = ScreenUtil();
  CharactersList CharactersListobj = CharactersList();
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Container(
        width: screenUtil.screenWidth * 1,
        height: hight ?? screenUtil.screenHeight * 1,
        child: Row(
          children: [
            Image.asset(
              CharactersListobj.happyListCharactersList[Characters]["image"],
              height: screenUtil.screenHeight * .5,
              width: screenUtil.screenWidth * .2,
            ),
            Container(
              width: screenUtil.screenWidth * .3,
              height: screenUtil.screenHeight * .4,
              padding: EdgeInsets.all(screenUtil.screenWidth * .015),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: AppTheme.fontFamily,
                        ),
                      ),
                    ),
                    SecondaryCustomButton(
                        text: "حسناً",
                        ontap: () {
                          onTap();
                        })
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
