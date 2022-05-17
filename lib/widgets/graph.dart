import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:voting_system/models/band.dart';

class Graph extends StatelessWidget {
  const Graph({
    Key? key,
    required this.bands,
  }) : super(key: key);
  final List<Band> bands;
  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {};

    for (var band in bands) {
      dataMap.putIfAbsent(band.name, () => band.votes.toDouble());
    }

    return PieChart(
      chartType: ChartType.ring,
      dataMap: dataMap,
      chartRadius: 200,
      ringStrokeWidth: 14,
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
