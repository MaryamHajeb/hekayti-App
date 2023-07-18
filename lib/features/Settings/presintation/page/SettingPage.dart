import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:hikayati_app/core/app_theme.dart';
import 'package:hikayati_app/features/Settings/presintation/Widget/ChartCard.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/widgets/CustemIcon.dart';
import '../../../../injection_container.dart';
import '../../../../main.dart';
import '../../../Story/presintation/manager/Slied_bloc.dart';
import '../../../Story/presintation/manager/Slied_event.dart';
import '../../../Story/presintation/manager/Slied_state.dart';
import '../../date/model/ChartModel.dart';
import '../Widget/ReportCard.dart';
import '../Widget/SettingTapbarpage.dart';
import '../managerChart/Chart_bloc.dart';
import '../managerChart/Chart_event.dart';
import '../managerChart/Chart_state.dart';
import '../managerReport/Report_bloc.dart';
import '../managerReport/Report_event.dart';
import '../managerReport/Report_state.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  ScreenUtil screenUtil=ScreenUtil();
  bool visible=true;
  TextEditingController nameChiled =TextEditingController();
  int idChart=0;
  Widget ReportWidget=Center();
  var path;
  String nameStory='';
  Widget ChartWidget=Center();

  Widget build(BuildContext context) {
    screenUtil.init(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(body: Directionality(
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

                                Tab(text:  'الإعــدادات',),
                                Tab(text:  'تـقـارير الـتـقـدم',),

                              ]),
                        ),

                        Container(
                          width: double.infinity,
                          height: screenUtil.screenHeight *.8,
                          child: TabBarView(children: [
                            SettingTapbarpage(),
                            Column(
                              children: [
                                Visibility(
                                    visible: visible,
                                    replacement:Expanded(child: BlocProvider(
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
                                            ChartWidget = Center(child:
                                            Lottie.asset("assets/json/loading.json",width: 250,));
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
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Row(
                                                                  children: [
                                                                    IconButton(onPressed: (){
                                                                      setState(() {
                                                                        visible=!visible;
                                                                      });
                                                                    }, icon: Icon(Icons.arrow_back_outlined,size: 30,color: AppTheme.primaryColor,),)
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 9,
                                                                child: Container(
                                                                  width: screenUtil.screenWidth *.48,
                                                                  height: screenUtil.screenHeight *.7,

                                                                  child: chartToRun(state.chartModel),
                                                                ),
                                                              ),
                                                            ],
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(child:
                                                    ListView.builder(itemCount: state.chartModel.length,itemBuilder: (context, index) {
                                                      return InkWell(
                                                        child: ChartCard(
                                                          text: state.chartModel[index].text,
                                                          photo: path +'/'+ state.chartModel[index]!.photo
                                                              .toString(),
                                                          accuracy_stars: state.chartModel[index].accuracy_stars,
                                                          text_readd: state.chartModel[index].readed_text,
                                                          page_no: state.chartModel[index].page_no.toString(),


                                                        ),
                                                      );
                                                    },),),



                                                  ],
                                                ),

                                              ),
                                            );
                                          }

                                          return ChartWidget;
                                        },
                                      ),
                                    )) ,
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
                                            BlocProvider.of<ReportBloc>(_context)
                                                .add(GetAllReport());
                                          }

                                          if (state is ReportLoading) {
                                            ReportWidget = Center(child:
                                            Lottie.asset("assets/json/loading.json",width: 250,));
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

                                                    return InkWell(
                                                      onTap: (){
                                                        setState(() {
                                                          nameStory=state.reportModel[index].name;
                                                          idChart=state.reportModel[index].id;
                                                          visible=!visible;

                                                        });
                                                      },
                                                      child: ReportCard(
                                                        id: state.reportModel[index].id,
                                                        cover_photo:path+'/'+ state.reportModel[index].cover_photo
                                                        ,name: state.reportModel[index].name,
                                                        percentage: state.reportModel[index].percentage,
                                                        stars: state.reportModel[index].stars,

                                                      ),
                                                    );
                                                  },),
                                                )
                                              ],
                                            );
                                          }

                                          return ReportWidget;
                                        },
                                      ),
                                    )),
                              ],
                            )


                          ]),
                        )
                      ]),
                    ),

                  ),
                ),
              ),
            )),

      ),
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
    var externalDirectoryPath = await AndroidPathProvider.downloadsPath;
    path=  externalDirectoryPath.toString();
  }



  Widget chartToRun(List<ChartModel> chartModel) {
    List<double> stars=[];
    List<String> num=[];

    chartModel.forEach((element) {
      print(element.accuracy_stars);

      print('element.accuracy_stars');
      stars.add(double.parse(element.accuracy_stars.toString()));

    });
    chartModel.forEach((element) {
      num.add(element.page_no.toString());
    });

    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions(
        legendOptions: LegendOptions(legendItemIndicatorToLabelPad: 80,),
        dataContainerOptions: DataContainerOptions(gridLinesColor: Colors.transparent,),
        xContainerOptions: XContainerOptions(xBottomMinTicksHeight: 15,)
    );
    // Example with side effects cannot be simply pasted to your code, as the _ExampleSideEffects is private
    // This example shows the result with sufficient space to show all labels, not even tilted;
    // The iterative layout strategy causes more labels to be skipped.
    chartData = ChartData(

      dataRows:[
        stars,

      ],
      xUserLabels:  num.toList(),
      dataRowsLegends:  [
        '$nameStory',
      ],

      yUserLabels: ['1','2','3'],
      dataRowsColors: [AppTheme.primarySwatch.shade300],

      chartOptions: chartOptions,
    );


    var verticalBarChartContainer = VerticalBarChartTopContainer(
      chartData: chartData,

      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var verticalBarChart = VerticalBarChart(
      painter: VerticalBarChartPainter(
        verticalBarChartContainer: verticalBarChartContainer,
      ),
    );
    return verticalBarChart;
  }

}
