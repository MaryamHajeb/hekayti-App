import 'package:flutter/material.dart';
import 'package:hikayati_app/core/app_theme.dart';

import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/util/common.dart';
import '../../../../gen/assets.gen.dart';

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

    return Wrap(

      children: [
          Center(
            child: Container(
            width: screenUtil.screenWidth *.25,
            height: screenUtil.screenHeight *.6,


            decoration:
            BoxDecoration(


              image: DecorationImage(image: AssetImage(Assets.images.storyBG.path,),fit: BoxFit.contain,)

            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                 widget.starts == 1 ? Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [



                Image.asset(Assets.images.start.path,width: 40,height: 40,),
                     Padding(
                       padding: const EdgeInsets.only(bottom: 20.0),
                       child: Image.asset(Assets.images.emptyStar.path,width: 40,height: 40),
                     ),
                     Image.asset(Assets.images.emptyStar.path,width: 40,height: 40),

                   ],
                 ):widget.starts ==2?
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [



                    Image.asset(Assets.images.start.path,width: 40,height: 40),
                     Padding(
                       padding: const EdgeInsets.only(bottom: 20.0),
                       child:Image.asset(Assets.images.start.path,width: 40,height: 40),
                     ),
                     Image.asset(Assets.images.emptyStar.path,width: 40,height: 40),

                   ],
                 ): widget.starts ==0 ? Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [



                     Image.asset(Assets.images.emptyStar.path,width: 40,height: 40),
                     Padding(
                       padding: const EdgeInsets.only(bottom: 20.0),
                       child: Image.asset(Assets.images.emptyStar.path,width: 40,height: 40),
                     ),
                     Image.asset(Assets.images.emptyStar.path,width: 40,height: 40),

                   ],
                 ):
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [



                     Image.asset(Assets.images.start.path,width: 40,height: 40),
                     Padding(
                       padding: const EdgeInsets.only(bottom: 20.0),
                       child:Image.asset(Assets.images.start.path,width: 40,height: 40),
                     ),
                    Image.asset(Assets.images.start.path,width: 40,height: 40),

                   ],
                 ),



                  Container(
                    height: screenUtil.screenHeight * .3,
                    width: screenUtil.screenWidth *.14,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(Assets.images.storypages.path,fit: BoxFit.cover,),
                      // child: Image.memory(
                      //
                      //   converToBase64(widget.photo.toString()
                      //   ),
                      //   fit: BoxFit.cover,
                      //   ),
                    ),
                  ),
               SizedBox(height: 10,),
               Text(widget.name,style: AppTheme.textTheme.headline5,)

            ]),
            ),
          ),
        ],
    );
  }
}
