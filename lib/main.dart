import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hikayati_app/core/app_theme.dart';
import 'package:hikayati_app/features/Home/data/model/WebStoryMode.dart';
import 'package:hikayati_app/features/Settings/presintation/page/SettingPage.dart';
import 'package:hikayati_app/features/Story/date/model/StoryMediaModel.dart';
import 'package:hikayati_app/features/Story/date/model/accuracyModel.dart';
import 'package:hikayati_app/injection_container.dart' as object;
import 'package:hikayati_app/core/util/Encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flame_audio/flame_audio.dart';
import 'core/util/common.dart';
import 'core/util/database_helper.dart';
import 'dataProviders/network/Network_info.dart';
import 'dataProviders/network/data_source_url.dart';
import 'dataProviders/remote_data_provider.dart';
import 'features/Home/presintation/page/HomePage.dart';
import 'features/Regestrion/date/model/userMode.dart';
import 'features/Regestrion/presintation/page/SignupPage.dart';
import 'features/Home/data/model/StoryMode.dart';
import 'features/Settings/presintation/page/lockPage.dart';
import 'features/introdection/presintation/page/IntroScreen.dart';
import 'features/introdection/presintation/page/Splach_screen.dart';
import 'features/introdection/presintation/page/onboardingOne.dart';
import 'package:flame_audio/flame_audio.dart';
import 'injection_container.dart';
DatabaseHelper db = new DatabaseHelper();
 NetworkInfo networkInfo =NetworkInfoImpl(sl());
String carecters='';
bool islogin=false;
int idfrochart=0;
bool isChart=true;
List<dynamic> listCopmletion=[];
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  FlameAudio.bgm.initialize();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );

  final prefs = await SharedPreferences.getInstance();
  islogin=await prefs.getBool('onbording')??false;
 carecters= await  prefs.getString('Carecters') ?? '';
//  await db.intDB();



  await object.init();
  await SystemChrome.setPreferredOrientations(
    [
     DeviceOrientation.landscapeLeft,
    //  DeviceOrientation.landscapeRight,
    ]
  );


  runApp( MyApp());
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
      home:Splach_screen()

      //islogin ? HomePage():IntroScreen(),
    );
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
//internet();
//
    ReceivePort _port = ReceivePort();

  CachedDate('UserInformation',UserModel(user_name: null, email: null, level: null, character: null, update_at: DateTime.now().toString(), password: null, id: null));


