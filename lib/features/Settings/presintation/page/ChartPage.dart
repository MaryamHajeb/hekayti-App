import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:hikayati_app/core/app_theme.dart';
import 'package:hikayati_app/features/Settings/presintation/Widget/ChartCard.dart';

import '../Widget/ReportCard.dart';
class ChartPage extends StatefulWidget {
  const ChartPage({Key? key,}) : super(key: key);


  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  _ChartPageState();



  /// Builds the widget that is the home page state.
  @override
  Widget build(BuildContext context) {
    return  Directionality(
       textDirection: TextDirection.rtl,
      child: Center(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    Expanded(
                      // #### Core chart
                      child: chartToRun(), // verticalBarChart, lineChart
                    ),

                  ],
                ),
              ),
              Expanded(child:  ListView.builder(itemCount: 20,itemBuilder: (context, index) {
                return ChartCard();
              },),),



            ],
          ),

      ),
    );
  }


}

Widget chartToRun() {
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

    dataRows: const [
      [90.0, 80.0, 70.0, 60.0, 50.0, 40.0,30,20,10,5],

    ],
    xUserLabels: const ['1', '2', '3', '4', '5', '6','7','8','9','10'],
    dataRowsLegends: const [
      'المستوى الأول: ذات الرداء الأحمر',

    ],
    yUserLabels: ['10%','20%','30%','40%','50%','60%','70%','80%','90%','100%'],
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