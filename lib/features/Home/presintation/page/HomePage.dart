import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikayati_app/core/AppTheme.dart';
import 'package:hikayati_app/features/Home/presintation/manager/Story_bloc.dart';
import 'package:hikayati_app/features/Regestrion/date/model/userMode.dart';
import 'package:hikayati_app/features/Home/data/model/StoryMode.dart';
import 'package:hikayati_app/features/Settings/presintation/page/LockPage.dart';
import 'package:hikayati_app/main.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../core/util/CharactersList.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/util/Common.dart';
import '../../../../core/widgets/CustomFieldForSearch.dart';
import '../../../../core/widgets/CustomIconWidget.dart';
import '../../../../core/widgets/CustomIconWidget2.dart';
import '../../../../core/widgets/CustomMusicIcon.dart';
import '../../../../core/widgets/CustomPageRoute.dart';
import '../../../../core/widgets/TutorialWidget.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../injection_container.dart';
import '../../../Story/presintation/page/StoryPage.dart';

import '../Widget/DownloadWidget.dart';
import '../Widget/SearchWidget.dart';
import '../Widget/StarsWidget.dart';
import '../Widget/StoryCard.dart';
import '../Widget/StoryCardLock.dart';

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
  CharactersList CharactersListobj = CharactersList();
  int? collected_stars = 0;
  int all_stars = 0;
  int stars = 0;
  bool tautorial = false;
  List<TargetFocus> targets = [];
  bool bgm = false;
  UserModel? userModel;
  SharedPreferences? prefs;
  int progress = 0;
  var statusProgrress;
  bool isloading = false;
  double star_progrees = 0;
  TutorialCoachMark? tutorialCoachMark;
  GlobalKey keyone = GlobalKey();
  GlobalKey keytwo = GlobalKey();
  GlobalKey keythree = GlobalKey();
  GlobalKey keyfive = GlobalKey();
  GlobalKey keyfour = GlobalKey();
  GlobalKey keyseven = GlobalKey();
  GlobalKey keysix = GlobalKey();

  Widget build(BuildContext context) {
    screenUtil.init(context);

    return WillPopScope(
      onWillPop: () async {
        final value = await showImagesDialogWithCancleButten(
            context,
            '${CharactersListobj.confusedListCharactersList[int.parse(userModel!.character.toString())]['image']}',
            '  هل حقا تريد المغادره ؟', () {
          Navigator.pop(context);
        }, () {
          SystemNavigator.pop();
        });

        if (value != null) {
          return Future.value(value);
        } else {
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
              child: BlocProvider(
                create: (context) => sl<StoryBloc>(),
                child: BlocConsumer<StoryBloc, StoryState>(
                  listener: (_context, state) async {
                    if (state is StoryError) {
                      print(state.errorMessage);
                    }
                    if (state is StoryInitial) {}
                  },
                  builder: (_context, state) {
                    if (state is StoryInitial) {
                      BlocProvider.of<StoryBloc>(_context)
                          .add(GetAllStory(userModel!.level.toString()));

                      // db.syncApp(userModel!.level.toString());
                    }
                    if (state is StoryLoading) {
                      return Center(
                          child: loadingApp('جاري تجهيز القصص .....  '));
                    }

                    if (state is StoryILoaded) {
                      //TODO::Show Story here

                      listStory.clear();
                      state.storyModel.forEach((element) {
                        listStory.add(element!);
                      });

                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        getStars();
                        showTutorial();
                      });
                      return SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: screenUtil.screenHeight * .03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: AppTheme.primaryColor,
                                            width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: CustomIconWidget(
                                      status: true,
                                      primaryColor: Colors.white,
                                      secondaryColor: Colors.white,
                                      primaryIcon: Image.asset(
                                          '${CharactersListobj.showCharactersList[int.parse(userModel!.character.toString())]['image'] ?? 0}',
                                          fit: BoxFit.cover),
                                      key: keyfour,
                                      secondaryIcon: Image.asset(
                                          '${CharactersListobj.showCharactersList[int.parse(userModel!.character.toString())]['image'] ?? 0}',
                                          fit: BoxFit.cover),
                                      onTap: () async {
                                        Navigator.push(context,
                                            CustomPageRoute(child: LockPage()));
                                      },
                                    ),
                                  ),
                                  StarsWidget(
                                    all_stars: all_stars,
                                    keythree: keythree,
                                    star_progrees: star_progrees,
                                    stars: stars,
                                  ),
                                  SearchWidget(
                                    keyTwo: keytwo,
                                    controller: search,
                                    onSearch: (value) {
                                      onSearch(value);
                                    },
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: AppTheme.primaryColor,
                                            width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18))),
                                    child: CustomMusicIcon(
                                      key: keyone,
                                      onTap: () {
                                        if (bgm) {
                                          setState(() {
                                            FlameAudio.bgm.stop();
                                            bgm = !bgm;
                                            cachedData(key: "bgm", data: bgm);
                                          });
                                        } else {
                                          setState(() {
                                            bgm = !bgm;
                                            FlameAudio.bgm
                                                .play('bgm.mp3', volume: 100);
                                            cachedData(key: "bgm", data: bgm);
                                          });
                                        }
                                      },
                                      status: bgm,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: screenUtil.screenHeight * .03,
                              ),
                              Container(
                                height: screenUtil.screenHeight * .8,
                                child: listStoryWithSearch.length > 0
                                    ? GridView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                screenUtil.screenWidth * .01,
                                            vertical:
                                                screenUtil.screenHeight * .05),
                                        itemCount: listStoryWithSearch.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                childAspectRatio: 15 / 14,
                                                crossAxisSpacing:
                                                    screenUtil.screenWidth *
                                                        .015,
                                                mainAxisSpacing:
                                                    screenUtil.screenHeight *
                                                        .15),
                                        itemBuilder: (context, index) {
                                          return listStoryWithSearch[index]
                                                      .required_stars >
                                                  collected_stars
                                              ? InkWell(
                                                  onTap: () {
                                                    showImagesDialog(
                                                        context,
                                                        '${CharactersListobj.showCharactersList[int.parse(userModel!.character.toString())]['image']}',
                                                        'احصل على المزيد من النجوم من اجل فتح هذه القصه',
                                                        () {
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: StoryCardLock(
                                                    name: listStoryWithSearch[
                                                            index]
                                                        .name,
                                                    starts: int.parse(
                                                        listStoryWithSearch[
                                                                index]
                                                            .stars),
                                                    photo: path +
                                                        '/' +
                                                        listStoryWithSearch[
                                                                index]
                                                            .cover_photo
                                                            .toString(),
                                                  ))
                                              : listStoryWithSearch[index]
                                                          .download ==
                                                      0
                                                  ? DownloadWidget(
                                                      userModel: userModel,
                                                      onTap: () async {
                                                        setState(() =>
                                                            isloading = true);
                                                        showDialog(
                                                          barrierDismissible:
                                                              false,
                                                          context: context,
                                                          builder: (context) {
                                                            return Center(
                                                              child: Dialog(
                                                                surfaceTintColor:
                                                                    Colors
                                                                        .white,
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                shadowColor:
                                                                    AppTheme
                                                                        .primaryColor,
                                                                elevation: 50,
                                                                insetAnimationDuration:
                                                                    Duration(
                                                                        seconds:
                                                                            30),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0),
                                                                ),
                                                                child:
                                                                    Container(
                                                                        height:
                                                                            120,
                                                                        width:
                                                                            70,
                                                                        margin:
                                                                            EdgeInsets.all(
                                                                                5),
                                                                        decoration: BoxDecoration(
                                                                            border: Border.all(
                                                                                color: AppTheme
                                                                                    .primaryColor,
                                                                                width:
                                                                                    4),
                                                                            borderRadius: BorderRadius.circular(
                                                                                20)),
                                                                        child: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            children: [
                                                                              Lottie.asset(
                                                                                "assets/json/animation_download.json",
                                                                                width: 100,
                                                                              ),
                                                                              Text(
                                                                                'جاري تحميل القصه ',
                                                                                style: TextStyle(color: AppTheme.primaryColor, fontSize: 15, fontFamily: AppTheme.fontFamily),
                                                                              )
                                                                            ])),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                        Navigator.pop(context);
                                                        await db.downloadMedia(
                                                            state
                                                                .storyModel[
                                                                    index]!
                                                                .id
                                                                .toString());

                                                        setState(() =>
                                                            isloading = false);

                                                        BlocProvider.of<
                                                                    StoryBloc>(
                                                                _context)
                                                            .add(GetAllStory(
                                                                userModel!.level
                                                                    .toString()));
                                                      },
                                                      imagePath:
                                                          listStoryWithSearch[
                                                                  index]
                                                              .cover_photo
                                                              .toString(),
                                                      name: listStoryWithSearch[
                                                              index]
                                                          .name
                                                          .toString(),
                                                      stars: int.parse(
                                                          listStoryWithSearch[
                                                                  index]
                                                              .stars),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        //  showImagesDialog(context,'${CharactersListobj.FaceCharactersList[CharactersList_id]['image']}' , 'تاكد من وجود انترنت من اجل تنزيل هذه القصه ');

                                                        Navigator.push(
                                                            context,
                                                            CustomPageRoute(
                                                                child:
                                                                    StoryPage(
                                                              id: listStoryWithSearch[
                                                                      index]
                                                                  .id,
                                                            )));

                                                        FlameAudio.bgm.pause();
                                                      },
                                                      child: StoryCard(
                                                        key: tautorial
                                                            ? null
                                                            : keyfive,
                                                        name:
                                                            listStoryWithSearch[
                                                                    index]
                                                                .name,
                                                        starts: int.parse(
                                                            listStoryWithSearch[
                                                                    index]
                                                                .stars),
                                                        photo: path +
                                                            '/' +
                                                            listStoryWithSearch[
                                                                    index]
                                                                .cover_photo
                                                                .toString(),
                                                      ));
                                        },
                                      )
                                    : Center(
                                        child: Text(
                                        'القائمه فارغه',
                                        style: AppTheme.textTheme.displayMedium,
                                      )),
                              )
                            ]),
                      );
                    }

                    return Container();
                  },
                ),
              )),
        ),
      ),
    );
  }

  onSearch(String searchWord) {
    listStoryWithSearch = listStory
        .where((element) =>
            element.name.toLowerCase().contains(searchWord.toLowerCase()))
        .toList();

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUser();
    initTutorial();
    listStoryWithSearch = listStory;
    getStars();
  }

  initTutorial() async {
    prefs = await SharedPreferences.getInstance();
    tautorial = await prefs?.getBool("tautorial") ?? false;
  }

  showTutorial() async {
    targets = [
      TargetFocus(identify: "target1", keyTarget: keyone, contents: [
        TargetContent(
            align: ContentAlign.right,
            child: TutorialWidget(
              index: 1,
              onTap: () {
                tutorialCoachMark!.next();
              },
              text: "مرحبا  " +
                  userModel!.user_name.toString() +
                  " , " +
                  "   يمكنك  تشغيل  و ايقاف  صوت  الموسيقى  من  هذا  الزر ",
              Characters: int.parse(userModel!.character.toString()) ?? 0,
            ))
      ]),
      TargetFocus(identify: "target2", keyTarget: keytwo, contents: [
        TargetContent(
            align: ContentAlign.left,
            child: TutorialWidget(
              index: 2,
              onTap: () {
                tutorialCoachMark!.next();
              },
              text: "يمكنك  البحث  عن  القصة  من  خلال  كتابة  اسمها  هنا",
              Characters: int.parse(userModel!.character.toString()) ?? 0,
            ))
      ]),
      TargetFocus(identify: "target3", keyTarget: keythree, contents: [
        TargetContent(
            align: ContentAlign.left,
            child: TutorialWidget(
              index: 3,
              onTap: () {
                tutorialCoachMark!.next();
              },
              text: " يمكنك  معرفة  عدد  النجوم  التي  حصلت  عليها ",
              Characters: int.parse(userModel!.character.toString()) ?? 0,
            ))
      ]),
      TargetFocus(identify: "target4", keyTarget: keyfour, contents: [
        TargetContent(
            align: ContentAlign.left,
            child: TutorialWidget(
              index: 4,
              onTap: () {
                tutorialCoachMark!.next();
              },
              text:
                  "يمكنك  تغيير  الاعداد  الخاصة  بك  من  هذا  الزر  ولكن  بحضور  احد  الوالدين ",
              Characters: int.parse(userModel!.character.toString()) ?? 0,
            ))
      ]),
      TargetFocus(identify: "target5", keyTarget: keyfive, contents: [
        TargetContent(
            align: ContentAlign.left,
            child: TutorialWidget(
              index: 5,
              onTap: () {
                tutorialCoachMark!.next();
              },
              text: "يمكنك  استعراض  القصة  من  هنا ",
              Characters: int.parse(userModel!.character.toString()) ?? 0,
            ))
      ]),
    ];
    prefs = await SharedPreferences.getInstance();
    tautorial = await prefs?.getBool("tautorial") ?? false;

    print("object");
    print(tautorial);
    print("object");
    if (tautorial == false) {
      tutorialCoachMark = TutorialCoachMark(
          hideSkip: true,
          targets: targets,
          onFinish: () async {
            prefs = await SharedPreferences.getInstance();
            prefs!.setBool("tautorial", true);
            getStars();
            setState(() {});
          });
      tutorialCoachMark!.show(context: context);
    }
  }

  initUser() async {
    userModel = await getCachedData(
      key: 'UserInformation',
      retrievedDataType: UserModel.init(),
      returnType: UserModel,
    );
    setState(() {});
    print("userModel.level");
    print(userModel!.level);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    BlocProvider.of<StoryBloc>(context).close();
  }

  getStars() async {
    collected_stars = await getCachedData(
            key: 'collected_stars', retrievedDataType: int, returnType: int) ??
        0;
    all_stars = await getCachedData(
            key: 'all_stars', retrievedDataType: int, returnType: int) ??
        0;

    if (collected_stars == 0 || all_stars == 0) {
      star_progrees = 0;
    } else {
      star_progrees = (collected_stars! / all_stars);
    }
  }
}
