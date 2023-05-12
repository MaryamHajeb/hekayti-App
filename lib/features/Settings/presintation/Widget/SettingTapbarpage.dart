import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/Carecters.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/widgets/CastemCarecters.dart';
import '../../../../core/widgets/CastemInput.dart';
import '../../../../core/widgets/CastemLevel.dart';
import '../../../../core/widgets/CustemButten.dart';
import '../../../../main.dart';

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
  Carecters carecterslist =Carecters();

  TextEditingController nameChiled =TextEditingController();
   int itemSelected=0 ;
  int itemSelectedlevel =0;


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
              CustemInput(
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
            height: screenUtil.screenHeight * .4,
            width: double.infinity,
            child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: carecterslist.listcarecters.length,itemBuilder: (context, index) {

              return CustemCarecters(image: carecterslist.listcarecters[index]['image'].toString(), onTap: ()async{
                setState(() {
                  itemSelected=index;

                });
                final prefs = await SharedPreferences.getInstance();
                String dd=carecterslist.listcarecters[index]['id'].toString();
                prefs.setString('Carecters', dd);
                carecters= await  prefs.getString('Carecters') ?? '';
                print(prefs.getString('Carecters'));

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
                      CustemLevel(
                        name: Levels[index]['num'],
                        onTap: () {
                          setState(() {
                            itemSelectedlevel = index;
                          });
                        },
                        isSelected: itemSelectedlevel == index ? true : false,
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
initCarecters();

  }
  initCarecters()async{
    final prefs = await SharedPreferences.getInstance();
    carecters= await  prefs.getString('Carecters') ?? '';
     level= await  prefs.getString('level') ?? '';
     nameChiled.text= await  prefs.getString('nameChlied') ?? '';
    print(nameChiled.text);
    setState( () {


      itemSelected=int.parse(carecters) ?? 10;
      itemSelectedlevel=int.parse(level) ?? 10;

    });
    print(itemSelected);
    print('*************************');

  }
}
