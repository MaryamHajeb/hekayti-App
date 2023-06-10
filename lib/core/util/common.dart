
import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:hikayati_app/core/app_theme.dart';
import 'package:hikayati_app/dataProviders/remote_data_provider.dart';
import 'package:hikayati_app/features/Home/presintation/page/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dataProviders/local_data_provider.dart';
import '../../features/Regestrion/date/model/userMode.dart';
import '../../injection_container.dart';
import '../widgets/CustemButten.dart';
import '../widgets/CustemButten2.dart';
import '../widgets/CustomPageRoute.dart';
import '../widgets/primaryText.dart';

// CachedNetworkImage cachedNetworkImage({required String image,width=null,height=null,onFailed}) {
//   return CachedNetworkImage(
//       fit: BoxFit.cover,
//       // imageUrl: DataSourceURL.baseUrl + imagePath + image,
//       imageUrl: DataSourceURL.baseImagesUrl + image,
//       //
//       placeholder: (context, url) => Center(
//           child: Image.asset(
//             "assets/images/foodloading.gif",
//             fit: BoxFit.cover,
//             height:height ?? double.infinity,
//             width: width ?? double.infinity,
//           )),
//       errorWidget: (context, url, error) {
//         if(onFailed!=null)  onFailed();
//         return Center(
//             child: Image.asset(
//               "assets/images/background2.jpg",
//               fit: BoxFit.cover,
//               height: height ?? double.infinity,
//               width: width ?? double.infinity,
//             ));
//       });
// }

// Either<CustomerModel, bool> checkCustomerLoggedIn() {
//   try {
//     final customer =
//         LocalDataProvider(sharedPreferences: sl<SharedPreferences>())
//             .getCachedData(
//                 key: 'CUSTOMER_USER',
//                 retrievedDataType: CustomerModel.init(),
//                 returnType: List<CustomerModel>);
//     if (customer != null) {
//       return Left(customer);
//     }
//     return Right(false);
//   } catch (e) {
//     print("checkLoggedIn catch");
//     return Right(false);
//   }
// }
//
//
// Either<String, bool> checkOnboarding() {
//   try {
//     final onboarding = LocalDataProvider(sharedPreferences: sl<SharedPreferences>())
//         .getCachedData(
//             key: 'onbordingShowen',
//             retrievedDataType: String,
//             returnType: String);
//     if (onboarding != null) {
//       return Left(onboarding);
//     }
//     return Right(false);
//   } catch (e) {
//     print("checkLoggedIn catch");
//     return Right(false);
//   }
// }
//
//
//
dynamic  getCachedDate(String key,dynamic type) {

       final data = LocalDataProvider(
           sharedPreferences: sl<SharedPreferences>())
           .getCachedData(
           key: key,
           retrievedDataType: type,
           returnType: type
       );

      return data;

}


CachedDate(String key,dynamic  dataCached) {

  final data = LocalDataProvider(sharedPreferences: sl<SharedPreferences>())
      .cacheData(
      key:key,
      data: dataCached) ;


}

converToBase64(String text){

  Uint8List image = base64Decode(text);
  return image;
}




void showImagesDialog(BuildContext context, String image,String text) {
  showDialog(
    barrierColor: AppTheme.primarySwatch.shade400,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,

          insetAnimationDuration: Duration(seconds: 30),
          shape: RoundedRectangleBorder(
            
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 180,
            width: 300,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.primaryColor,width: 4),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                SizedBox(height: 5,),
                Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex:2,child: Image.asset(image,height: 100,width: 100,)),
                      SizedBox(width: 10,),
                      Expanded(flex: 3,child: Text(text,style: AppTheme.textTheme.headline3,overflow: TextOverflow.clip,textAlign: TextAlign.center,)),


                    ]),
                SizedBox(height: 15,),
                CustemButten(ontap: (){
                  Navigator.pop(context);
                }, text: 'نعم',)
              ],
            ),
          ),
        );
      });
}
 showImagesDialogWithCancleButten(BuildContext context2, String image,String text) {
  showDialog(
      context: context2,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 50,

          insetAnimationDuration: Duration(seconds: 30),
          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 180,
            width: 300,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.primaryColor,width: 4),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                SizedBox(height: 5,),
                Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex:2,child: Image.asset(image,height: 100,width: 100,)),
                      SizedBox(width: 10,),

                      Expanded(flex: 3,child: Text(text,style: AppTheme.textTheme.headline3,overflow: TextOverflow.clip,textAlign: TextAlign.center,)),


                    ]),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustemButten2(ontap: (){

                      Navigator.pop(context);
                      Navigator.pop(context2);

                    }, text: 'نعم',),
                    CustemButten(ontap: (){
                      Navigator.pop(context);
                    }, text: 'لا',),
                  ],
                )
              ],
            ),
          ),
        );
      });
}



showSnackBar({required BuildContext context,required title,Color bkColor=Colors.red,Function ?callBackFunction}){
  final snackBar = SnackBar(
    content: PrimaryText(text: title,fontSize: 15,textColor: Colors.white),
    backgroundColor: bkColor,

  );
  ScaffoldMessenger.of(context)
      .showSnackBar(snackBar);

  Future.delayed(Duration(seconds: 2),()
  {
    callBackFunction!();
  });

}

void commonDialog(BuildContext context, String image,String text) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 20,
          insetAnimationDuration: Duration(seconds: 10),
          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            width: 350,
            height: 200,
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.primaryColor,width: 3),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(text,style: AppTheme.textTheme.headline3,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    ElevatedButton(onPressed: (){}, child: Text('yes')),
                    SizedBox(width: 30,),
                    ElevatedButton(onPressed: (){}, child: Text('yes')),

                  ],),
                  Image.asset(image),
                ],)

              ],
            ),
          ),
        );
      });
}



Either<UserModel, bool> checkUserLoggedIn() {
  try {
    final customer =
    //RemoteDataProvider(client: sl()).sendData(url: url, body: body, retrievedDataType: retrievedDataType)

    LocalDataProvider(sharedPreferences: sl<SharedPreferences>())
        .getCachedData(
        key: 'UserInformation',
        retrievedDataType: UserModel.init(),
        returnType: List<UserModel>);
    if (customer != null) {
      return Left(customer);
    }
    return Right(false);
  } catch (e) {
    print("checkLoggedIn catch");
    return Right(false);
  }
}
