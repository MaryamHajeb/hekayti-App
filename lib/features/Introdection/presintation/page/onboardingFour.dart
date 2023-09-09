import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:hikayati_app/features/Regestrion/date/model/userMode.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/Carecters.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/CastemCarecters.dart';

class onboardingFour extends StatefulWidget {
  const onboardingFour({Key? key}) : super(key: key);

  @override
  State<onboardingFour> createState() => _onboardingFourState();
}

class _onboardingFourState extends State<onboardingFour> {
  ScreenUtil screenUtil = ScreenUtil();
  @override
  Carecters carecterslist = Carecters();
  static int itemSelected = 0;
  ReceivePort _port = ReceivePort();
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('اختر  شخصيك المفضلة', style: AppTheme.textTheme.displaySmall),
        Container(
          height: screenUtil.screenHeight * .4,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: carecterslist.listcarecters.length,
            itemBuilder: (context, index) {
              return CustemCarecters(
                image: carecterslist.listcarecters[index]['image'].toString(),
                onTap: () async {
                  setState(() {
                    itemSelected = index;
                  });

                  int dd = int.parse(carecterslist.listcarecters[itemSelected]
                          ['id']
                      .toString());
                  UserModel? usermodel =
                      getCachedDate('UserInformation', UserModel.init());

                  CachedDate(
                      'UserInformation',
                      UserModel(
                          user_name: usermodel?.user_name,
                          email: usermodel?.email,
                          level: usermodel?.level,
                          character: itemSelected.toString(),
                          update_at: DateTime.now().toString(),
                          password: usermodel?.password,
                          id: usermodel?.id));
                },
                isSelected: itemSelected == index ? true : false,
              );
            },
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = DownloadTaskStatus(data[1]);
      int progress = data[2];
      setState((){ });
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }
}
