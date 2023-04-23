import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/ScreenUtil.dart';
import 'ReportCard.dart';

class ReportTapbarPage extends StatefulWidget {
  const ReportTapbarPage({Key? key}) : super(key: key);

  @override
  State<ReportTapbarPage> createState() => _ReportTapbarPageState();
}

class _ReportTapbarPageState extends State<ReportTapbarPage> {
  TextEditingController nameChiled =TextEditingController();
  ScreenUtil screenUtil=ScreenUtil();

  @override

  Widget build(BuildContext context) {
    screenUtil.init(context);

    return Column(
      children: [
        Text('المستوى الأول :',style:AppTheme.textTheme.headline3 ,textDirection: TextDirection.rtl,textAlign: TextAlign.right),
        Divider(color: AppTheme.primaryColor,),
        Container(
          height: screenUtil.screenHeight * .7 ,
          width: double.infinity,
          child: ListView.builder(itemCount: 20,itemBuilder: (context, index) {
             return ReportCard();
          },),
        )
      ],
    );
  }
}
