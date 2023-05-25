import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:hikayati_app/dataProviders/local_data_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/CastemInput.dart';
import '../../../../core/widgets/CustemIcon.dart';
import '../../../../gen/assets.gen.dart';

class onboardingThree extends StatefulWidget {
  const onboardingThree({Key? key}) : super(key: key);

  @override
  State<onboardingThree> createState() => _onboardingThreeState();
}

class _onboardingThreeState extends State<onboardingThree> {
ScreenUtil screenUtil=ScreenUtil();
TextEditingController  nameChiled=TextEditingController();
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          Text('قم  بإدخال اسم طفلك',style:AppTheme.textTheme.headline3 ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  height: screenUtil.screenHeight *.4,
                  width: screenUtil.screenWidth * .2,
                  child: Image.asset(Assets.images.carecters.hana.happy.path)),

              Column(children: [
                CustemInput(
                  size: 200,
                  onching: (value){


                  },
                  valdution: (value){
                    if(value.toString().isEmpty){
                      return'يرجئ منك ادخال اسم الطفل ';

                    }else{
                      saveNameChlied();
                    }
                    return null;
                  },controler:nameChiled ,text: 'اكتب اسم طفلك',type: TextInputType.text,)


              ],),
              Container(
                  height: screenUtil.screenHeight *.4,
                  width: screenUtil.screenWidth * .2,
                  child: Image.asset(Assets.images.carecters.hasham.happy.path)),


            ],),


        ],
      );
  }

  saveNameChlied()async{
    CachedDate('nameChlied',nameChiled.text);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 initname();
  }

initname()async{
  String   t= await getCachedDate('nameChlied',String)  ?? '';
  setState(() {
    nameChiled.text=t;

  });

}

}
