import 'package:flutter/material.dart';
import 'package:hikayati_app/core/app_theme.dart';
import 'package:hikayati_app/core/widgets/CastemInput.dart';

import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/widgets/CustemIcon.dart';
import '../../../../core/widgets/CustomPageRoute.dart';
import '../../../Regestrion/presintation/page/LoginPage.dart';
import '../../../Story/presintation/page/StoryPage.dart';
import '../Widget/StoryCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  ScreenUtil screenUtil = ScreenUtil();
  TextEditingController search = TextEditingController();
  Widget build(BuildContext context) {
    screenUtil.init(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          height: screenUtil.screenHeight * 1,
          width: screenUtil.screenWidth * 1,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/backgraond.png'),
                  fit: BoxFit.fill)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                        child:
                            Image.asset('images/girl3.png', fit: BoxFit.cover),
                        backgroundColor: Colors.white),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: AppTheme.primarySwatch.shade400,
                                width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        width: screenUtil.screenWidth * .2,
                        height: screenUtil.screenHeight * .1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('images/start.png'),
                            Text('2/24')
                          ],
                        )),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        width: screenUtil.screenWidth * .4,
                        height: screenUtil.screenHeight * .1,
                        child: CastemInput(
                            valdution: (value) {},
                            icon: Icon(Icons.search),
                            text: 'بحث',
                            controler: search)),
                    CircleAvatar(
                        child: Icon(Icons.surround_sound_sharp,
                            color: AppTheme.primaryColor),
                        backgroundColor: Colors.white),
                  ],
                ),
                Container(
                  height: screenUtil.screenHeight * .8,
                  width: double.infinity,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {

                      return InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            CustomPageRoute(  child:   StoryPage()));

                      },
                      child: StoryCard());
                    },
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
