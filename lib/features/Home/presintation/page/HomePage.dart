import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  List<StoryModel> listStoryWithSearch = [];
  List starts = [1, 2, 0, 3, 2, 3];
  Carecters carectersobj =Carecters();
  int collected_stars=0;
  int stars=0;
  bool bgm=false;
  bool islistToStory=true;
  final prefs = SharedPreferences.getInstance();
  int  Carecters_id=0;
  Widget build(BuildContext context) {
    screenUtil.init(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
      height: screenUtil.screenHeight * 1,
      width: screenUtil.screenWidth * 1,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/backgraond.png'),
              fit: BoxFit.fill)),
      child: SingleChildScrollView(
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
                      icon: Image.asset('${carectersobj.showCarecters[Carecters_id ?? 0]['image'] ?? 0}', fit: BoxFit.cover),
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
                          LinearProgressIndicator(backgroundColor: Colors.transparent,color: Colors.transparent,valueColor: AlwaysStoppedAnimation(AppTheme.primarySwatch.shade600),minHeight: 38,value: .6,),
                          Row(
                            children: [
                              SizedBox(width: 30,),

                          Image.asset('assets/images/start.png',width: 30,height: 30,),
                          SizedBox(width: 20,),
                          Text('2/24',style: AppTheme.textTheme.headline3,),

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

                       });
                      }):CustemIcon2(
                      icon: Icon(Icons.volume_off,
                          color: AppTheme.primaryColor),
                      ontap: () async {
                        setState(() {
                          bgm=!bgm;
                          // FlameAudio.bgm.play('bgm.mp3',volume: 100);

                        });
                      }),

                ],
              ),
              SizedBox(height: 10),
                BlocProvider(
                  create: (context) => sl<StoryBloc>(),
                  child: BlocConsumer<StoryBloc, StoryState>(
                    listener: (_context, state) {
                      if (state is StoryError) {
                        print(state.errorMessage);
                      }
                    },
                    builder: (_context, state) {
                      if (state is StoryInitial) {
                        BlocProvider.of<StoryBloc>(_context)
                            .add(GetAllStory(token: ''));
                      }

                      if (state is StoryLoading) {
                        StoryWidget = CircularProgressIndicator();
                      }

                      if (state is StoryILoaded) {
                        // //TODO::Show Story here

                        insertStory(state);
                        // stars=  getCachedDate('stars',String);
                        // collected_stars= getCachedDate('collected_stars',String);


                        //
                        // listStory=  listStory=state.storyModel.toList() as List<StoryModel>;


                        // print('-------block--------------------------------------');
                        // print(listStoryWithSearch.length);
                        StoryWidget = Container(
                          height: screenUtil.screenHeight * .8,
                          width: double.infinity,
                          child: listStory.length > 0
                              ? GridView.builder(
                            shrinkWrap: true,
                                  itemCount: listStory.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                         mainAxisSpacing: 20

                                      ),
                                  itemBuilder: (context, index) {
                                    return int.parse(listStory[index]?.stars) ==0 ?
                                    InkWell(
                                        onTap: () {
                                          showImagesDialog(context,'${carectersobj.showCarecters[Carecters_id]['image']}' , 'احصل علئ المزيد من النجوم من اجل فتح هذه القصه');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(top:15.0),
                                          child: StoryCardLock(
                                            name:
                                            listStory[index]?.name,
                                            starts: int.parse(listStory[index]?.stars),
                                            photo: listStory[index]!.cover_photo
                                                .toString(),
                                          ),
                                        )):

                                    InkWell(
                                        onTap: () {
                                          // showImagesDialog(context,'${carectersobj.FaceCarecters[Carecters_id]['image']}' , 'تاكد من وجود انترنت من اجل تنزيل هذه القصه ');

                                          Navigator.push(
                                              context,
                                              CustomPageRoute(
                                                  child: StoryPage(id:listStory[index]?.id ,)));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(top:15.0),
                                          child: StoryCard(
                                            name:
                                            listStory[index]!.name,
                                            starts: int.parse(listStory[index]?.stars),
                                            photo: listStory[index]!.cover_photo
                                                .toString(),
                                          ),
                                        ));
                                  },
                                )
                              : Center(child: Text('القائمه فارغه',style: AppTheme.textTheme.headline2,)),
                        );
                      }

                      return StoryWidget;
                    },
                  ),
                )
            ]),
      ),
        ),
      ),
    );
  }

  onScearch(String searchWord) {


    setState(() {
      listStoryWithSearch = listStoryWithSearch
          .where((element) => element.name.contains(searchWord))
          .toList();
    });


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listStoryWithSearch = listStory;
    Carecters_id=  getCachedDate('Carecters',String);




  }

  insertStory(state){
    state.storyModel.forEach((element) {
      listStory.add(element!);
    });

  }

}
