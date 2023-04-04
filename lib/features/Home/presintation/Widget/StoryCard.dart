import 'package:flutter/material.dart';
import 'package:hikayati_app/core/app_theme.dart';

import '../../../../core/util/ScreenUtil.dart';

class StoryCard extends StatefulWidget {
  final name;
  final photo;
  final starts;
   StoryCard({Key? key,required this.name, this.photo,required this.starts}) : super(key: key);

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
        image: DecorationImage(image: AssetImage('images/storyBG.png'))

      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

           widget.starts == 1 ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [



                Image.asset('images/start.png'),


              ],
            ):widget.starts ==2?
           Row(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [


        Image.asset('images/start.png'),

        Image.asset('images/start.png'),


      ],
    ):
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [



               Image.asset('images/start.png'),
               Padding(
                 padding: const EdgeInsets.only(bottom: 20.0),
                 child: Image.asset('images/start.png'),
               ),
               Image.asset('images/start.png'),

             ],
           ),
            SizedBox(height: 10,),
         Image.asset('images/story1.png'),
         SizedBox(height: 10,),
         Text(widget.name,style: AppTheme.textTheme.headline5,)
        
      ]),
      );
  }
}
