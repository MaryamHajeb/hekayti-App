import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/widgets/CastemInput.dart';
import '../../../../core/widgets/CastemLevel.dart';
import '../../../../core/widgets/CastemPersons.dart';
import '../../../../core/widgets/CustemButten.dart';

class SettingTapbarpage extends StatefulWidget {
  const SettingTapbarpage({Key? key}) : super(key: key);

  @override
  State<SettingTapbarpage> createState() => _SettingTapbarpageState();
}

class _SettingTapbarpageState extends State<SettingTapbarpage> {
  @override
  List Levels = [
    {'num': 1, 'color': AppTheme.primarySwatch.shade800},
    {'num': 2, 'color': AppTheme.primarySwatch.shade600},
    {'num': 3, 'color': AppTheme.primarySwatch.shade400},
  ];

  TextEditingController nameChiled =TextEditingController();
  int itemSelected =0;
  int itemSelected2 =0;
  List image=[
    'images/boy4.png',
    'images/boy3.png',
    'images/boy2.png',
    'images/girl4.png',
    'images/girl3.png',
    'images/girl2.png',
  ];

  ScreenUtil screenUtil=ScreenUtil();
  Widget build(BuildContext context) {
    screenUtil.init(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Text('  اسم الطفل :',style:AppTheme.textTheme.headline3 ),
            CastemInput(
              size: 200,
              valdution: (value){
              if(value.toString().isEmpty){
                return'يرجئ منك ادخال اسم الطفل ';

              }
              return null;
            },controler:nameChiled ,icon: Icon(Icons.boy,color: AppTheme.primaryColor,size: 40),text: 'اكتب اسم طفلك',type: TextInputType.text,),


          ],),
          Divider(color: AppTheme.primaryColor,),
          SizedBox(height: 20,),
          Text('الشخصيات :',style:AppTheme.textTheme.headline3 ,textDirection: TextDirection.rtl,textAlign: TextAlign.right),
          Container(
            height: screenUtil.screenHeight * .5,
            width: double.infinity,
            child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: image.length,itemBuilder: (context, index) {

              return CastemPersons(image: image[index], onTap: (){
                setState(() {
                  itemSelected=index;
                });

              }, isSelected: itemSelected==index?  true : false ,);

            },),
          ),
          Divider(color: AppTheme.primaryColor,),
          SizedBox(height: 20,),

          Text('مستوى القصص :',style:AppTheme.textTheme.headline3 ,textDirection: TextDirection.rtl,textAlign: TextAlign.right),
          Container(
            height: screenUtil.screenHeight * .4,
            width: double.infinity,
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: Levels.length,

                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 50,),
                      CastemLevel(
                        name: Levels[index]['num'],
                        onTap: () {
                          setState(() {
                            itemSelected2 = index;
                          });
                        },
                        isSelected: itemSelected2 == index ? true : false,
                        color: Levels[index]['color'],
                      ),
                      SizedBox(width: 70,)
                    ],
                  );
                },
              ),
            ),
          ),
          Divider(color: AppTheme.primaryColor,),
          SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('خاصية الاستماع للقصص',style:AppTheme.textTheme.headline3 ,textDirection: TextDirection.rtl,textAlign: TextAlign.right),
              Checkbox(value: true, onChanged: (value){}),

            ],
          ),
          SizedBox(height: 20,),
        CustemButten( text: 'حفظ',ontap: (){},),
          SizedBox(height: 20,),


        ],
      ),
    );
  }
}
