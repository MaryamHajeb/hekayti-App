import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/util/Carecters.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:hikayati_app/features/Story/date/model/accuracyModel.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/common.dart';
import '../../../../core/util/database_helper.dart';

import '../../../../core/widgets/CustemIcon.dart';
import '../../../../core/widgets/CustemIcon2.dart';
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

  StoryPage({Key? key, required this.id}) : super(key: key);

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  final recorder = FlutterSoundRecorder();

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Permission not granted';
    }
  }

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
                                    icon: Icon(
                                      Icons.home,
                                    ),
                                    ontap: () {
                                      Navigator.pop(context);
                                    }),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    isSpack == false
                                        ? CustemIcon2(
                                            icon: Icon(
                                              Icons.headset_mic_outlined,
                                            ),
                                            ontap: () {
                                              setState(() {
                                                isSpack = true;
                                                setState(() {
                                                  visiblety = !visiblety;
                                                });
                                                player.play(
                                                    AssetSource('music.mp3'));
                                              });
                                            })
                                        : CustemIcon(
                                            icon: Icon(
                                              Icons.headset_mic_outlined,
                                            ),
                                            ontap: () async {}),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    visiblety
                                        ? CustemIcon(
                                            icon: Icon(
                                              Icons.mic,
                                            ),
                                            ontap: () async {
                                              setState(() {});
                                            })
                                        : CustemIcon2(
                                            icon: Icon(
                                              Icons.mic,
                                            ),
                                            ontap: () async {
                                              initRecorder();
                                              setState(() {});
                                            }),
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
    List dd = await db.getAllstory('accuracy');
    print('--------------------------------------------');
    print(dd.toString());
    print('--------------------------------------------');

    for (int i = 0; i < dd.length; i++) {
      accuracyModel user = accuracyModel.fromJson(dd[i]);
      print(
          'ID: ${user.id} - username: ${user.media_id} - city: ${user.accuracy_percentage}');
    }
  }
}
