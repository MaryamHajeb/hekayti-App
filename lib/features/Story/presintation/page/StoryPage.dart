import 'dart:async';
import 'dart:io' as io;
import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:confetti/confetti.dart';
import 'package:edit_distance/edit_distance.dart';
import 'package:intl/intl.dart' as intl;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_recorder3/flutter_audio_recorder3.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_speech/config/recognition_config.dart';
import 'package:google_speech/config/recognition_config_v1.dart';
import 'package:google_speech/speech_client_authenticator.dart';
import 'package:google_speech/speech_to_text.dart';
import 'package:hikayati_app/core/util/CharactersList.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:hikayati_app/features/Story/date/model/accuracyModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file/local.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../../../core/AppTheme.dart';
import '../../../../core/util/Common.dart';

import '../../../../core/widgets/CustomButton.dart';
import '../../../../core/widgets/CustomIconWidget.dart';

import '../../../../core/widgets/CustomPageRoute.dart';
import '../../../../core/widgets/PlayButton.dart';
import '../../../../core/widgets/TutorialWidget.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../injection_container.dart';
import '../../../../main.dart';
import '../../../Home/presintation/page/HomePage.dart';
import '../../../Regestrion/date/model/userMode.dart';
import '../manager/Slied_bloc.dart';
import '../manager/Slied_event.dart';
import '../manager/Slied_state.dart';
import 'package:hikayati_app/features/Regestrion/date/model/CompletionModel.dart';

class StoryPage extends StatefulWidget {
  final id;

  final LocalFileSystem localFileSystem;

  StoryPage({localFileSystem, this.id})
      : this.localFileSystem = localFileSystem ?? LocalFileSystem();

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  bool visiblety = true;
  UserModel? userModel;
  Widget SliedWidget = Center();
  int star = 0;
  ScreenUtil screenUtil = ScreenUtil();
  bool isSpack = true;
  final player = AudioPlayer();
  GlobalKey keyone = GlobalKey();
  GlobalKey keytwo = GlobalKey();
  GlobalKey keythree = GlobalKey();
  GlobalKey keyfive = GlobalKey();
  GlobalKey keyfour = GlobalKey();
  GlobalKey keyseven = GlobalKey();
  bool tautorial4 = false;
  SharedPreferences? prefs;
  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus> targets = [];
  int currentIndexPage = 0;
  String text_orglin = '';
  var pathiamge;
  Timer timer = Timer(Duration(seconds: 0), () {});
  PageController pageControler = PageController();
  TextEditingController result = TextEditingController();
  int rendom = 0;
  int stars = 0;
  String pathaudio = '';
  double valueslider = 0;
  CharactersList CharactersListobj = CharactersList();
  String? filePath;
  FlutterAudioRecorder3? _recorder;
  Recording? _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  bool recognizing = false;
  bool recognizeFinished = false;
  bool isProcces = false;
  String text = '';
  bool lisen = true;
  var contects;
  int lengthSrory = 0;
  String media_id = '';
  String story_id = '';
  int pres = 0;
  int reuslt = 0;
  bool microphone = false;
  final controller = ConfettiController();

