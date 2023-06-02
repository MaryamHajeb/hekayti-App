import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io' as io;
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_recorder3/flutter_audio_recorder3.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_speech/config/recognition_config.dart';
import 'package:google_speech/config/recognition_config_v1.dart';
import 'package:google_speech/speech_client_authenticator.dart';
import 'package:google_speech/speech_to_text.dart';
import 'package:hikayati_app/core/util/Carecters.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:hikayati_app/features/Story/date/model/accuracyModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file/local.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/util/common.dart';
import '../../../../core/util/database_helper.dart';
import 'package:file/file.dart';

import '../../../../core/widgets/CustemIcon.dart';
import '../../../../core/widgets/CustemIcon2.dart';
import '../../../../core/widgets/PlayButton.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../injection_container.dart';
import '../../../../main.dart';
import '../../../../main.dart';
import '../../../Home/data/model/StoryMode.dart';
import '../manager/Slied_bloc.dart';
import '../manager/Slied_event.dart';
import '../manager/Slied_state.dart';

class StoryPage extends StatefulWidget {
  final id;

  final LocalFileSystem localFileSystem;

  StoryPage({localFileSystem, this.id})
      : this.localFileSystem = localFileSystem ?? LocalFileSystem();

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  bool visiblety = false;
  Widget SliedWidget = Center();
  ScreenUtil screenUtil = ScreenUtil();
  bool isSpack = false;
  bool islisnt = false;
  final player = AudioPlayer();
  int Carecters_id = 0;
  int currentIndexPage = 0;
  PageController pageControler = PageController();
  TextEditingController result = TextEditingController();
  int rendom = 0;
  List starts = [1, 2, 0, 3, 2, 3];
  String pathaudio = '';
  double valueslider = 0;
  Carecters carectersobj = Carecters();
  String? filePath;
  FlutterAudioRecorder3? _recorder;
  Recording? _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  bool recognizing = false;
  bool recognizeFinished = false;
  String text = '';
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Scaffold(
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
                      story_id: widget.id.toString(), tableName: 'meadia'));
                }

                if (state is SliedLoading) {
                  SliedWidget = CircularProgressIndicator();
                }

                if (state is SliedILoaded) {
                  //TODO::Show Slied here

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
                                CustemIcon2(
                                    icon: Icon(Icons.home,
                                        color: AppTheme.primaryColor),
                                    ontap: () {
                                      showImagesDialogWithCancleButten(
                                          context,
                                          '${carectersobj.confusedListCarecters[Carecters_id]['image']}',
                                          'هل حقا تريد المغادره');
                                    }),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    isSpack == false
                                        ? CustemIcon2(
                                            icon: Icon(
                                                Icons.headset_mic_outlined,
                                                color: AppTheme.primaryColor),
                                            ontap: () {
                                              setState(() {
                                                isSpack = true;

                                                //   player.play(
                                                //     AssetSource('music.mp3'));
                                              });
                                            })
                                        : CustemIcon(
                                            icon: Icon(
                                              Icons.headset_mic_outlined,
                                            ),
                                            ontap: () async {
                                              isSpack = !isSpack;
                                              setState(() {});
                                            }),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: PlayButton(onPressed: () {
                                          setState(() {
                                            visiblety = !visiblety;

                                            visiblety ? _start():  _currentStatus != RecordingStatus.Unset ? _stop() : null;

                                          });
                                        },initialIsPlaying:      visiblety,pauseIcon: Icon(Icons.stop,color: AppTheme.primaryColor),playIcon: Icon(Icons.mic,color: AppTheme.primaryColor),)),
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
                            child: PageView.builder(
                              itemCount: state.SliedModel.length,
                              reverse: true,
                              controller: pageControler,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      currentIndexPage = index;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Stack(
                                      alignment: AlignmentDirectional.topCenter,
                                      children: [
                                        Container(
                                            width: screenUtil.screenWidth * 1,
                                            height:
                                                screenUtil.screenHeight * .85,
                                            padding: EdgeInsets.only(
                                                right: 10, left: 10, top: 10),
                                            child: Image.memory(
                                              converToBase64(state
                                                  .SliedModel[index].photo
                                                  .toString()),
                                              fit: BoxFit.cover,
                                              height:
                                                  screenUtil.screenHeight * .9,
                                              width:
                                                  screenUtil.screenWidth * .9,
                                            )),
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15))),
                                          margin: EdgeInsets.all(15),
                                          child: Visibility(
                                            visible: visiblety,
                                            child: Container(
                                              margin: EdgeInsets.all(5),
                                              width:
                                                  screenUtil.screenWidth * .5,
                                              height:
                                                  screenUtil.screenHeight * .1,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          AppTheme.primaryColor,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Row(children: [
                                                Expanded(
                                                    flex: 6,
                                                    child: Slider(
                                                      value: valueslider,
                                                      max: 100,
                                                      min: 0,
                                                      onChanged:
                                                          (double value) {
                                                        setState(() {
                                                          valueslider = value;
                                                        });
                                                      },
                                                    )),
                                                Expanded(
                                                    flex: 2,
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                            Icons.play_arrow,
                                                            color: AppTheme
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(Icons.stop,
                                                              color: AppTheme
                                                                  .primaryColor),
                                                        ),
                                                      ],
                                                    ))
                                              ]),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          height: screenUtil.screenHeight * 1.8,
                                          width: screenUtil.screenWidth * .8,
                                          child: Center(
                                            child: Container(
                                              width:
                                                  screenUtil.screenWidth * .9,
                                              height:
                                                  screenUtil.screenHeight * 1,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      index = index + 1;
                                                      rendom =
                                                          Random().nextInt(100);
                                                      print(
                                                          '333333333333333333333333333333333333333333');

                                                      print(rendom);
                                                      print(
                                                          '333333333333333333333333333333333333333333');
                                                      if (rendom >= 50) {
                                                        pageControler.nextPage(
                                                            duration: Duration(
                                                                seconds: 1),
                                                            curve: Curves
                                                                .bounceInOut);
                                                      } else {
                                                        showImagesDialogWithCancleButten(
                                                            context,
                                                            '${carectersobj.sadListCarecters[Carecters_id]['image']}',
                                                            '! ياللأسف         أعد المحاولة مرة أخرى'
                                                                '');
                                                      }
                                                      db.inser(
                                                          data: accuracyModel(
                                                              media_id: state
                                                                  .SliedModel[
                                                                      currentIndexPage]
                                                                  .id,
                                                              user_id:
                                                                  'almomyz@gami',
                                                              accuracy_percentage:
                                                                  rendom),
                                                          tableName:
                                                              'accuracy');
                                                      ;
                                                    },
                                                    child: Image.asset(
                                                      color: AppTheme
                                                          .primarySwatch
                                                          .shade500,
                                                      width: 30,
                                                      height: 30,
                                                      fit: BoxFit.fill,
                                                      Assets.images.rightArrow
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
                                                        state.SliedModel[index]
                                                            .text
                                                            .toString(),
                                                        style: AppTheme
                                                            .textTheme
                                                            .headline3,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          '${state.SliedModel.length}/${index + 1}',
                                                          style: TextStyle(
                                                              color: AppTheme
                                                                  .primaryColor,
                                                              fontSize: 14))
                                                    ],
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        index = index + 1;
                                                        pageControler
                                                            .previousPage(
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            1),
                                                                curve: Curves
                                                                    .bounceInOut);
                                                      });
                                                    },
                                                    child: Image.asset(
                                                      color: AppTheme
                                                          .primarySwatch
                                                          .shade500,
                                                      Assets.images.leftArrow
                                                          .path,
                                                      width: 30,
                                                      height: 30,
                                                      fit: BoxFit.fill,
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
                          ),
                        ),
                      ],
                    )),
                  );
                }

                return SliedWidget;
              },
            ),
          )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Carecters_id = getCachedDate('Carecters', String);
  }

  Future<String> saveAcurrcy(
      dynamic media_id, user_id, accuracy_percentage) async {
    try {
      await db.inser(
          data: accuracyModel(
              media_id: media_id,
              user_id: user_id,
              accuracy_percentage: accuracy_percentage),
          tableName: 'accuracy');
      print('---------------------------------------------------------');

      print('---------------------------------------------------------');
    } catch (e) {
      print(e.toString());
    }
    return db.toString();
  }

  getaccurac() async {
    List dd = await db.getAllstory('accuracy', '1');
    print('--------------------------------------------');
    print(dd.toString());
    print('--------------------------------------------');

    for (int i = 0; i < dd.length; i++) {
      accuracyModel user = accuracyModel.fromJson(dd[i]);
      print(
          'ID: ${user.id} - username: ${user.media_id} - city: ${user.accuracy_percentage}');
    }
  }

  _init() async {
    try {
      bool hasPermission = await FlutterAudioRecorder3.hasPermissions ?? false;

      if (hasPermission) {
        String customPath = '/audio';
        io.Directory? appDocDirectory = await getExternalStorageDirectory();

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory!.path + customPath + DateTime.now().millisecondsSinceEpoch.toString();

        // .wav <---> AudioFormat.WAV
        // .mp4 .m4a .aac <---> AudioFormat.AAC
        // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder =
            FlutterAudioRecorder3(customPath, audioFormat: AudioFormat.WAV);

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
            SnackBar(content: new Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }

  _stop() async {
    var result = await _recorder!.stop();

    setState(() {
      filePath = result!.path;
      _current = result;
      print('LLLLLLLLLLLL');

      _currentStatus = RecordingStatus.Unset;
      print(_currentStatus);
      recognize();
    });
  }

  _start() async {
    try {
      await _init();
      await _recorder!.start();
      var recording = await _recorder!.current(channel: 0);
      setState(() {
        _current = recording;
      });



      // const tick = const Duration(seconds: 10);
      // new Timer.periodic(tick, (Timer t) async {
      //
      //   visiblety=!visiblety;
      //   if (_currentStatus == RecordingStatus.Unset) {
      //     t.cancel();
      //     _stop();
      //   }
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
    final path=name;
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

    await speechToText.recognize(config, audio).then((value) {
      setState(() {
        text = value.results
            .map((e) => e.alternatives.first.transcript)
            .join('\n');
        print(text);
      });
    }).whenComplete(() => setState(() {
      recognizeFinished = true;
      recognizing = false;
    }));
  }

}
