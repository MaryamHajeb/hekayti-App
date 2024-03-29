import 'package:confetti/confetti.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hikayati_app/core/AppTheme.dart';
import 'package:hikayati_app/features/Home/presintation/page/HomePage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../dataProviders/local_data_provider.dart';
import '../../features/Regestrion/date/model/userMode.dart';
import '../../gen/assets.gen.dart';
import '../../injection_container.dart';
import '../widgets/SecondaryCustomButton.dart';
import '../widgets/CustomButton.dart';
import '../widgets/CustomPageRoute.dart';
import '../widgets/PrimaryText.dart';

getCachedData(
    {required key,
    required retrievedDataType,
    required dynamic returnType}) async {
  try {
    return LocalDataProvider(sharedPreferences: sl<SharedPreferences>())
        .getCachedData(
            key: key,
            retrievedDataType: retrievedDataType,
            returnType: returnType);
  } catch (e) {
    print(e);
  }
}

cachedData({required key, required data}) async {
  try {
    final customer =
        await LocalDataProvider(sharedPreferences: sl<SharedPreferences>())
            .cacheData(key: key, data: data);
  } catch (e) {
    print(e);
  }
}

initpathcomm() async {
  var externalDirectoryPath = await getExternalStorageDirectory();
  externalDirectoryPath!.path.toString();
}

void showImagesDialog(BuildContext context, String image, String text, ontap) {
  showDialog(
      barrierColor: AppTheme.primarySwatch.shade400,
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          insetAnimationDuration: Duration(seconds: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 180,
            width: 300,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.primaryColor, width: 4),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Image.asset(
                            image,
                            height: 100,
                            width: 100,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 3,
                          child: Text(
                            text,
                            style: AppTheme.textTheme.displaySmall,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                          )),
                    ]),
                SizedBox(
                  height: 15,
                ),
                CustomButton(
                  ontap: () {
                    ontap();
                  },
                  text: 'حسناً',
                )
              ],
            ),
          ),
        );
      });
}

void showImagesDialogWithStar(
    BuildContext context, String image, String text, ontap, int stars) {
  showDialog(
      barrierColor: AppTheme.primarySwatch.shade400,
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          insetAnimationDuration: Duration(seconds: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 250,
            width: 340,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.primaryColor, width: 4),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Image.asset(
                            image,
                            height: 100,
                            width: 100,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 3,
                          child: Text(
                            text,
                            style: AppTheme.textTheme.displaySmall,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                          )),
                    ]),
                stars == 1
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Assets.images.start.path,
                            width: 40,
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Image.asset(Assets.images.emptyStar.path,
                                width: 40, height: 40),
                          ),
                          Image.asset(Assets.images.emptyStar.path,
                              width: 40, height: 40),
                        ],
                      )
                    : stars == 2
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(Assets.images.start.path,
                                  width: 40, height: 40),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Image.asset(Assets.images.start.path,
                                    width: 40, height: 40),
                              ),
                              Image.asset(Assets.images.emptyStar.path,
                                  width: 40, height: 40),
                            ],
                          )
                        : stars == 0
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(Assets.images.emptyStar.path,
                                      width: 40, height: 40),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: Image.asset(
                                        Assets.images.emptyStar.path,
                                        width: 40,
                                        height: 40),
                                  ),
                                  Image.asset(Assets.images.emptyStar.path,
                                      width: 40, height: 40),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(Assets.images.start.path,
                                      width: 40, height: 40),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: Image.asset(Assets.images.start.path,
                                        width: 40, height: 40),
                                  ),
                                  Image.asset(Assets.images.start.path,
                                      width: 40, height: 40),
                                ],
                              ),
                CustomButton(
                  ontap: () {
                    ontap();
                  },
                  text: 'نعم',
                )
              ],
            ),
          ),
        );
      });
}

