import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartExample extends StatelessWidget {
  const BarChartExample({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * .4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),

          child: BarChart(

            BarChartData(

              alignment: BarChartAlignment.spaceBetween,
              maxY: 300,
              minY: -200,
              barTouchData: BarTouchData(enabled: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      switch (value.toInt()) {
                        case 0:
                          return Text('2010');
                        case 1:
                          return Text('2014');
                        case 2:
                          return Text('2016');
                        case 3:
                          return Text('2018');
                        case 4:
                          return Text('2020');
                        default:
                          return Text('');
                      }
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                  ),
                ),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: FlGridData(show: true),
              borderData: FlBorderData(show: false),
              barGroups: [
                BarChartGroupData(x: 0, barsSpace: 0, barRods: [
                  BarChartRodData(toY: 110, color: Colors.green, width: 20),
                ]),
                BarChartGroupData(x: 1, barsSpace: 0, barRods: [
                  BarChartRodData(toY: 110, color: Colors.green, width: 20),
                ]),
                BarChartGroupData(x: 2, barsSpace: 0, barRods: [
                  BarChartRodData(toY: -110, color: Colors.green, width: 20),
                ]),
                BarChartGroupData(x: 3, barsSpace: 0, barRods: [
                  BarChartRodData(toY: 110, color: Colors.green, width: 20),
                ]),
                BarChartGroupData(x: 4, barsSpace: 0, barRods: [
                  BarChartRodData(toY: 220, color: Colors.green, width: 20),
                ]),
              ],
            ),

          ),
        )
    );
  }
}