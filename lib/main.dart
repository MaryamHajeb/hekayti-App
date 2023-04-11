import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hikayati_app/core/app_theme.dart';
import 'package:hikayati_app/features/Story/date/model/MeadiaModel.dart';
import 'package:hikayati_app/injection_container.dart' as object;

import 'core/util/database_helper.dart';
import 'features/Home/presintation/page/HomePage.dart';
import 'features/Regestrion/date/model/userMode.dart';
import 'features/Regestrion/presintation/page/SignupPage.dart';
import 'features/Story/date/model/StoryMode.dart';
import 'features/introdection/presintation/page/IntroScreen.dart';
import 'features/introdection/presintation/page/onboardingOne.dart';

void main() async{

  void test() async {
    DatabaseHelper db = new DatabaseHelper();

 // List dd= await db.getAllSliedForStory('meadia', 'story_id = 1');
 // print(dd.toString());
 //
 //    for (int i = 0; i < dd.length; i++) {
 //      MeadiaModel user = MeadiaModel.fromJson(dd[i]);
 //      print('ID: ${user.id} - username: ${user.text} - city: ${user.photo}');
 //    }

// int dd=await  db.inserStory(MeadiaModel(story_id: '1', photo: 'aallala', sound: 'xaxa', text: 'text', page_no: 3)) ;
//   print(dd.toString());
//
//
//     var res = await db.getAllstory();
//     for (int i = 0; i < res.length; i++) {
//       StoryModel user = StoryModel.fromJson(res[i]);
//       print('ID: ${user.id} - username: ${user.name} - city: ${user.level}');
//     }
    // List myUsers = await db.getAllstory();
    // for(int i =0 ; i < myUsers!.length;i++){
    //   MeadiaModel user = MeadiaModel.fromJson(myUsers[i]);
    //   print('ID: ${user.id} - page_no: ${user.page_no} - text: ${user.text}');
    //
    // }

    //
    // int? res = await db.inserStory(MeadiaModel(
    //     story_id: '1',
    //     id: '14',
    //     photo: 'photo',
    //     sound: 'sound',
    //     text: 'text',
    //     page_no: '3'));
    // print(res);


  }



  WidgetsFlutterBinding.ensureInitialized();
  await object.init();
  await SystemChrome.setPreferredOrientations(
    [
     DeviceOrientation.landscapeLeft,
      //DeviceOrientation.landscapeRight,
    ]
  );
  test();
//
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: HomePage(),
    );
  }

}

