import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hikayati_app/core/AppTheme.dart';
import 'package:hikayati_app/injection_container.dart' as object;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flame_audio/flame_audio.dart';
import 'core/util/DataBaseHelper.dart';
import 'dataProviders/network/Network_info.dart';
import 'features/Introdection/presintation/page/SplashScreen.dart';
import 'injection_container.dart';

DataBaseHelper db = new DataBaseHelper();
NetworkInfo networkInfo = NetworkInfoImpl(sl());
String path = '';
bool islogin = false;
int idfrochart = 0;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlameAudio.bgm.initialize();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );

  final prefs = await SharedPreferences.getInstance();
  islogin = await prefs.getBool('onbording') ?? false;

  await object.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    //  DeviceOrientation.landscapeRight,
  ]);
  final Directory? dir = await getApplicationDocumentsDirectory();
  final externalDirectoryPath = '${dir!.path}';
  print(externalDirectoryPath);
  path = externalDirectoryPath.toString();
  await initEasyLoading();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          shadowColor: AppTheme.primaryColor,
          backgroundColor: AppTheme.primaryColor,
          colorSchemeSeed: AppTheme.primaryColor,
          useMaterial3: true,
        ),
        home: SplashScreen());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    FlameAudio.bgm.pause();
  }
}

initEasyLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..indicatorWidget = SpinKitWaveSpinner(
      color: AppTheme.primarySwatch.shade800,
    )
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 80.0
    ..radius = 10.0
    ..progressColor = AppTheme.primaryColor
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.black.withOpacity(0.5)
    ..maskType = EasyLoadingMaskType.black
    ..errorWidget = const Icon(
      Icons.error,
      size: 45,
      color: Colors.red,
    )
    ..animationStyle = EasyLoadingAnimationStyle.opacity
    ..infoWidget = const Icon(
      Icons.info,
      size: 45,
      color: AppTheme.primaryColor,
    )
    ..successWidget = const Icon(
      Icons.check_circle,
      size: 45,
      color: AppTheme.primaryColor,
    )
    ..dismissOnTap = false;
}
