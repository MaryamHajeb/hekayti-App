import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/CastemInput.dart';
import '../../../../core/widgets/CustemIcon.dart';
import '../../../../core/widgets/CustemIcon2.dart';
import '../../../../injection_container.dart';
import '../manager/Slied_bloc.dart';
import '../manager/Slied_event.dart';
import '../manager/Slied_state.dart';

class StoryPage extends StatefulWidget {
  final id;
   StoryPage({Key? key,required this.id}) : super(key: key);

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
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future startRecord() async {
    await recorder.startRecorder(toFile: "audio");
  }

  Future stopRecorder() async {
    final filePath = await recorder.stopRecorder();
    final file = File(filePath!);
    print('Recorded file path: $filePath');
  }



Widget SliedWidget=Center();
  ScreenUtil screenUtil = ScreenUtil();
  bool isSpack=false;
  bool islisnt=false;
  int currentIndexPage =0;
  PageController pageControler=PageController();
  TextEditingController result = TextEditingController();
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
                            'assest/images/backgraond.png',
                          ),
                          fit: BoxFit.fill),
                    ),
                    height: screenUtil.screenHeight * 1,
                    width: screenUtil.screenWidth * 1,
                    child: Center(
                        child: Row(
                          children: [
                            Container(
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
                                            });
                                          })
                                          : CustemIcon(
                                          icon: Icon(
                                            Icons.headset_mic_outlined,
                                          ),
                                          ontap: () {}),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      recorder.isRecording
                                          ? CustemIcon(
                                          icon: Icon(
                                            Icons.mic,
                                          ),
                                          ontap: ()async {

                                              initRecorder();
                                              if (recorder.isRecording) {
                                                await stopRecorder();
                                                    setState(() {
                                                    });
                                              } else {
                                                await startRecord();
                                                   setState(() {

                                                   });
                                              }

                                          })
                                          : CustemIcon2(
                                          icon: Icon(
                                            Icons.mic,
                                          ),
                                          ontap: () async{
                                            initRecorder();
                                            if (recorder.isRecording) {
                                              await stopRecorder();
                                                   setState(() {

                                                   });
                                            } else {
                                              await startRecord();
                                                setState(() {

                                                });
                                            }
                                          }),
                                    ],
                                  )
                                ],
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

                                          fit: StackFit.loose,

                                          children: [

                                            Container(
                                                width: screenUtil.screenWidth * 1,
                                                height: screenUtil.screenHeight * .8,
                                                padding:
                                                EdgeInsets.only(right: 10, left: 10, top: 10),
                                                child: Image.memory(


                                                    converToBase64(
                                                        state.SliedModel[index].photo.toString()

                                                    ),
                                                         fit: BoxFit.cover,
                                                  height: screenUtil.screenHeight * .9,width: screenUtil.screenWidth *.9



                                                  ,)),
                                            StreamBuilder<RecordingDisposition>(
                                              builder: (context, snapshot) {
                                                final duration = snapshot.hasData
                                                    ? snapshot.data!.duration
                                                    : Duration.zero;

                                                String twoDigits(int n) => n.toString().padLeft(2, '0');
                                                final twoDigitMinutes =
                                                twoDigits(duration.inMinutes.remainder(60));
                                                final twoDigitSeconds =
                                                twoDigits(duration.inSeconds.remainder(60));

                                                return Center(
                                                  child: Text(
                                                    '$twoDigitMinutes:$twoDigitSeconds',
                                                    style: const TextStyle(
                                                      color: Colors.amber,
                                                      fontSize: 50,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                );
                                              },
                                              stream: recorder.onProgress,
                                            ),
                                            Positioned(
                                              height: screenUtil.screenHeight * 1.8,
                                               width: screenUtil.screenWidth *.8,
                                              child: Center(
                                                child: Container(

                                                  width: screenUtil.screenWidth * .9,
                                                  height: screenUtil.screenHeight *1,
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      InkWell(
                                                        onTap: (){
                                                          setState(() {
                                                            index =index+1;
                                                            pageControler.nextPage(duration: Duration(seconds: 1), curve: Curves.bounceInOut);
                                                          });
                                                        },
                                                          child: Image.asset(
                                                            color: AppTheme.primarySwatch.shade500,
                                                            'assest/images/right_arrow.png',
                                                          ),
                                                      ),

                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text(state.SliedModel[index].text.toString()),
                                                          SizedBox(height: 5,),
                                                          Text(
                                                              '${state.SliedModel.length}/${index + 1}',
                                                              style: TextStyle(
                                                                  color: AppTheme
                                                                      .primaryColor,
                                                                  fontSize: 14))
                                                        ],
                                                      ),
                                                      InkWell(
                                                        onTap: (){
                                                          setState(() {
                                                            index =index+1;
                                                            pageControler.previousPage(duration: Duration(seconds: 1), curve: Curves.bounceInOut);
                                                          });
                                                        },
                                                        child:  Image.asset(
                                                          color: AppTheme.primarySwatch.shade500,
                                                          'assest/images/left_arrow.png',
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


}
