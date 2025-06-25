import 'package:flutter/material.dart';
import 'package:lkarnet/models/statistics/statistics_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../components.dart';

class SemiPeiWidget extends ConsumerWidget {
  final List<ItemsChartData> chartData;
  final String? title;
  final Widget widget;
  SemiPeiWidget(
      {Key? key, required this.chartData, required this.widget, this.title});

  @override
  Widget build(BuildContext context, wacth) {
    return SfCircularChart(
      title: ChartTitle(
          text: title ?? '', textStyle: Theme.of(context).textTheme.bodySmall),
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
          widget: Container(child: widget),
        )
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
              useSeriesColor: true),
          //angle of pie
        ),
      ],
    );
  }
}

class PeiWidget extends StatelessWidget {
  final List<ItemsChartData> chartData;
  final String? title;
  const PeiWidget({Key? key, required this.chartData, this.title});

  @override
  Widget build(BuildContext context) {
    if (chartData.isEmpty) {
      return Container();
    }
    if (chartData.isNotEmpty) {
      chartData.sort((a, b) => b.itemCalculations.totalPrice
          .compareTo(a.itemCalculations.totalPrice));
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
          text: title ?? '', textStyle: Theme.of(context).textTheme.bodySmall),
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
              useSeriesColor: true),

          // ending angle of pie
        ),
      ],
    );
  }
}

class LineChartWidgetDate extends StatelessWidget {
  final List<ItemsChartData> chartData;
  final String? title;

  const LineChartWidgetDate({Key? key, required this.chartData, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    chartData.sort((b, a) => a.date.compareTo(b.date));
    return SfCartesianChart(
      //  title: ChartTitle(
      //    text: title ?? '', textStyle: Theme.of(context).textTheme.bodySmall),
      margin: EdgeInsets.zero,
      legend: Legend(
        isVisible: true,
        position: LegendPosition.top,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: DateTimeAxis(
        majorGridLines: MajorGridLines(width: 0),
        dateFormat: DateFormat.MMMd(),
        intervalType: DateTimeIntervalType.days,
        labelRotation: 90,
      ),
      series: <ChartSeries>[
        SplineSeries<ItemsChartData, DateTime>(
          // sortingOrder: SortingOrder.ascending,
          //legendItemText: 'Item Price',
          name: 'Items Price',
          // legendIconType: LegendIconType.seriesType,
          dataSource: chartData,
          xValueMapper: (ItemsChartData data, _) => data.date,
          yValueMapper: (ItemsChartData data, _) =>
              data.itemCalculations.totalPrice,
          dataLabelMapper: (ItemsChartData data, _) =>
              DateFormat.MMMd().format(data.date),
          color: Colors.white.withOpacity(0.5),
          width: 1,
          enableTooltip: true,
          // name: 'Home',
          dataLabelSettings: DataLabelSettings(
              textStyle: Theme.of(context).textTheme.bodySmall,
              isVisible: false,
              labelPosition: ChartDataLabelPosition.inside,
              // Renders background rectangle and fills it with series color
              useSeriesColor: true),

          // ending angle of pie
        ),
      ],
    );
  }
}

class ColumnChartWidget extends StatelessWidget {
  final List<ItemsChartData> chartData;
  final String? title;
  const ColumnChartWidget({Key? key, required this.chartData, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    chartData
      ..sort((a, b) => b.itemCalculations.totalCount
          .compareTo(a.itemCalculations.totalCount));

    return SfCartesianChart(
      title: ChartTitle(
          text: title ?? '', textStyle: Theme.of(context).textTheme.bodySmall),
      // primaryXAxis: DateTimeAxis(),
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        labelRotation: 90,
      ),
      series: <ChartSeries>[
        // Renders spline chart
        ColumnSeries<ItemsChartData, String>(
          enableTooltip: true,
          width: 0.4,
          dataSource: chartData.limit(10),
          //color: AppConstants.whiteOpacity,
          color: Colors.white.withOpacity(0.5),
          xValueMapper: (ItemsChartData sales, _) => sales.tag,
          yValueMapper: (ItemsChartData sales, _) =>
              sales.itemCalculations.totalCount,
          //pointColorMapper: (Tagged sales, _) => sales.color,
          dataLabelMapper: (ItemsChartData sales, _) =>
              sales.itemCalculations.totalCount.toString(),
        ),
      ],
    );
  }
}
