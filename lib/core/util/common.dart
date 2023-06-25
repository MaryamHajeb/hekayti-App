import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:confetti/confetti.dart';
import 'package:dartz/dartz.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hikayati_app/core/app_theme.dart';
import 'package:hikayati_app/dataProviders/remote_data_provider.dart';
import 'package:hikayati_app/features/Home/presintation/page/HomePage.dart';
import 'package:path_provider/path_provider.dart';
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

Future<String> getPathForimage(String path,String name)async{


    String dir = (await getExternalStorageDirectory())!.path+'/$path/$name';

    return dir.toString();
}




void showImagesDialog(BuildContext context, String image,String text,ontap) {
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
                  ontap();
                }, text: 'نعم',)
              ],
            ),
          ),
        );
      });
}
 showImagesDialogWithCancleButten(BuildContext context2, String image,String text,No_methoed,Ok_methoed) {
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

                       Ok_methoed();

                    }, text: 'نعم',),
                    CustemButten(ontap: (){
                      No_methoed();
                    }, text: 'لا',),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
 showImagesDialogWithDoNotWill(BuildContext context2, String image,String text,String readed_text,org_text) {
  showDialog(
      context: context2,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            elevation: 50,

            insetAnimationDuration: Duration(seconds: 30),
            shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 250,
              width: 350,
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(Icons.check_circle_rounded,color: Colors.green,size: 30),

                      Text(org_text,style: AppTheme.textTheme.headline3,overflow: TextOverflow.clip,textAlign: TextAlign.center,),

                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(Icons.cancel,color: Colors.red,size: 30),

                      Text(readed_text,style: AppTheme.textTheme.headline3,overflow: TextOverflow.clip,textAlign: TextAlign.center,),

                    ],
                  ),

                  SizedBox(height: 15,),
                  CustemButten2(ontap: (){

                    Navigator.pop(context);

                  }, text: 'نعم',)
                ],
              ),
            ),
          ),
        );
      });
}


showConfetti(context2,controler,image) {
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
            height: 250,
            width: 350,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.primaryColor,width: 4),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Container(
                child: Column(
                  children: [
                    Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('!!!!! مبروك ',style: TextStyle(fontSize: 22,fontFamily: AppTheme.fontFamily,color: AppTheme.primaryColor)),
                            Text('لقد اتممت ',style: AppTheme.textTheme.headline3,),
                            Text(' القصه بنجاح',style: AppTheme.textTheme.headline3,),
                          ],
                        ),

                        ConfettiWidget(
                          confettiController: controler,
                          shouldLoop: true,

                         numberOfParticles: 20,

                          colors: [AppTheme.primaryColor,AppTheme.primarySwatch.shade500,Color(0xFFFFAA3B)],

                        ),
                        Image.asset(image,width: 190,height: 190,fit: BoxFit.contain),
                      ],
                    ),
                    CustemButten2(ontap: (){

                      Navigator.push(context, CustomPageRoute(  child:   HomePage()));


                    }, text: 'نعم',)

                  ],
                ),
              ),
            ),
          ),
        );
      });
}
noInternt(context2,String text) {
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
              height: 120,
              width: 70,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.primaryColor,width: 4),
                  borderRadius: BorderRadius.circular(20)),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.signal_wifi_connected_no_internet_4_sharp,color: AppTheme.primaryColor,),
                  SizedBox(width: 10,),
                  Text(text,style: AppTheme.textTheme.headline3,overflow: TextOverflow.fade,textAlign: TextAlign.center,),


                ],)



          ),
        );
      });
}


initApp(String text) {
  return Center(
    child: Dialog(
      elevation: 50,

      insetAnimationDuration: Duration(seconds: 30),
      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
          height: 120,
          width: 70,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: AppTheme.primaryColor,width: 4),
              borderRadius: BorderRadius.circular(20)),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppTheme.primaryColor,),
              SizedBox(width: 10,),
              Text(text,style: AppTheme.textTheme.headline3,overflow: TextOverflow.clip,textAlign: TextAlign.center,),

            ],)



      ),
    ),
  );
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
 Future<String> getpath()async{
  final downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
  return downloadsDirectory.path.toString();
}