import 'package:flutter/material.dart';
import 'package:hikayati_app/features/Home/presintation/page/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/Carecters.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/CastemCarecters.dart';
import '../../../../core/widgets/CastemInput.dart';
import '../../../../core/widgets/CastemLevel.dart';
import '../../../../core/widgets/CustemButten.dart';
import '../../../../core/widgets/CustomPageRoute.dart';
import '../../../../main.dart';

class SettingTapbarpage extends StatefulWidget {
  const SettingTapbarpage({Key? key}) : super(key: key);

  @override
  State<SettingTapbarpage> createState() => _SettingTapbarpageState();
}

class _SettingTapbarpageState extends State<SettingTapbarpage> {
  @override

  Carecters carecterslist =Carecters();

  TextEditingController nameChiled =TextEditingController();
   int itemSelected=0 ;
  int itemSelectedlevel =0;
  bool chackboxStata=false;


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
            },controler:nameChiled ,text: 'اكتب اسم طفلك',type: TextInputType.text,),


          ],),
          Divider(color: AppTheme.primaryColor,),
          SizedBox(height: 20,),
          Text('الشخصيات :',style:AppTheme.textTheme.headline3 ,textDirection: TextDirection.rtl,textAlign: TextAlign.right),
          SizedBox(height: 20,),

          Container(
            height: screenUtil.screenHeight * .4,
            width: double.infinity,
            child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: carecterslist.listcarecters.length,itemBuilder: (context, index) {

              return CustemCarecters(image: carecterslist.listcarecters[index]['image'].toString(), onTap: ()async{
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
                itemCount: carecterslist.Levels.length,

                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 50,),
                      CustemLevel(
                        name:carecterslist.Levels[index]['num'],
                        onTap: () {
                          setState(() {
                            itemSelectedlevel = index;
                          });
                        },
                        isSelected: itemSelectedlevel == index ? true : false,
                        color: carecterslist.Levels[index]['color'],
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('خاصية الاستماع للقصص',style:AppTheme.textTheme.headline3 ,textDirection: TextDirection.rtl,textAlign: TextAlign.right),
              Checkbox(value: chackboxStata, onChanged: (value){
                setState(() {
                  chackboxStata =value!;
                });
              }),

            ],
          ),
          SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustemButten( text: 'رجوع',ontap: ()async{

              Navigator.push(
                  context,
                  CustomPageRoute(  child:   HomePage()));

            },),
            SizedBox(width: 20,),
            CustemButten( text: 'حفظ',ontap: ()async{
              saveNewSttings();

            },),
          ],
        ),
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
  int   carectersnum= await  getCachedDate('Carecters',String) ?? '';
  int      levels= await  getCachedDate('level',int)  ?? '';
  String   t= await getCachedDate('nameChlied',String)  ?? '';
 // bool?   lisent= await getCachedDate('Listen_to_story',String)  ?? '';

    setState( () {
      nameChiled.text=t;
      itemSelected=carectersnum ?? 10;
      itemSelectedlevel= levels ?? 10;
  //    chackboxStata =lisent!;
    });


  }

  saveNewSttings(){
    int carecters=int.parse(carecterslist.listcarecters[itemSelected]['id'].toString());
    int level=int.parse(carecterslist.Levels[itemSelectedlevel]['id'].toString());
    CachedDate('Carecters',carecters);
    CachedDate('nameChlied',nameChiled.text);
    CachedDate('level',level);
    CachedDate('Listen_to_story',chackboxStata);
  }
}
