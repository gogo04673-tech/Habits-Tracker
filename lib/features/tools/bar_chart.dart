import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HabitBarChart extends StatefulWidget {
  const HabitBarChart({
    super.key,
    required this.toYList,
    required this.listBar,
  });

  final List<double> toYList;
  final List listBar;

  @override
  State<HabitBarChart> createState() => _HabitBarChartState();
}

class _HabitBarChartState extends State<HabitBarChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 150,
        margin: const EdgeInsets.only(left: 20),
        child: TweenAnimationBuilder(
          tween: Tween<double>(
            begin: 0,
            end: widget.toYList.reduce((a, b) => a > b ? a : b),
          ),
          duration: const Duration(seconds: 2),
          builder: (context, valueAnimation, child) {
            return BarChart(
              BarChartData(
                maxY: 8,
                barTouchData: BarTouchData(
                  enabled: false,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipPadding: EdgeInsets.zero,
                    getTooltipItem: (_, __, ___, ____) => null,
                    getTooltipColor: (group) => Colors.transparent,
                  ),
                ),
                backgroundColor: Colors.transparent,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                alignment: BarChartAlignment.spaceAround,
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final columnList = widget.listBar;
                        return Text(
                          columnList[value.toInt()],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: List.generate(widget.listBar.length, (i) {
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: (widget.toYList[i] > valueAnimation)
                            ? valueAnimation
                            : widget.toYList[i],
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        width: 24,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
