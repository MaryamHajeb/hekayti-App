import 'package:flutter/material.dart';
import 'package:hikayati_app/core/app_theme.dart';

import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/util/common.dart';

class StoryCard extends StatefulWidget {
  final name;
  String photo;
  final starts;
   StoryCard({Key? key,required this.name,required this.photo,required this.starts}) : super(key: key);

  @override
  State<StoryCard> createState() => _StoryCardState();
}

class _StoryCardState extends State<StoryCard> {
  ScreenUtil screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);

    return Container(
      width: screenUtil.screenWidth *.3,
      height: screenUtil.screenHeight *.4,


      decoration:
      BoxDecoration(
        image: DecorationImage(image: AssetImage('assest/images/storyBG.png'))

      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

           widget.starts == 1 ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [



                Image.asset('assest/images/start.png'),


              ],
            ):widget.starts ==2?
           Row(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [


        Image.asset('assest/images/start.png'),

        Image.asset('assest/images/start.png'),


      ],
    ): widget.starts ==0 ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [



                Image.asset('assest/images/start.png'),


              ],
            ):
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [



               Image.asset('assest/images/start.png'),
               Padding(
                 padding: const EdgeInsets.only(bottom: 20.0),
                 child: Image.asset('assest/images/start.png'),
               ),
               Image.asset('assest/images/start.png'),

             ],
           ),
            SizedBox(height: 10,),
            Image.memory(
              converToBase64(
                 widget.photo.toString()
              ),
              fit: BoxFit.cover,

              ),
         SizedBox(height: 10,),
         Text(widget.name,style: AppTheme.textTheme.headline5,)
        
      ]),
      );
  }
}