//
//
//
//      var dd=db.insert(data:WebStoryModel(id: 1, cover_photo: '1_1_sc.jpg', story_order: 'story_order', updated_at: '2023-06-02T06:12:00.000000Z', author: 'author', level: '1', required_stars: '2', name: 'STORY1'), tableName: '"stories" ');
//      var dd1=db.insert(data:WebStoryModel(id: 3, cover_photo: '1_2_sc.jpg', story_order: 'story_order', updated_at: '2023-06-04T06:10:04.000000Z', author: 'author', level: '1', required_stars: '5', name: 'STORY2'), tableName: '"stories" ');
//     var dd2=db.insert(data:WebStoryModel(id: 2, cover_photo: '1_3_sc.jpg', story_order: 'story_order', updated_at: '2023-06-04T06:10:04.000000Z', author: 'author', level: '1', required_stars: '7', name: 'STORY3'), tableName: '"stories" ');
//     var dd3=db.insert(data:WebStoryModel(id: 4, cover_photo: '1_4_sc.jpg', story_order: 'story_order', updated_at: '2023-06-04T06:10:04.000000Z', author: 'author', level: '1', required_stars: '4', name: 'STORY4'), tableName: '"stories" ');
//
//
//
// db.insert(data: StoryMediaModel(story_id: '1' , photo: 'photo', sound: 'sound', text: 'سار احمد الى المدرسه', updated_at: 'updated_at', page_no: '1'), tableName: 'stories_media');
// db.insert(data: StoryMediaModel(story_id: '1' , photo: 'photo', sound: 'sound', text: 'اسامه حاضر', updated_at: 'updated_at', page_no: '2'), tableName: 'stories_media');
// db.insert(data: StoryMediaModel(story_id: '1' , photo: 'photo', sound: 'sound', text: 'هشام يشتغل ', updated_at: 'updated_at', page_no: '3'), tableName: 'stories_media');
// db.insert(data: StoryMediaModel(story_id: '1' , photo: 'photo', sound: 'sound', text: 'الحرازي ماشاء الله عليه كمل العمل حقه', updated_at: 'updated_at', page_no: '4'), tableName: 'stories_media');
// db.insert(data: StoryMediaModel(story_id: '1' , photo: 'photo', sound: 'sound', text: 'محمد راقد', updated_at: 'updated_at', page_no: '5'), tableName: 'stories_media');
//
// db.insert(data: accuracyModel(media_id: '1', readed_text: 'سار احمد الى المدرسه اليوم', accuracy_stars:'3', updated_at: "2022"), tableName: 'accuracy');
// db.insert(data: accuracyModel(media_id: '2', readed_text: '1سار احمد الى المدرسه اليوم', accuracy_stars:'2', updated_at: "2022"), tableName: 'accuracy');
// db.insert(data: accuracyModel(media_id: '3', readed_text: 'سار احمد الى المدرسه اليوم2', accuracy_stars:'3', updated_at: "2022"), tableName: 'accuracy');
// db.insert(data: accuracyModel(media_id: '4', readed_text: 'سار احمد الى المدرسه اليوم3', accuracy_stars:'1', updated_at: "2022"), tableName: 'accuracy');
// db.insert(data: accuracyModel(media_id: '5', readed_text: 'سار احمد الى المدرسه اليوم4', accuracy_stars:'1', updated_at: "2022"), tableName: 'accuracy');
//
//
// db.insert(data: {
//   'id':1,
//   'stars':'2',
//   'story_id':'1',
//   'updated_at':'2:22',
//   'percentage':'80'
//
// }, tableName: 'completion');
// db.insert(data: {
//   'id':2,
//   'stars':'3',
//   'story_id':'2',
//   'updated_at':'2:22',
//   'percentage':'100'

//
// }, tableName: 'completion');

// db.insert(data: {
//   'id':3,
//   'stars':'2',
//   'story_id':'1',
//   'updated_at':'2:22',
//   'percentage':'80'
//
// }, tableName: 'completion');
// db.insert(data: {
//   'id':4,
//   'stars':'3',
//   'story_id':'4',
//   'updated_at':'2:22',
//   'percentage':'80'
//
// }, tableName: 'completion');
//

  // var dd=  RemoteDataProvider(client: sl()).sendData(url: DataSourceURL.login, body: {
  //    'email':'abdu22@gmail.com',
  //    'password':'123456',
  //
  // }, retrievedDataType: String);





  // print(dd);
  // FlameAudio.bgm.play('bgm.mp3',volume: 100);
 //  db.initApp('2', '1');
//  ReceivePort _port = ReceivePort();
//    db.downloadStoriesCover();
//   FlutterDownloader.registerCallback(downloadCallback, step: 1);
//
//
//
//   IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
//   _port.listen((dynamic data) {
//     String id = data[0];
//     print(id);
//     DownloadTaskStatus status = DownloadTaskStatus(data[1]);
//     int progress = data[2];
//     print(status);
//     setState((){ });
//   });
//
//
//   }
//
// static  void downloadCallback(String id, int status, int progress) {
//     final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
//     print(progress);
//     print('progress');
//     print(status);
//
//     send!.send([id, status, progress]);
//   }
//
//   void dispose() {
//     IsolateNameServer.removePortNameMapping('downloader_send_port');
//     super.dispose();
//     }
//
//
//
//   internet()async{
//     await networkInfo.isConnected ?print('internt'):print('notinternt');
//   }

 // CachedDate('level','1');

 // db.initApp('1');




}

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    FlameAudio.bgm.pause();
  }


}

