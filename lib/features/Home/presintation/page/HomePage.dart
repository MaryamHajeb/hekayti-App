import 'dart:isolate';
import 'dart:ui';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hikayati_app/core/app_theme.dart';
import 'package:hikayati_app/features/Home/presintation/manager/Story_bloc.dart';
import 'package:hikayati_app/features/Settings/presintation/page/SettingPage.dart';
import 'package:hikayati_app/features/Home/data/model/StoryMode.dart';
import 'package:hikayati_app/features/Settings/presintation/page/lockPage.dart';
import 'package:hikayati_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/util/Carecters.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/util/common.dart';
import '../../../../core/util/database_helper.dart';
import '../../../../core/widgets/CastemInput.dart';
import '../../../../core/widgets/CastemInputForSearch.dart';
import '../../../../core/widgets/CustemIcon.dart';
import '../../../../core/widgets/CustemIcon2.dart';
import '../../../../core/widgets/CustomPageRoute.dart';
import '../../../../core/widgets/PlayButton.dart';
import '../../../../dataProviders/network/data_source_url.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../injection_container.dart';
import '../../../Regestrion/presintation/page/LoginPage.dart';
import '../../../Story/date/model/StoryMediaModel.dart';
import '../../../Story/presintation/page/StoryPage.dart';
import '../Widget/StoryCard.dart';
import '../Widget/StoryCardLock.dart';
import '../Widget/StoryCardNotDownloded.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget StoryWidget = Center();
  ScreenUtil screenUtil = ScreenUtil();
  TextEditingController search = TextEditingController();
  List<StoryModel> listStory = [];
  List<StoryModel> listStory2 = [];
  List<StoryModel> listStoryWithSearch = [];
  Carecters carectersobj =Carecters();
  int collected_stars=0;
  int level=0;
  int all_stars=0;
  int stars=0;
  bool bgm=false;
  bool islistToStory=true;
  final prefs = SharedPreferences.getInstance();
  int  Carecters_id=0;
  int progress=0;
  var path;
  ReceivePort _port = ReceivePort();
   double star_progrees = 0;
  Widget build(BuildContext context) {
    screenUtil.init(context);

    return WillPopScope(
      onWillPop: ()async{
        final value =await  showImagesDialogWithCancleButten(context, '${carectersobj.confusedListCarecters[Carecters_id]['image']}', 'هل حقا تريد المغادره',(){
          Navigator.pop(context);
        },(){
          SystemNavigator.pop();
        });

        if(value!=null){
          return Future.value(value);
        }
        else{
          return Future.value(false);
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Container(
        height: screenUtil.screenHeight * 1,
        width: screenUtil.screenWidth * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/backgraond.png'),
                fit: BoxFit.fill)),
        child:BlocProvider(
          create: (context) =>sl<StoryBloc>(),
          child: BlocConsumer<StoryBloc, StoryState>(
            listener: (_context, state) {
              if (state is StoryError) {
                print(state.errorMessage);
              }
            },
            builder: (_context, state) {
              if (state is StoryInitial) {
                BlocProvider.of<StoryBloc>(_context).add(GetAllStory(level.toString()));
              }

              if (state is StoryLoading) {
                StoryWidget =  Center(child: initApp('جاري تجهيز القصص  '));
              }

              if (state is StoryILoaded) {
                //TODO::Show Story here
                listStory.clear();
                state.storyModel.forEach((element) {
                  listStory.add(element!);
                });


                StoryWidget =  SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: CustemIcon2(
                                icon: Image.asset('${carectersobj.showCarecters[Carecters_id]['image'] ?? 0}', fit: BoxFit.cover),
                                ontap: () {
                                  Navigator.push(
                                      context, CustomPageRoute(child: lockPage()));

                                },
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: AppTheme.primarySwatch.shade600,
                                        width: 2),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                width: screenUtil.screenWidth * .2,
                                height: screenUtil.screenHeight * .1,
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    SizedBox(height: 30,),
                                    LinearProgressIndicator(backgroundColor: Colors.transparent,color: Colors.transparent,valueColor: AlwaysStoppedAnimation(AppTheme.primarySwatch.shade600),minHeight: 38,value: star_progrees ,),
                                    Row(
                                      children: [
                                        SizedBox(width: 30,),

                                        Image.asset(Assets.images.start.path,width: 30,height: 30,),
                                        SizedBox(width: 20,),

                                        Text('${ getCachedDate('collected_stars',String)}/${getCachedDate('all_stars',String)}',style: AppTheme.textTheme.headline3,),

                                      ],
                                    )
                                  ],
                                )),
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppTheme.primarySwatch.shade600,
                                        width: 2),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(10))),
                                width: screenUtil.screenWidth * .4,
                                height: screenUtil.screenHeight * .1,
                                child: CastemInputForSearch(
                                  onching: (value) => onScearch(value),
                                  valdution: (value) {},
                                  icon: Icon(Icons.search),
                                  text: 'بحث',
                                  controler: search,
                                  size: 340,
                                )),
                            bgm ==false?
                            CustemIcon2(
                                icon: Icon(Icons.volume_up_rounded,
                                  color: AppTheme.primaryColor,),
                                ontap: () async {
                                  setState(() {

                                    FlameAudio.bgm.stop();
                                    bgm=!bgm;
                                    CachedDate('bgm',bgm);


                                  });
                                }):CustemIcon2(
                                icon: Icon(Icons.volume_off,
                                    color: AppTheme.primaryColor),
                                ontap: () async {
                                  setState(() {
                                    bgm=!bgm;
                                    FlameAudio.bgm.play('bgm.mp3',volume: 100);
                                    CachedDate('bgm',bgm);
                                  });
                                }),

                          ],
                        ),
                        SizedBox(height: 10),

                    Container(
                      height: screenUtil.screenHeight * .8,
                      width: double.infinity,
                      child: listStoryWithSearch.length > 0
                          ? GridView.builder(
                        shrinkWrap: true,
                        itemCount: listStoryWithSearch.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 20

                        ),
                        itemBuilder: (context, index) {

                          print(listStoryWithSearch[index].stars);
                          print('sttttt');
                          return

                            listStoryWithSearch[index]!.required_stars > collected_stars   ?
                            InkWell(
                                onTap: () {

                                  showImagesDialog(context,'${carectersobj.showCarecters[Carecters_id]['image']}' , 'احصل علئ المزيد من النجوم من اجل فتح هذه القصه',(){Navigator.pop(context);}  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top:15.0),
                                  child: StoryCardLock(

                                    name: listStoryWithSearch[index]?.name,
                                    starts: int.parse(listStoryWithSearch[index]?.stars),
                                    photo: path +'/'+ listStoryWithSearch[index]!.cover_photo
                                        .toString(),
                                  ),
                                )): listStoryWithSearch[index]!.download ==0 ?
                            InkWell(
                                onTap: () async{
                                  if(await networkInfo.isConnected){
                                    showImagesDialog(context,'${carectersobj.FaceCarecters[Carecters_id]['image']}' , 'اظغط على زر التنزيل من اجل تحميل هذة القصه',(){ Navigator.pop(context);});

                                  }
                                  else {
                                    showImagesDialog(context, '${carectersobj
                                        .FaceCarecters[Carecters_id]['image']}',
                                        'تاكد من وجود انترنت من اجل تنزيل هذه القصه ', () {
                                          Navigator.pop(context);
                                        });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top:15.0),
                                  child: StoryCardNotDownloded(
                                    id: listStoryWithSearch[index].id.toString(),
                                    progress: progress,
                                    name: listStoryWithSearch[index]?.name,
                                    starts: int.parse(listStoryWithSearch[index]?.stars),
                                    photo: path +'/'+ listStoryWithSearch[index]!.cover_photo
                                        .toString(),
                                  ),
                                )):

                            InkWell(
                                onTap: () {
                                  //  showImagesDialog(context,'${carectersobj.FaceCarecters[Carecters_id]['image']}' , 'تاكد من وجود انترنت من اجل تنزيل هذه القصه ');

                                  Navigator.push(
                                      context,
                                      CustomPageRoute(
                                          child: StoryPage(id:listStoryWithSearch[index]?.id ,))

                                  );

                                  FlameAudio.bgm.pause();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top:15.0),
                                  child: StoryCard(
                                    name: listStoryWithSearch[index]!.name,
                                    starts: int.parse(listStoryWithSearch[index]?.stars),
                                    photo: path +'/'+ listStoryWithSearch[index]!.cover_photo.toString(),
                                  ),
                                ));
                        },
                      )
                          : Center(child: Text('القائمه فارغه',style: AppTheme.textTheme.headline2,)),
                    )
                      ]


                  ),
                );
              }

              return StoryWidget;
            },
          ),
        )
          ),
        ),
      ),
    );
  }

  onScearch(String searchWord) {


  setState(() {
    listStory.forEach((element) {
      print(element.name);
    });

    listStoryWithSearch.forEach((element) {
      print(element.name);
    });

      listStoryWithSearch = listStory.where((element) => element.name.toLowerCase().contains(searchWord.toLowerCase()))
          .toList();

      listStoryWithSearch.forEach((element) {
        print(element.name);
      });
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      // if(networkInfo.isConnected)
      //

    listStoryWithSearch = listStory;
    Carecters_id=  int.parse(getCachedDate('Carecters',String).toString());
    collected_stars= getCachedDate('collected_stars',String);
    level=int.parse(getCachedDate('level', String).toString());
    all_stars=getCachedDate('all_stars',String);

     if(collected_stars==0 || all_stars == 0){
     star_progrees = 0;
     }else{
       star_progrees = collected_stars / all_stars;
     }

     path=initpath();
     //   db.syncApp(level.toString());


    //FlutterDownloader.registerCallback(downloadCallback, step: 1);

    // IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    // _port.listen((dynamic data) {
    //   String id = data[0];
    //   DownloadTaskStatus status = DownloadTaskStatus(data[1]);
    //   setState((){
    //
    //     progress = data[2];
    //     print(progress);
    //     print('progress============================================================');
    //
    //
    //   });
    // });

    }

  //
  // static  void downloadCallback(String id, int status, int progress) {
  //   final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
  //   print(progress);
  //   print('progress');
  //   print(status);
  //
  //   send!.send([id, status, progress]);
  // }



  insertStory(state){
    state.storyModel.forEach((element) async {

      listStory.add(element!);

    });


  }



  // void dispose() {
  //   IsolateNameServer.removePortNameMapping('downloader_send_port');
  //   super.dispose();
  // }



}
