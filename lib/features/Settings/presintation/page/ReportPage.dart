import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/AppTheme.dart';
import '../../../../injection_container.dart';
import '../../../../main.dart';
import '../../date/model/ChartModel.dart';
import '../Widget/ChartCard.dart';
import '../Widget/ReportCard.dart';
import '../managerChart/Chart_bloc.dart';
import '../managerChart/Chart_event.dart';
import '../managerChart/Chart_state.dart';
import '../managerReport/Report_bloc.dart';
import '../managerReport/Report_event.dart';
import '../managerReport/Report_state.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  bool visible = true;
  Widget ChartWidget = Center();
  Widget ReportWidget = Center();
  ScreenUtil screenUtil = ScreenUtil();
  String nameStory = '';
  int idChart = 0;
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Column(
      children: [
        Visibility(
            visible: visible,
            replacement: Expanded(
                child: BlocProvider(
              create: (context) => sl<ChartBloc>(),
              child: BlocConsumer<ChartBloc, ChartState>(
                listener: (_context, state) {
                  if (state is ChartError) {
                    print(state.errorMessage);
                  }
                },
                builder: (_context, state) {
                  if (state is ChartInitial) {
                    print('the id chart is ');
                    BlocProvider.of<ChartBloc>(_context)
                        .add(GetAllChart(id: idChart.toString()));
                  }

                  if (state is ChartLoading) {
                    ChartWidget = Center(
                        child: Lottie.asset(
                      "assets/json/animation_report.json",
                      width: 250,
                    ));
                  }

                  if (state is ChartILoaded) {
                    // //TODO::Show Chart here

                    ChartWidget = Directionality(
                      textDirection: TextDirection.rtl,
                      child: Center(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  visible = !visible;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.arrow_back_outlined,
                                                size: 30,
                                                color: AppTheme.primaryColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 9,
                                        child: Container(
                                          width: screenUtil.screenWidth * .48,
                                          height: screenUtil.screenHeight * .7,
                                          child: chartToRun(state.chartModel),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.chartModel.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    child: ChartCard(
                                      text: state.chartModel[index].text,
                                      photo: path +
                                          '/' +
                                          state.chartModel[index].image
                                              .toString(),
                                      accuracy_stars: state
                                          .chartModel[index].accuracy_stars,
                                      text_readd:
                                          state.chartModel[index].readed_text,
                                      page_no: state.chartModel[index].page_no
                                          .toString(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ChartWidget;
                },
              ),
            )),
            child: BlocProvider(
              create: (context) => sl<ReportBloc>(),
              child: BlocConsumer<ReportBloc, ReportState>(
                listener: (_context, state) {
                  if (state is ReportError) {
                    print(state.errorMessage);
                  }
                },
                builder: (_context, state) {
                  if (state is ReportInitial) {
                    BlocProvider.of<ReportBloc>(_context).add(GetAllReport());
                  }

                  if (state is ReportLoading) {
                    ReportWidget = Center(
                        child: Lottie.asset(
                      "assets/json/animation_report.json",
                      width: 250,
                    ));
                  }

                  if (state is ReportILoaded) {
                    // //TODO::Show Report here
                    ReportWidget = state.reportModel.length == 0
                        ? SizedBox(
                            height: screenUtil.screenHeight * .8,
                            width: double.infinity,
                            child: Center(
                                child: Text(
                              'لم يتم اكمال اي قصه بعد',
                              style: AppTheme.textTheme.displayMedium,
                            )),
                          )
                        : Column(
                            children: [
                              Divider(
                                color: AppTheme.primaryColor,
                              ),
                              Container(
                                height: screenUtil.screenHeight * .7,
                                width: double.infinity,
                                child: ListView.builder(
                                  itemCount: state.reportModel.length,
                                  itemBuilder: (context, index) {
                                    idfrochart = state.reportModel[index].id;

                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          nameStory =
                                              state.reportModel[index].name;
                                          idChart = state.reportModel[index].id;
                                          visible = !visible;
                                        });
                                      },
                                      child: ReportCard(
                                        id: state.reportModel[index].id,
                                        cover_photo: path +
                                            '/' +
                                            state
                                                .reportModel[index].cover_photo,
                                        name: state.reportModel[index].name,
                                        percentage:
                                            state.reportModel[index].percentage,
                                        stars: state.reportModel[index].stars,
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          );
                  }
                  return ReportWidget;
                },
              ),
            )),
      ],
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
