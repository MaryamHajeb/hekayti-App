import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:hikayati_app/core/app_theme.dart';
import 'package:hikayati_app/features/Settings/presintation/Widget/ChartCard.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/widgets/CustomPageRoute.dart';
import '../../../../injection_container.dart';
import '../../../../main.dart';
import '../../../Home/presintation/page/HomePage.dart';
import '../../date/model/ChartModel.dart';
import '../Widget/ReportCard.dart';
import 'ReportPage.dart';
import 'SettingPage.dart';
import '../managerChart/Chart_bloc.dart';
import '../managerChart/Chart_event.dart';
import '../managerChart/Chart_state.dart';
import '../managerReport/Report_bloc.dart';
import '../managerReport/Report_event.dart';
import '../managerReport/Report_state.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  @override
  ScreenUtil screenUtil = ScreenUtil();
  bool visible = true;
  TextEditingController nameChiled = TextEditingController();
  int idChart = 0;
  Widget ReportWidget = Center();
  String nameStory = '';
  Widget ChartWidget = Center();

  Widget build(BuildContext context) {
    screenUtil.init(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context, CustomPageRoute(child: HomePage()));
        return Future.value(false);
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
                child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(),
                height: screenUtil.screenHeight * 1,
                width: screenUtil.screenWidth * 1,
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
                              labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontFamily: AppTheme.fontFamily),
                              automaticIndicatorColorAdjustment: false,
                              overlayColor:
                                  MaterialStateProperty.all(Colors.orange),
                              labelColor: Colors.brown,
                              dividerColor: Colors.brown,
                              indicatorColor: Colors.brown,
                              unselectedLabelColor: Colors.brown,
                              tabs: [
                                Tab(
                                  text: 'الإعــدادات',
                                ),
                                Tab(
                                  text: 'تـقـارير  الـتـقـدم',
                                ),
                              ]),
                        ),
                        Container(
                          width: double.infinity,
                          height: screenUtil.screenHeight * .8,
                          child: TabBarView(
                              children: [SettingPage(), ReportPage()]),
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }

  Widget chartToRun(List<ChartModel> chartModel) {
    var verticalBarChart = Column(
      children: [
        Text(
          nameStory,
          style: AppTheme.textTheme.displaySmall,
        ),
        Expanded(
          child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(minimum: 0, maximum: 3, interval: 1),
              series: <CartesianSeries<ChartModel, String>>[
                ColumnSeries<ChartModel, String>(
                    dataSource: chartModel,
                    xValueMapper: (ChartModel data, _) =>
                        data.page_no.toString(),
                    yValueMapper: (ChartModel data, _) =>
                        data.accuracy_stars.toDouble(),
                    color: AppTheme.primarySwatch.shade700)
              ]),
        ),
      ],
    );
    return verticalBarChart;
  }
}
