import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:hikayati_app/core/app_theme.dart';
import 'package:hikayati_app/features/Settings/presintation/Widget/ChartCard.dart';

import '../../../../core/util/ScreenUtil.dart';
import '../../../../injection_container.dart';
import '../../date/model/ChartModel.dart';
import '../Widget/ChartCard.dart';
import '../Widget/ReportTapbarPage.dart';
import '../managerChart/Chart_bloc.dart';
import '../managerChart/Chart_event.dart';
import '../managerChart/Chart_state.dart';
class ChartPage extends StatefulWidget {
  final id;
   ChartPage({Key? key, required this.id,}) : super(key: key);


  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  _ChartPageState();
  ScreenUtil screenUtil=ScreenUtil();
bool visiblety=false;
  Widget ChartWidget=Center();
  var path;


  /// Builds the widget that is the home page state.
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return  BlocProvider(
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
                .add(GetAllChart(id: widget.id.toString()));
          }

          if (state is ChartLoading) {
            ChartWidget = CircularProgressIndicator();
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
                                       visiblety=true;
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
                      return ChartCard(
                        text: state.chartModel[index].text,
                        photo: path +'/'+ state.chartModel[index]!.photo
                            .toString(),
                        accuracy_stars: state.chartModel[index].accuracy_stars,
                        text_readd: state.chartModel[index].readed_text,
                        page_no: state.chartModel[index].page_no.toString(),


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

    dataRows:  [
      stars,

    ],
    xUserLabels:  num,
    dataRowsLegends: const [
      'المستوى الأول: ذات الرداء الأحمر',

    ],
    yUserLabels: ['1','2','3'],
    dataRowsColors: [
      AppTheme.primarySwatch.shade300
    ],

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

