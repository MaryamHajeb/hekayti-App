import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../injection_container.dart';
import '../../../../main.dart';
import '../managerReport/Report_bloc.dart';
import '../managerReport/Report_event.dart';
import '../managerReport/Report_state.dart';
import 'ReportCard.dart';

class ReportTapbarPage extends StatefulWidget {
  const ReportTapbarPage({Key? key}) : super(key: key);

  @override
  State<ReportTapbarPage> createState() => _ReportTapbarPageState();
}

class _ReportTapbarPageState extends State<ReportTapbarPage> {
  TextEditingController nameChiled =TextEditingController();
  ScreenUtil screenUtil=ScreenUtil();
 Widget ReportWidget=Center();
  var path;
  @override

  Widget build(BuildContext context) {
    screenUtil.init(context);

    return BlocProvider(
      create: (context) => sl<ReportBloc>(),
      child: BlocConsumer<ReportBloc, ReportState>(
        listener: (_context, state) {
          if (state is ReportError) {
            print(state.errorMessage);
          }
        },
        builder: (_context, state) {
          if (state is ReportInitial) {
            BlocProvider.of<ReportBloc>(_context)
                .add(GetAllReport());
          }

          if (state is ReportLoading) {
            ReportWidget = CircularProgressIndicator();
          }

          if (state is ReportILoaded) {
            // //TODO::Show Report here
            ReportWidget =
                state.reportModel.length==0?
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                  Center(child: Text('لم يتم اكمال اي قصه بعد',style: AppTheme.textTheme.headline2,))])
                    :
                Column(
              children: [
                Divider(color: AppTheme.primaryColor,),
                Container(
                  height: screenUtil.screenHeight * .7 ,
                  width: double.infinity,
                  child: ListView.builder(itemCount: state.reportModel.length,itemBuilder: (context, index) {
                    idfrochart =state.reportModel[index].id;

                    return ReportCard(
                      id: state.reportModel[index].id,
                      cover_photo:path+'/'+ state.reportModel[index].cover_photo
                      ,name: state.reportModel[index].name,
                      percentage: state.reportModel[index].percentage,
                      stars: state.reportModel[index].stars,

                    );
                  },),
                )
              ],
            );
          }

          return ReportWidget;
        },
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initpath();

  }
  initpath()async{
    final downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
    path=  downloadsDirectory.path;
  }
}
