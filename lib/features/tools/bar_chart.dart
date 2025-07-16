import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:habit_track/controllers/habit/habit_provider.dart';
import 'package:provider/provider.dart';

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
        color: const Color(0xFF111C22),
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
                maxY: context.read<HabitProvider>().habits.length.toDouble(),
                backgroundColor: Colors.transparent,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                alignment: BarChartAlignment.spaceAround,
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
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
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: [
                  for (int i = 0; i < widget.listBar.length; i++)
                    BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: (widget.toYList[i] > valueAnimation)
                              ? valueAnimation
                              : widget.toYList[i],
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.15),
                          width: 24,
                          borderRadius: BorderRadius.circular(6),
                          rodStackItems: [
                            BarChartRodStackItem(
                              5.9,
                              6,
                              Colors.white,
                            ), // this border top
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
