import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/AppTheme.dart';
import '../../../../core/util/CharactersList.dart';
import '../../../../core/util/Common.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../main.dart';
import '../../../Regestrion/date/model/userMode.dart';

class DownloadWidget extends StatefulWidget {
  UserModel? userModel;
  final onTap;
  int stars;
  String name;
  String imagePath;
  DownloadWidget(
      {super.key,
      this.userModel,
      required this.onTap,
      required this.stars,
      required this.name,
      required this.imagePath});

  @override
  State<DownloadWidget> createState() => _DownloadWidgetState();
}

class _DownloadWidgetState extends State<DownloadWidget> {
  @override
  ScreenUtil screenUtil = ScreenUtil();
  CharactersList CharactersListobj = CharactersList();
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return InkWell(
        onTap: () async {
          if (await networkInfo.isConnected) {
            showImagesDialog(
                context,
                '${CharactersListobj.showCharactersList[int.parse(widget.userModel!.character.toString())]['image']}',
                'اظغط على زر التنزيل من اجل تحميل هذة القصه', () {
              Navigator.pop(context);
            });
          } else {
            showImagesDialog(
                context,
                '${CharactersListobj.FaceCharactersList[int.parse(widget.userModel!.character.toString())]['image']}',
                'تاكد من وجود انترنت من اجل تنزيل هذه القصه ', () {
              Navigator.pop(context);
            });
          }
        },
        child: Container(
          width: screenUtil.screenWidth * .3,
          height: screenUtil.screenHeight * .6,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              Assets.images.storyBG.path,
            ),
            fit: BoxFit.contain,
          )),
          child: Opacity(
            opacity: .6,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      // Check if the current index should have a filled star
                      bool hasFilledStar = index < widget.stars;
                      return Padding(
                        padding:
                            EdgeInsets.only(bottom: index == 1 ? 30.0 : 0.0),
                        child: Image.asset(
                            hasFilledStar
                                ? Assets.images.start.path
                                : Assets.images.emptyStar.path,
                            width: 40,
                            height: 40),
                      );
                    }),
                  ),
                  Container(
                    height: screenUtil.screenHeight * .3,
                    width: screenUtil.screenWidth * .14,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File('${path + '/' + widget.imagePath}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: screenUtil.screenHeight * .08,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () async {
                              widget.onTap();
                            },
                            icon: Icon(
                              Icons.download,
                              size: 25,
                              color: AppTheme.primaryColor,
                            )),
                        Text(
                          widget.name,
                          style: AppTheme.textTheme.headlineSmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ]),
          ),
        ));
  }
}
