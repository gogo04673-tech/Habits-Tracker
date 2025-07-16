import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:habit_track/controllers/state_service.dart';

class HabitProgressCard extends StatefulWidget {
  const HabitProgressCard({super.key, required this.completeDays});
  final List<DateTime> completeDays;

  @override
  State<HabitProgressCard> createState() => _HabitProgressCardState();
}

class _HabitProgressCardState extends State<HabitProgressCard> {
  late double weeklyProgress;
  final double changePercent = 0.10;

  @override
  void initState() {
    weeklyProgress = widget.completeDays.length * 0.1;
    super.initState();
  }

  List count() {
    List c = StateService.getWeeklyCompletionCounts(widget.completeDays);
    List counts = List.generate(c.length, (i) {
      return c[i] * weeklyProgress;
    });

    return counts;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111C22),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(seconds: 2),
        builder: (context, animationValue, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Line Chart with Animation
              SizedBox(
                height: 140,
                child: LineChart(
                  LineChartData(
                    minX: -0.5,
                    maxX: 6.5,
                    minY: 0,
                    maxY: 1,
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (value, _) {
                            const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                            if (value >= 0 &&
                                value <= 6 &&
                                value == value.toInt()) {
                              return Text(
                                days[value.toInt()],
                                style: const TextStyle(
                                  color: Colors.white38,
                                  fontSize: 10,
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                          reservedSize: 20,
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(-0.5, count()[0] * animationValue),
                          ...List.generate(
                            count().length,
                            (i) => FlSpot(
                              i.toDouble(),
                              count()[i] * animationValue,
                            ),
                          ),
                          FlSpot(6.5, count()[6] * animationValue),
                        ],
                        isCurved: true,
                        color: Colors.white,
                        barWidth: 2,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              // ignore: deprecated_member_use
                              Colors.white.withOpacity(0.3 * animationValue),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
