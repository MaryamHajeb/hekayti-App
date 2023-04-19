import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikayati_app/core/app_theme.dart';

import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/widgets/CustemIcon.dart';
import '../../../../injection_container.dart';
import '../../../Story/presintation/manager/Slied_bloc.dart';
import '../../../Story/presintation/manager/Slied_event.dart';
import '../../../Story/presintation/manager/Slied_state.dart';
import '../Widget/ReportTapbarPage.dart';
import '../Widget/SettingTapbarpage.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  ScreenUtil screenUtil=ScreenUtil();

  Widget build(BuildContext context) {
    screenUtil.init(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(body:  Directionality(
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
                      story_id: '1', tableName: 'meadia'));
                }

                if (state is SliedLoading) {
                  return CircularProgressIndicator();
                }

                if (state is SliedILoaded) {
                  //TODO::Show Slied here

                  return  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: SingleChildScrollView(
                          child: Container(

                            decoration: BoxDecoration(


                            ),
                            height:  screenUtil.screenHeight * 1,
                            width:screenUtil.screenWidth *1,

                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 4, color: AppTheme.primarySwatch.shade500),
                                    borderRadius: BorderRadius.all(Radius.circular(10))),
                                child: SingleChildScrollView(
                                  child: Column(children: [
                                    Container(
                                      color: AppTheme.primarySwatch.shade200,
                                      child: TabBar(
                                          labelStyle: TextStyle(fontSize: 20,fontFamily: AppTheme.fontFamily),
                                          automaticIndicatorColorAdjustment: false,
                                          overlayColor: MaterialStateProperty.all(Colors.orange),
                                          labelColor: Colors.brown,
                                          dividerColor: Colors.brown,
                                          indicatorColor: Colors.brown,
                                          unselectedLabelColor: Colors.brown,

                                          tabs: [

                                            Tab(text:  'الأعدادات',),
                                            Tab(text:  'تقارير التقدم',),

                                          ]),
                                    ),
                                    SizedBox(height: 30,),
                                    Container(
                                      width: double.infinity,
                                      height: screenUtil.screenHeight *.8,
                                      child: TabBarView(children: [
                                        Expanded(child: SettingTapbarpage()),
                                        Expanded(child: ReportTapbarPage())


                                      ]),
                                    )
                                  ]),
                                ),

                              ),
                            ),
                          ),
                        )),

                  );
                }

                return Container();
              },
            ),
          )),
    ),
    );
  }
}
