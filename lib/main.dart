import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hikayati_app/core/app_theme.dart';
import 'package:hikayati_app/injection_container.dart' as object;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flame_audio/flame_audio.dart';
import 'core/util/database_helper.dart';
import 'dataProviders/network/Network_info.dart';
import 'features/introdection/presintation/page/Splach_screen.dart';
import 'injection_container.dart';

DatabaseHelper db = new DatabaseHelper();
NetworkInfo networkInfo = NetworkInfoImpl(sl());

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
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: AppTheme.primarySwatch,
        ),
        home: Splach_screen());
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
