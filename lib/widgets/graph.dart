import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:voting_system/models/Option.dart';

class Graph extends StatelessWidget {
  const Graph({
    Key? key,
    required this.options,
  }) : super(key: key);
  final List<Option> options;
  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {};

    for (var option in options) {
      dataMap.putIfAbsent(option.title, () => option.votes.toDouble());
    }

    return options.isEmpty
        ? const SizedBox()
        : PieChart(
            chartType: ChartType.ring,
            dataMap: dataMap,
            chartRadius: 200,
            ringStrokeWidth: 14,
            animationDuration: const Duration(seconds: 1),
            legendOptions: const LegendOptions(
              legendPosition: LegendPosition.right,
              legendTextStyle: TextStyle(
                color: Colors.black87,
              ),
            ),
            baseChartColor: Colors.grey[50]!.withOpacity(0.15),
            chartValuesOptions: const ChartValuesOptions(
              showChartValuesInPercentage: true,
              chartValueStyle: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              showChartValueBackground: false,
            ),
          );
  }
}
