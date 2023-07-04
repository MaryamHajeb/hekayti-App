import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hikayati_app/core/app_theme.dart';
import 'package:hikayati_app/features/Home/presintation/page/HomePage.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/CustomPageRoute.dart';
import '../../../../dataProviders/network/data_source_url.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../main.dart';
import '../../../Regestrion/presintation/page/LoginPage.dart';

class StoryCardNotDownloded extends StatefulWidget {
  final name;
  String photo;
  final starts;
  int progress;
  String id;
   StoryCardNotDownloded({Key ? key,required this.name,required this.photo,required this.starts,required this.progress,required this.id}) : super(key: key);

  @override
  State<StoryCardNotDownloded> createState() => _StoryCardNotDownlodedState();
}

class _StoryCardNotDownlodedState extends State<StoryCardNotDownloded> {
  ScreenUtil screenUtil = ScreenUtil();
  ReceivePort _port = ReceivePort();
  int  progress =0;
  var path;
  DownloadTaskStatus? statusProgrress;
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);

    return Wrap(

      children: [
          Center(
            child: Container(
            width: screenUtil.screenWidth *.25,
            height: screenUtil.screenHeight *.6,


            decoration:
            BoxDecoration(


              image: DecorationImage(image: AssetImage(Assets.images.storyBG.path,),fit: BoxFit.contain,)

            ),
            child: Opacity(
              opacity: .6,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                   widget.starts == 1 ? Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [



                  Image.asset(Assets.images.start.path,width: 40,height: 40,),
                       Padding(
                         padding: const EdgeInsets.only(bottom: 20.0),
                         child: Image.asset(Assets.images.emptyStar.path,width: 40,height: 40),
                       ),
                       Image.asset(Assets.images.emptyStar.path,width: 40,height: 40),

                     ],
                   ):widget.starts ==2?
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [



                      Image.asset(Assets.images.start.path,width: 40,height: 40),
                       Padding(
                         padding: const EdgeInsets.only(bottom: 20.0),
                         child:Image.asset(Assets.images.start.path,width: 40,height: 40),
                       ),
                       Image.asset(Assets.images.emptyStar.path,width: 40,height: 40),

                     ],
                   ): widget.starts ==0 ? Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [



                       Image.asset(Assets.images.emptyStar.path,width: 40,height: 40),
                       Padding(
                         padding: const EdgeInsets.only(bottom: 20.0),
                         child: Image.asset(Assets.images.emptyStar.path,width: 40,height: 40),
                       ),
                       Image.asset(Assets.images.emptyStar.path,width: 40,height: 40),

                     ],
                   ):
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [



                       Image.asset(Assets.images.start.path,width: 40,height: 40),
                       Padding(
                         padding: const EdgeInsets.only(bottom: 20.0),
                         child:Image.asset(Assets.images.start.path,width: 40,height: 40),
                       ),
                      Image.asset(Assets.images.start.path,width: 40,height: 40),

                     ],
                   ),



                    Container(
                      height: screenUtil.screenHeight * .3,
                      width: screenUtil.screenWidth *.14,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file( File('${widget.photo}')  ,fit: BoxFit.cover,),
                        // child: Image.memory(
                        //
                        //   converToBase64(widget.photo.toString()
                        //   ),
                        //   fit: BoxFit.cover,
                        //   ),
                      ),
                    ),

                 Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     SizedBox(width: 30,),
                     statusProgrress==DownloadTaskStatus.running ?Center(child: CircularProgressIndicator()): IconButton(onPressed: (){
                      setState(() {
                        print(widget.id);
                        print('widget.id');

                          db.downloadMedia(widget.id);

                         print(progress);
                       });


                       }, icon: Icon(Icons.download,size: 30,color: AppTheme.primaryColor,)),
                     Expanded(

                       child: Text(widget.name,style: AppTheme.textTheme.headline5,
                         maxLines: 2,
                         overflow: TextOverflow.ellipsis,
                       ),
                     ),
                   ],
                 )

              ]),
            ),
            ),
          ),
        ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initpath();
       FlutterDownloader.registerCallback(downloadCallback, step: 1);

    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = DownloadTaskStatus(data[1]);

      setState((){
        statusProgrress =status;
        print(progress);
        print(statusProgrress);

        print(status);
        print('hirrrrrrrrr');

      });

    });
  }
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
    }

static  void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
    print(progress);
    print('progress');
    print(status);
    send!.send([id, status, progress]);
  }
  initpath()async{
    var externalDirectoryPath = await getExternalStorageDirectory();
    path=  externalDirectoryPath!.path.toString();
  }

  @override
  void didChangeDependencies() {
    if(statusProgrress==DownloadTaskStatus.complete){
       print('complet down');
      Navigator.push(
          context,
          CustomPageRoute(  child:   HomePage())
      );

    }

  }
}
