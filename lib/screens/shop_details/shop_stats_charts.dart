import 'package:flutter/material.dart';
import 'package:lkarnet/models/statistics/statistics_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../components.dart';

class SemiPeiWidget extends ConsumerWidget {
  final List<ItemsChartData> chartData;
  final String? title;
  final Widget widget;
  const SemiPeiWidget({
    super.key,
    required this.chartData,
    required this.widget,
    this.title,
  });

  @override
  Widget build(BuildContext context, wacth) {
    return SfCircularChart(
      title: ChartTitle(
        text: title ?? '',
        textStyle: Theme.of(context).textTheme.bodySmall,
      ),
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(widget: Container(child: widget)),
      ],
      margin: EdgeInsets.zero,
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CircularSeries>[
        DoughnutSeries<ItemsChartData, String>(
          innerRadius: '80',
          dataSource: chartData,
          xValueMapper: (ItemsChartData data, _) => data.tag,
          yValueMapper: (ItemsChartData data, _) => data.value,
          dataLabelMapper: (ItemsChartData data, _) => data.tag,

          // All the segments will be exploded
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.outside,
            // Renders background rectangle and fills it with series color
            useSeriesColor: true,
          ),
          //angle of pie
        ),
      ],
    );
  }
}

class PeiWidget extends StatelessWidget {
  final List<ItemsChartData> chartData;
  final String? title;
  const PeiWidget({super.key, required this.chartData, this.title});

  @override
  Widget build(BuildContext context) {
    if (chartData.isEmpty) {
      return Container();
    }
    if (chartData.isNotEmpty) {
      chartData.sort(
        (a, b) => b.itemCalculations.totalPrice.compareTo(
          a.itemCalculations.totalPrice,
        ),
      );
    }

    return SfCircularChart(
      margin: EdgeInsets.zero,
      legend: Legend(
        isVisible: true,
        position: LegendPosition.right,
        // alignment: ChartAlignment.center,
        // width: '120',
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      title: ChartTitle(
        text: title ?? '',
        textStyle: Theme.of(context).textTheme.bodySmall,
      ),
      series: <CircularSeries>[
        PieSeries<ItemsChartData, String>(
          radius: '90%',
          dataSource: chartData.limit(10),
          xValueMapper: (ItemsChartData data, _) => data.tag,
          yValueMapper: (ItemsChartData data, _) =>
              data.itemCalculations.totalPrice,
          dataLabelMapper: (ItemsChartData data, _) =>
              data.itemCalculations.totalCount.toString(),
          explode: false,

          explodeAll: true,
          enableTooltip: true,
          // name: 'Home',
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.inside,
            // Renders background rectangle and fills it with series color
            useSeriesColor: true,
          ),

          // ending angle of pie
        ),
      ],
    );
  }
}

class LineChartWidgetDate extends StatelessWidget {
  final List<ItemsChartData> chartData;
  final String? title;

  const LineChartWidgetDate({super.key, required this.chartData, this.title});

  @override
  Widget build(BuildContext context) {
    chartData.sort((b, a) => a.date.compareTo(b.date));
    return SfCartesianChart(
      //  title: ChartTitle(
      //    text: title ?? '', textStyle: Theme.of(context).textTheme.bodySmall),
      margin: EdgeInsets.zero,
      legend: Legend(isVisible: true, position: LegendPosition.top),
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: DateTimeAxis(
        majorGridLines: MajorGridLines(width: 0),
        dateFormat: DateFormat.MMMd(),
        intervalType: DateTimeIntervalType.days,
        labelRotation: 90,
      ),
      series: [],
    );
  }
}

class ColumnChartWidget extends StatelessWidget {
  final List<ItemsChartData> chartData;
  final String? title;
  const ColumnChartWidget({super.key, required this.chartData, this.title});

  @override
  Widget build(BuildContext context) {
    chartData.sort(
      (a, b) => b.itemCalculations.totalCount.compareTo(
        a.itemCalculations.totalCount,
      ),
    );

    return SfCartesianChart(
      title: ChartTitle(
        text: title ?? '',
        textStyle: Theme.of(context).textTheme.bodySmall,
      ),
      // primaryXAxis: DateTimeAxis(),
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        labelRotation: 90,
      ),
      series: [],
    );
  }
}