showImagesDialogWithCancleButten(
    BuildContext context2, String image, String text, No_methoed, Ok_methoed) {
  showDialog(
      context: context2,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 50,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          insetAnimationDuration: Duration(seconds: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 180,
            width: 300,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.primaryColor, width: 4),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Image.asset(
                            image,
                            height: 100,
                            width: 100,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 3,
                          child: Text(
                            text,
                            style: AppTheme.textTheme.displaySmall,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                          )),
                    ]),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SecondaryCustomButton(
                      ontap: () {
                        Ok_methoed();
                      },
                      text: 'نعم',
                    ),
                    CustomButton(
                      ontap: () {
                        No_methoed();
                      },
                      text: 'لا',
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}

showImagesDialogWithDoNotWill(BuildContext context2, String image, String text,
    String readed_text, org_text) {
  showDialog(
      context: context2,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            elevation: 50,
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            insetAnimationDuration: Duration(seconds: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 250,
              width: 350,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.primaryColor, width: 4),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Image.asset(
                              image,
                              height: 100,
                              width: 100,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 3,
                            child: Text(
                              text,
                              style: AppTheme.textTheme.displaySmall,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center,
                            )),
                      ]),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_rounded,
                          color: Colors.green, size: 30),
                      Text(
                        org_text,
                        style: AppTheme.textTheme.displaySmall,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cancel, color: Colors.red, size: 30),
                      Text(
                        readed_text,
                        style: AppTheme.textTheme.displaySmall,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SecondaryCustomButton(
                    ontap: () {
                      Navigator.pop(context);
                    },
                    text: 'نعم',
                  )
                ],
              ),
            ),
          ),
        );
      });
}

showConfetti(context2, controler, image) {
  showDialog(
      context: context2,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          insetAnimationDuration: Duration(seconds: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 250,
            width: 350,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.primaryColor, width: 4),
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
                            Text('!!!!! مبروك ',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: AppTheme.fontFamily,
                                    color: AppTheme.primaryColor)),
                            Text(
                              'لقد اتممت ',
                              style: AppTheme.textTheme.displaySmall,
                            ),
                            Text(
                              ' القصه بنجاح',
                              style: AppTheme.textTheme.displaySmall,
                            ),
                          ],
                        ),
                        ConfettiWidget(
                          confettiController: controler,
                          shouldLoop: true,
                          numberOfParticles: 20,
                          colors: [
                            AppTheme.primaryColor,
                            AppTheme.primarySwatch.shade500,
                            Color(0xFFFFAA3B)
                          ],
                        ),
                        Image.asset(image,
                            width: 190, height: 190, fit: BoxFit.contain),
                      ],
                    ),
                    SecondaryCustomButton(
                      ontap: () {
                        Navigator.push(
                            context, CustomPageRoute(child: HomePage()));
                      },
                      text: 'نعم',
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

noInternt(context2, String text) {
  showDialog(
      context: context2,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 50,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          insetAnimationDuration: Duration(seconds: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
              height: 120,
              width: 70,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.primaryColor, width: 4),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.signal_wifi_connected_no_internet_4_sharp,
                    color: AppTheme.primaryColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    text,
                    style: AppTheme.textTheme.displaySmall,
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
        );
      });
}

loadingApp(String text) {
  return Center(
    child: Dialog(
      shadowColor: Colors.white,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      insetAnimationDuration: Duration(seconds: 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
          height: 120,
          width: 70,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: AppTheme.primaryColor, width: 4),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: AppTheme.textTheme.displaySmall,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
              ),
            ],
          )),
    ),
  );
}

showSnackBar(
    {required BuildContext context,
    required title,
    Color bkColor = Colors.red,
    Function? callBackFunction}) {
  final snackBar = SnackBar(
    content: PrimaryText(text: title, fontSize: 15, textColor: Colors.white),
    backgroundColor: bkColor,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);

  Future.delayed(Duration(seconds: 2), () {
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

Future<String> getpath() async {
  var externalDirectoryPath = await getExternalStorageDirectory();
  return externalDirectoryPath!.path.toString();
}
