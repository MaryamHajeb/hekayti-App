import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/CastemInput.dart';
import '../../../../core/widgets/CustemIcon.dart';
import '../../../../core/widgets/CustemIcon2.dart';

class StoryPage extends StatefulWidget {
  final id;
   StoryPage({Key? key,required this.id}) : super(key: key);

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  ScreenUtil screenUtil = ScreenUtil();
  bool isSpack=false;
  bool islisnt=false;
  int currentIndexPage =0;
  PageController pageControler=PageController();
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
                    CustemIcon2(icon: Icon(Icons.home,),ontap: (){
                      Navigator.pop(context);
                    }),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        isSpack ==false?  CustemIcon2(icon: Icon(Icons.headset_mic_outlined,),ontap: (){
                          setState(() {
                            isSpack=true ;


                          });

                        }):                        CustemIcon(icon: Icon(Icons.headset_mic_outlined,),ontap: (){}),




                        SizedBox(height: 30,),
                        isSpack ==false?  CustemIcon2(icon: Icon(Icons.mic,),ontap: (){
                          setState(() {
                            isSpack=true ;


                          });

                        }):                        CustemIcon(icon: Icon(Icons.mic,),ontap: (){}),

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
                  child: PageView.builder(
                    itemCount: 3,
                    reverse: true,
                    controller: pageControler,
                    itemBuilder: (context, index) {
                    return  InkWell(
                      onTap: (){

                        setState(() {
                          currentIndexPage = index;

                        });
                      },
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
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                       index =index+1;
                                       pageControler.nextPage(duration: Duration(seconds: 1), curve: Curves.bounceInOut);
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      color: AppTheme.primarySwatch.shade500,
                                      'images/bottons/rightarrow.svg',
                                    ),
                                  ),

                                  Text('مشت ليلى عبر الغابة الكبيرة لزيارة جدتها المريضة'),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        index =index+1;
                                        pageControler.previousPage(duration: Duration(seconds: 1), curve: Curves.bounceInOut);
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      color: AppTheme.primarySwatch.shade500,
                                      'images/bottons/leftarrow.svg',
                                    ),
                                  ),


                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
