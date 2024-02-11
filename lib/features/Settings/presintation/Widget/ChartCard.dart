import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/AppTheme.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../gen/assets.gen.dart';

class ChartCard extends StatefulWidget {
  String page_no;
  String text;
  String text_readd;
  String photo;
  int accuracy_stars;
  ChartCard(
      {Key? key,
      required this.text,
      required this.text_readd,
      required this.photo,
      required this.accuracy_stars,
      required this.page_no})
      : super(key: key);

  @override
  State<ChartCard> createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  @override
  ScreenUtil screenUtil = ScreenUtil();
  Widget build(BuildContext context) {
    screenUtil.init(context);
    print("page_no" + widget.page_no);
    print(widget.photo);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                height: screenUtil.screenHeight * .08,
              ),
              Container(
                height: screenUtil.screenHeight * .1,
                width: screenUtil.screenWidth * .05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: Colors.white,
                  border: Border(
                      right: BorderSide(
                        color: AppTheme.primaryColor,
                        width: 2,
                      ),
                      left: BorderSide(
                        color: AppTheme.primaryColor,
                        width: 2,
                      ),
                      top: BorderSide(color: AppTheme.primaryColor, width: 2),
                      bottom:
                          BorderSide(color: AppTheme.primaryColor, width: 2)),
                ),
                child: Center(
                  child: Text(widget.page_no,
                      style: AppTheme.textTheme.displaySmall,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right),
                ),
              ),
            ],
          ),
          Card(
            margin: EdgeInsets.only(right: 0, left: 0, top: 30),
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))),
            elevation: 10,
            color: Colors.white,
            surfaceTintColor: Colors.white,
            shadowColor: Colors.white,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: AppTheme.primaryColor, width: 2)),
                width: screenUtil.screenWidth * .38,
                height: screenUtil.screenHeight * .2,
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Center(
                            child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                child: Image.file(
                                  File('${widget.photo}'),
                                  fit: BoxFit.cover,
                                  height: screenUtil.screenHeight * .25,
                                  width: screenUtil.screenWidth * .25,
                                )))),
                    Expanded(
                      flex: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(widget.text,
                              style: AppTheme.textTheme.headlineSmall,
                              overflow: TextOverflow.clip,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right),
                          Text(widget.text_readd,
                              style: AppTheme.textTheme.headlineSmall,
                              overflow: TextOverflow.clip,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(3, (index) {
                          if (index < widget.accuracy_stars) {
                            return Image.asset(
                              Assets.images.start.path,
                              width: 20,
                              height: 20,
                              fit: BoxFit.fill,
                            );
                          } else {
                            return Image.asset(
                              Assets.images.emptyStar.path,
                              width: 20,
                              height: 20,
                              fit: BoxFit.fill,
                            );
                          }
                        }),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