  @override
  Widget build(BuildContext context) {
    contects = context;
    screenUtil.init(context);
    return WillPopScope(
      onWillPop: () async {
        final value = await showImagesDialogWithCancleButten(
            context,
            '${CharactersListobj.confusedListCharactersList[int.parse(userModel!.character.toString())]['image']}',
            'هل حقا تريد المغادره ؟', () {
          Navigator.pop(context);
        }, () async {
          CompletionModel? copm = await db.CompletionExits(story_id);
          print(copm);
          if (copm != null) {
            db.addCompletion(copm);
          }
          print('copm');
          Navigator.push(context, CustomPageRoute(child: HomePage()));
        });

        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: BlocProvider(
            create: (context) => sl<SliedBloc>(),
            child: BlocConsumer<SliedBloc, SliedState>(
              listener: (_context, state) {
                if (state is SliedError) {
                  print(state.errorMessage);
                }
              },
              builder: (_context, state) {
                if (state is SliedInitial) {
                  BlocProvider.of<SliedBloc>(_context).add(GetAllSlied(
                      story_id: widget.id.toString(),
                      tableName: 'stories_media'));
                }

                if (state is SliedLoading) {
                  SliedWidget = Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Center(
                            child: Lottie.asset(
                          "assets/json/animation_slied.json",
                          width: 300,
                        )),
                        Text(
                          'جاري تحهيز القصه ',
                          style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontSize: 20,
                              fontFamily: AppTheme.fontFamily),
                        )
                      ],
                    ),
                  );
                }

                if (state is SliedILoaded) {
                  //TODO::Show Slied here

                  lengthSrory = state.SliedModel.length;
                  SliedWidget = Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/images/backgraond.png',
                          ),
                          fit: BoxFit.fill),
                    ),
                    height: screenUtil.screenHeight * 1,
                    width: screenUtil.screenWidth * 1,
                    child: Center(
                        child: Row(
                      children: [
                        SafeArea(
                          child: Container(
                            width: screenUtil.screenWidth * .1,
                            height: screenUtil.screenHeight * 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomIconWidget(
                                    status: true,
                                    key: keyone,
                                    secondaryColor: AppTheme.primaryColor,
                                    primaryColor: Colors.white,
                                    primaryIcon: Icon(Icons.home,
                                        color: AppTheme.primaryColor),
                                    secondaryIcon: Icon(Icons.home,
                                        color: AppTheme.primaryColor),
                                    onTap: () {
                                      showImagesDialogWithCancleButten(
                                          context,
                                          '${CharactersListobj.confusedListCharactersList[int.parse(userModel!.character.toString())]['image']}',
                                          'هل حقا تريد المغادره ؟', () {
                                        Navigator.pop(context);
                                      }, () async {
                                        CompletionModel? copm =
                                            await db.CompletionExits(story_id);
                                        print(copm);
                                        if (copm != null) {
                                          db.addCompletion(copm);
                                        }
                                        Navigator.push(context,
                                            CustomPageRoute(child: HomePage()));
                                      });
                                    }),
                                state.SliedModel[currentIndexPage].page_no == 0
                                    ? Container()
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CustomIconWidget(
                                            key: keytwo,
                                            onTap: () async {
                                              startAudio(
                                                  pathAudio: state
                                                      .SliedModel[
                                                          currentIndexPage]
                                                      .audio);
                                            },
                                            primaryColor: Colors.white,
                                            primaryIcon: Icon(
                                              Icons.volume_up,
                                              color: AppTheme.primaryColor,
                                            ),
                                            secondaryIcon: Icon(
                                              Icons.volume_up,
                                              color: Colors.white,
                                            ),
                                            secondaryColor:
                                                AppTheme.primaryColor,
                                            status: isSpack,
                                          ),
                                          SizedBox(
                                            height:
                                                screenUtil.screenHeight * .1,
                                          ),
                                          CustomIconWidget(
                                            key: keythree,
                                            onTap: () async {
                                              if (microphone) {
                                                _stop();
                                              } else {
                                                if (await networkInfo
                                                    .isConnected) {
                                                  _start();
                                                } else {
                                                  noInternt(context,
                                                      'تاكد من وجود انترنت');
                                                }
                                              }
                                            },
                                            primaryColor: Colors.white,
                                            primaryIcon: Icon(
                                              Icons.mic,
                                              color: AppTheme.primaryColor,
                                            ),
                                            secondaryIcon: Icon(
                                              Icons.mic,
                                              color: Colors.white,
                                            ),
                                            secondaryColor:
                                                AppTheme.primaryColor,
                                            status: !microphone,
                                          ),
                                        ],
                                      )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: screenUtil.screenHeight * 1,
                          width: screenUtil.screenWidth * .8,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Stack(
                              children: [
                                PageView.builder(
                                  itemCount: state.SliedModel.length,
                                  reverse: true,
                                  controller: pageControler,
                                  itemBuilder: (context, index) {
                                    story_id = state.SliedModel[index].story_id
                                        .toString();

                                    text_orglin = state
                                        .SliedModel[index].text_no_desc
                                        .toString();
                                    currentIndexPage = index;
                                    print(currentIndexPage);
                                    print('currentIndexPagegraide');
                                    print(state.SliedModel[index].page_no);

                                    media_id =
                                        state.SliedModel[index].id.toString();
                                    // print(media_id);
                                    // print('media_id');
                                    return state.SliedModel[index].page_no == 0
                                        ? Container(
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            child: Stack(
                                              alignment: AlignmentDirectional
                                                  .topCenter,
                                              children: [
                                                Container(
                                                    width:
                                                        screenUtil.screenWidth *
                                                            1,
                                                    height: screenUtil
                                                            .screenHeight *
                                                        .80,
                                                    padding: EdgeInsets.only(
                                                        right: 10,
                                                        left: 10,
                                                        top: 10),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: Image.file(
                                                        io.File(
                                                            '$path/${state.SliedModel[index].image}'),
                                                        fit: BoxFit.cover,
                                                        height: screenUtil
                                                                .screenHeight *
                                                            .9,
                                                        width: screenUtil
                                                                .screenWidth *
                                                            .9,
                                                      ),
                                                    )),
                                                Positioned(
                                                  height:
                                                      screenUtil.screenHeight *
                                                          1.75,
                                                  width:
                                                      screenUtil.screenWidth *
                                                          .8,
                                                  child: Center(
                                                    child: CustomButton(
                                                      ontap: () {
                                                        setState(() {
                                                          currentIndexPage =
                                                              index + 1;
                                                          state
                                                              .SliedModel[index]
                                                              .page_no;

                                                          pageControler.nextPage(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      500),
                                                              curve: Curves
                                                                  .fastOutSlowIn);
                                                          startAudio(
                                                              pathAudio: state
                                                                  .SliedModel[
                                                                      currentIndexPage]
                                                                  .audio);
                                                        });
                                                        if (currentIndexPage ==
                                                            1) {
                                                          showTutorial();
                                                        }
                                                      },
                                                      text: 'ابدأ',
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              setState(() {
                                                currentIndexPage = index;
                                                text_orglin = state
                                                    .SliedModel[index].text;
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Stack(
                                                alignment: AlignmentDirectional
                                                    .topCenter,
                                                children: [
                                                  Container(
                                                      width: screenUtil
                                                              .screenWidth *
                                                          1,
                                                      height: screenUtil
                                                              .screenHeight *
                                                          .80,
                                                      padding: EdgeInsets.only(
                                                          right: 10,
                                                          left: 10,
                                                          top: 10),
                                                      child: Image.file(
                                                        io.File(
                                                            '$path/${state.SliedModel[index].image}'),
                                                        fit: BoxFit.cover,
                                                        height: screenUtil
                                                                .screenHeight *
                                                            .9,
                                                        width: screenUtil
                                                                .screenWidth *
                                                            .9,
                                                      )),
                                                  Positioned(
                                                    height: screenUtil
                                                            .screenHeight *
                                                        1.75,
                                                    width:
                                                        screenUtil.screenWidth *
                                                            .8,
                                                    child: Center(
                                                      child: Container(
                                                        width: screenUtil
                                                                .screenWidth *
                                                            .9,
                                                        height: screenUtil
                                                                .screenHeight *
                                                            1,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            index + 1 ==
                                                                    state
                                                                        .SliedModel
                                                                        .length
                                                                ? Container()
                                                                : InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      int isfound = await db.checkSlidFound(state
                                                                          .SliedModel[
                                                                              index]
                                                                          .id);
                                                                      isfound ==
                                                                              0
                                                                          ? star == 0
                                                                              ? showImagesDialog(context, '${CharactersListobj.sadListCharactersList[int.parse(userModel!.character.toString())]['image']}', '! يرجى تسجيل الصوت أولاً', () {
                                                                                  Navigator.pop(context);
                                                                                })
                                                                              : {
                                                                                  await pageControler.nextPage(duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn),
                                                                                  startAudio(pathAudio: state.SliedModel[currentIndexPage].audio),
                                                                                }
                                                                          : {
                                                                              await pageControler.nextPage(duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn),
                                                                              startAudio(pathAudio: state.SliedModel[currentIndexPage].audio),
                                                                            };
                                                                      star = 0;
                                                                    },
                                                                    child: Image
                                                                        .asset(
                                                                      color: AppTheme
                                                                          .primarySwatch
                                                                          .shade800,
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      Assets
                                                                          .images
                                                                          .rightArrow
                                                                          .path,
                                                                    ),
                                                                  ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  state
                                                                      .SliedModel[
                                                                          index]
                                                                      .text
                                                                      .toString(),
                                                                  style: AppTheme
                                                                      .textTheme
                                                                      .displayLarge,
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                    '${state.SliedModel.length - 1}/${state.SliedModel[index].page_no}',
                                                                    style: TextStyle(
                                                                        color: AppTheme
                                                                            .primaryColor,
                                                                        fontSize:
                                                                            12))
                                                              ],
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  currentIndexPage =
                                                                      index - 1;
                                                                  pageControler.previousPage(
                                                                      duration: Duration(
                                                                          seconds:
                                                                              1),
                                                                      curve: Curves
                                                                          .fastOutSlowIn);
                                                                });
                                                              },
                                                              child:
                                                                  Image.asset(
                                                                color: AppTheme
                                                                    .primarySwatch
                                                                    .shade400,
                                                                Assets
                                                                    .images
                                                                    .leftArrow
                                                                    .path,
                                                                width: 30,
                                                                height: 30,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                  },
                                ),
                                isProcces
                                    ? Dialog(
                                        surfaceTintColor: Colors.white,
                                        backgroundColor: Colors.white,
                                        shadowColor: Colors.white,
                                        insetAnimationDuration:
                                            Duration(seconds: 30),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Container(
                                            height: 120,
                                            width: 70,
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppTheme.primaryColor,
                                                    width: 4),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CircularProgressIndicator(
                                                    color:
                                                        AppTheme.primaryColor),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'جاري عمليه المطابقه ......',
                                                  style: AppTheme
                                                      .textTheme.displaySmall,
                                                  overflow: TextOverflow.clip,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            )),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                  );
                }

                return SliedWidget;
              },
            ),
          ),
        ),
      ),
    );
  }

  _init() async {
    try {
      bool hasPermission = await FlutterAudioRecorder3.hasPermissions ?? false;
      final status2 = await Permission.accessMediaLocation.request();

      if (hasPermission || status2.isGranted) {
        String customPath = '/audio';
        io.Directory? appDocDirectory = await getExternalStorageDirectory();

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"

        customPath = appDocDirectory!.path + customPath;

        await dirFound(customPath + '.wav');

        _recorder = FlutterAudioRecorder3(
          customPath,
          audioFormat: AudioFormat.WAV,
        );

        await _recorder!.initialized;
        // after initialization
        var current = await _recorder!.current(channel: 0);
        // should be "Initialized", if all working fine
        setState(() {
          _current = current;
          _currentStatus = current!.status!;
          print(_currentStatus);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("يرجى منك السماح بتحميل الملفات")));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> dirFound(savePath) async {
    if (await io.File(savePath).exists()) {
      print('file is exite');
      io.File(savePath).delete();
      print('file is deleted');

      return true;
    } else {
      print('file is not exite');

      return true;
    }
  }

  _stop() async {
    setState(() {
      microphone = false;
    });
    var result = await _recorder!.stop();
    filePath = result!.path;
    _current = result;
    print('LLLLLLLLLLLL');
    _currentStatus = RecordingStatus.Unset;
    print(_currentStatus);
    isProcces = true;
    recognize();

    // String customPath = '/audio';
    // io.Directory? appDocDirectory = await getExternalStorageDirectory();
    // customPath = appDocDirectory!.path + customPath ;
    //
    // await dirFound(customPath+'.wav');
  }

  _start() async {
    try {
      await _init();
      await _recorder!.start();
      var recording = await _recorder!.current(channel: 0);
      setState(() {
        microphone = true;
        _current = recording;
      });

      timer = Timer.periodic(Duration(seconds: 25), (Timer t) async {
        if (_currentStatus != RecordingStatus.Unset) {
          t.cancel();
          setState(() {
            visiblety = !visiblety;
            isProcces = true;
          });
          _stop();
        } else if (_currentStatus == RecordingStatus.Unset) {
          t.cancel();
        }
      });
      var current = await _recorder!.current(channel: 0);

      // print(current.status);
      setState(() {
        _current = current;
        _currentStatus = _current!.status!;
        print('jjjjjjj');

        print(_currentStatus);
      });
      // });
    } catch (e) {
      print(e);
    }
  }

  RecognitionConfig _getConfig() => RecognitionConfig(
      encoding: AudioEncoding.LINEAR16,
      model: RecognitionModel.basic,
      enableAutomaticPunctuation: true,
      sampleRateHertz: 16000,
      languageCode: 'ar-SA');
  Future<void> _copyFileFromAssets(String name) async {
    var data = await rootBundle.load(name);
    // final directory = await getApplicationDocumentsDirectory();
    // final path = directory.path + '/$name';
    final path = name;
    await io.File(path).writeAsBytes(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<List<int>> _getAudioContent(String name) async {
    // final directory = await getApplicationDocumentsDirectory();
    final path = name;
    // final path = directory.path + '/$name';
    if (!io.File(path).existsSync()) {
      await _copyFileFromAssets(name);
    }
    return io.File(path).readAsBytesSync().toList();
  }

  void recognize() async {
    setState(() {
      recognizing = true;
    });
    final serviceAccount = ServiceAccount.fromString(
        '${(await rootBundle.loadString('assets/test_service_account.json'))}');
    final speechToText = SpeechToText.viaServiceAccount(serviceAccount);
    final config = _getConfig();
    print("*********recognize");
    // print(widget.filePath);
    final audio = await _getAudioContent(filePath!);

    await speechToText.recognize(config, audio).then((value) async {
      setState(() {
        text = value.results
            .map((e) => e.alternatives.first.transcript)
            .join('\n');
        text = text.replaceAll('.', '');
        text = text.replaceAll('?', '');
        text = text.replaceAll('!', '');
        print(text);
      });
    }).whenComplete(() => setState(() {
          recognizeFinished = true;
          recognizing = false;
          isProcces = false;
        }));
    star = await checkText(
        text_orglin, text, int.parse(userModel!.level.toString()));
    print(star);
    print('star');

    star != 0
        ? {
            reuslt = await db.addAccuracy(
                accuracyModel(
                  media_id: media_id,
                  readed_text: text,
                  accuracy_stars: star,
                  updated_at: intl.DateFormat('yyyy-MM-ddTHH:mm:ss.ssssZ')
                      .format(DateTime.now()),
                ),
                userModel),
            print(reuslt),
            print('result'),
            currentIndexPage + 1 == lengthSrory
                ? {
                    controller.play(),
                    showConfetti(context, controller,
                        '${CharactersListobj.singListCharactersList[int.parse(userModel!.character.toString())]['image']}'),
                    pres = await db.getPercentage(widget.id.toString()),
                    await Future.delayed(Duration(seconds: 1)),
                    print(pres),
                    print('persintage'),
                    stars = pres ~/ 33,
                    print('stars completion '),
                    print(stars),
                    db.addCompletion(CompletionModel(
                        updated_at: intl.DateFormat('yyyy-MM-ddTHH:mm:ss.ssssZ')
                            .format(DateTime.now().toUtc()),
                        percentage: pres,
                        story_id: widget.id,
                        stars: stars)),
                  }
                : showImagesDialogWithStar(
                    context,
                    '${CharactersListobj.singListCharactersList[int.parse(userModel!.character.toString())]['image']}',
                    'احسنت', () {
                    Navigator.pop(context);
                  }, star),
          }
        : showImagesDialogWithDoNotWill(
            context,
            '${CharactersListobj.sadListCharactersList[int.parse(userModel!.character.toString())]['image']}',
            'حاول مرة اخرى',
            text.length > 25
                ? text.replaceRange(25, text.length, '....')
                : text,
            text_orglin);
  }

  int checkText(String originalText, String readText, int level) {
    if (level == 3) {
      final int similarityPercentageInt =
          (StringSimilarity.compareTwoStrings(originalText, readText) * 100)
              .toInt();

      if (similarityPercentageInt > 97) return 3;
      if (similarityPercentageInt > 89) return 2;
      if (similarityPercentageInt > 84) return 1;
      return 0;
    }

    final int textLength = originalText.length;
    if (textLength < 17) {
      var d = Levenshtein();
      final int wrongLetter = d.distance(originalText, readText);

      if (wrongLetter == 0) return 3;
      if (textLength < 5) return wrongLetter == 1 ? 2 : 0;
      if (textLength < 8)
        return wrongLetter == 1
            ? 2
            : wrongLetter == 2
                ? 1
                : 0;
      return wrongLetter == 1 || wrongLetter == 2
          ? 2
          : wrongLetter == 3
              ? 1
              : 0;
    }

    final int similarityPercentageInt =
        (StringSimilarity.compareTwoStrings(originalText, readText) * 100)
            .toInt();

    if (similarityPercentageInt > 94) return 3;
    if (similarityPercentageInt > 88) return 2;
    if (similarityPercentageInt > 79) return 1;

    return 0;
  }

  @override
  void didChangeDependencies() {
    player.onPlayerComplete.listen((event) {
      setState(() {
        isSpack = !isSpack;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  initData() async {
    lisen = await getCachedData(
            key: 'Listen_to_story',
            returnType: bool,
            retrievedDataType: bool) ??
        true;

    userModel = await getCachedData(
      key: 'UserInformation',
      retrievedDataType: UserModel.init(),
      returnType: UserModel.init(),
    );
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.dispose();
  }

  showTutorial() async {
    targets = [
      TargetFocus(identify: "target1", keyTarget: keyone, contents: [
        TargetContent(
            align: ContentAlign.left,
            child: TutorialWidget(
              index: 1,
              onTap: () {
                tutorialCoachMark!.next();
              },
              text: "يمكنك  الرجوع  الى  القائمة  الرئسية  من  هنا ",
              Characters: int.parse(userModel!.character.toString()) ?? 0,
            ))
      ]),
      TargetFocus(identify: "target2", keyTarget: keytwo, contents: [
        TargetContent(
            align: ContentAlign.left,
            child: TutorialWidget(
              index: 2,
              hight: screenUtil.screenHeight * .5,
              onTap: () {
                tutorialCoachMark!.next();
              },
              text:
                  "اضغط  على  هذا الزر  من  اجل  الاستماع  للقصة  ويمكنك  ايقاف  خاصية  الاستماع  من  الاعدادات",
              Characters: int.parse(userModel!.character.toString()) ?? 0,
            ))
      ]),
      TargetFocus(identify: "target3", keyTarget: keythree, contents: [
        TargetContent(
            align: ContentAlign.top,
            child: TutorialWidget(
              index: 3,
              onTap: () {
                tutorialCoachMark!.next();
              },
              hight: screenUtil.screenHeight * .5,
              text:
                  "  اثناء  قراءتك  للقصة  قم  بتسجيل  صوتك  من  اجل  التاكد  من  صحه  القراءة    ",
              Characters: int.parse(userModel!.character.toString()) ?? 0,
            ))
      ]),
    ];
    prefs = await SharedPreferences.getInstance();
    tautorial4 = await prefs?.getBool("tautorial4") ?? false;

    print("object");
    print(tautorial4);
    print("object");
    if (tautorial4 == false) {
      tutorialCoachMark = TutorialCoachMark(
          hideSkip: true,
          targets: targets,
          onFinish: () async {
            prefs = await SharedPreferences.getInstance();
            prefs!.setBool("tautorial4", true);
          });
      tutorialCoachMark!.show(context: context);
    }
  }

  startAudio({required String pathAudio}) async {
    final status2 = await Permission.accessMediaLocation.request();
    final status = await Permission.storage.request();
    if (status.isGranted || status2.isGranted) {
      await player.play(DeviceFileSource(path + '/' + pathAudio));
      setState(() {
        isSpack = !isSpack;
      });
    }
  }
}
