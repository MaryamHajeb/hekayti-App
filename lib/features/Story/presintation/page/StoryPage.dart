import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/CastemInput.dart';
import '../../../../core/widgets/CustemIcon.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  ScreenUtil screenUtil = ScreenUtil();
  TextEditingController result = TextEditingController();
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
                  'images/backgraond.png',
                ),
                fit: BoxFit.fill),
          ),
          height: screenUtil.screenHeight * 1,
          width: screenUtil.screenWidth * 1,
          child: Center(
              child: Row(
            children: [
              Container(
                width: screenUtil.screenWidth * .1,
                height: screenUtil.screenHeight * 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.home,
                          color: Colors.white,
                          size: 50,
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.home,
                              color: Colors.white,
                              size: 50,
                            )),
                        IconButton(
                            onPressed: () {
                            //  showImagesDialog(context,'images/girl4.png','أحسنت');
                              commonDialog(context,'images/girl4.png','هل تريد المغادرة؟',);
                            },
                            icon: Icon(
                              Icons.home,
                              color: Colors.white,
                              size: 50,
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: screenUtil.screenHeight * 1,
                width: screenUtil.screenWidth * .8,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width: screenUtil.screenWidth * 1,
                            height: screenUtil.screenHeight * .8,
                            padding:
                                EdgeInsets.only(right: 10, left: 10, top: 10),
                            child: Image.asset(
                              'images/storypages.png',
                              fit: BoxFit.cover,
                            )),
                        Container(

                          width: screenUtil.screenHeight * 1,
                          height: screenUtil.screenHeight *.1,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               SvgPicture.asset(
                                color: AppTheme.primarySwatch.shade500,
                                'images/bottons/rightarrow.svg',
                              ),
                               Text('مشت ليلى عبر الغابة الكبيرة لزيارة جدتها المريضة'),
                           SvgPicture.asset(
                            color: AppTheme.primarySwatch.shade500,
                            'images/bottons/leftarrow.svg',
                          ),


                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
