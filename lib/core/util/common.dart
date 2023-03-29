import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hikayati_app/core/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
// Either<int, bool> checkCart() {
//   try {
//     final data = LocalDataProvider(sharedPreferences: sl<SharedPreferences>())
//         .getCachedData(
//             key: 'CACHED_CART',
//             retrievedDataType: CartModel.init(),
//             returnType: List) as List;
//
//     if (data != null) {
//       return Left(data.length);
//     }
//     return Right(false);
//   } catch (e) {
//     return Right(false);
//   }
// }

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
            height: 150,
            width: 250,
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.primaryColor,width: 2),
                borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Text(text,style: AppTheme.textTheme.headline3,),

                Image.asset(image),
              ]),
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

// Future<void> oneSignalInitPlatformState(bool mounted) async {
//   if (!mounted) return;
//
//   OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
//
//   await OneSignal.shared.setAppId("92520e08-663c-48e6-a0b5-2638e840053e");
//
//   ///token OWIwMGMwZTgtNWY1Mi00OWI2LWE2ZmMtNDE0ZjQwN2FhMWMy
//   OneSignal.shared.consentGranted(true);
//
//   OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
//     // var test=jsonDecode(event.jsonRepresentation());
//     // var test=jsonEncode(event.jsonRepresentation());
//
//     print("Received notification is : \n${event.jsonRepresentation().replaceAll("\\n", "\n")}");
//     print('this is testing ${event.jsonRepresentation()}');
//   });
//   OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
//
//     print("Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}");
//   });
// }

// void AppDialog(
//     {required BuildContext context,
//     required String svgImage,
//     required String message,
//     required Function onYesClicked,
//     required Function onNoClicked,
//     String yesText = "نعم",
//     String noText = "لا",
//     bool allowPop = true,
//     bool pending = false}) async {
//   await showDialog(
//       context: context,
//       builder: (_) {
//         return WillPopScope(
//           onWillPop: () {
//             return Future.value(allowPop);
//           },
//           child: Dialog(
//             elevation: 0,
//             backgroundColor: Colors.transparent,
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 return Stack(
//                   alignment: Alignment.center,
//                   clipBehavior: Clip.none,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                                   vertical: 44.0, horizontal: 12.0)
//                               .copyWith(
//                                   bottom: (onYesClicked == null &&
//                                           onNoClicked == null)
//                                       ? 24.0
//                                       : 8.0),
//                           child: SingleChildScrollView(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.min,
//                               children: <Widget>[
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 12.0),
//                                   child: Text(
//                                     message,
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .subtitle1!
//                                         .copyWith(
//                                           color: AppTheme.primaryColor,
//                                         ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
//                                     onYesClicked != null
//                                         ? Expanded(
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: ElevatedButton(
//                                                 onPressed: () {
//                                                   pending
//                                                       ? null
//                                                       : onYesClicked();
//                                                 },
//                                                 child: pending
//                                                     ? Padding(
//                                                   padding: const EdgeInsets.all(5.0),
//                                                   child: SpinKitThreeBounce(
//                                                     color: AppTheme.scaffoldBackgroundColor,
//                                                     size: 15.0,
//                                                   ),
//                                                 )
//                                                     : Text(
//                                                         yesText,
//                                                         style: AppTheme
//                                                             .textTheme
//                                                             .headline3!
//                                                             .copyWith(
//                                                                 color: Colors
//                                                                     .white),
//                                                       ),
//                                                 color: AppTheme.primaryColor,
//                                                 padding: EdgeInsets.zero,
//                                               ),
//                                             ),
//                                           )
//                                         : SizedBox.shrink(),
//                                     onNoClicked != null
//                                         ? Expanded(
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: OutlineButton(
//                                                 onPressed: () {
//                                                   onNoClicked();
//                                                 },
//                                                 child: Text(
//                                                   noText,
//                                                   style: AppTheme
//                                                       .textTheme.headline3,
//                                                 ),
//                                                 borderSide: BorderSide(
//                                                     color:
//                                                         AppTheme.primaryColor,
//                                                     width: 1.0),
//                                               ),
//                                             ),
//                                           )
//                                         : SizedBox.shrink(),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       top: -40.0,
//                       child: Container(
//                         alignment: Alignment.center,
//                         width: 80.0,
//                         height: 80.0,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(1000.0)),
//                         child: Center(
//                           child: Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: SvgPicture.asset(svgImage),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         );
//       });
//}
