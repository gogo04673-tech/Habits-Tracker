import 'package:flutter/material.dart';
import 'package:habit_track/controllers/habit/habit_provider.dart';
import 'package:habit_track/controllers/models/state_service.dart';
import 'package:habit_track/features/tools/appbar.dart';
import 'package:habit_track/features/tools/bar_chart.dart';

import 'package:provider/provider.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPage();
}

class _StatsPage extends State<StatsPage> {
  double progressWeek = 14.285714286;

  List<double> countAllCompletionWeekly() {
    HabitProvider provider = Provider.of<HabitProvider>(context);

    List<DateTime> allCompletionHabit = provider.habits
        .expand((h) => h.completedDays)
        .toList();

    return StateService.getWeeklyCompletionCounts(
      allCompletionHabit,
    ).map((e) => e.toDouble()).toList();
  }

  int countProgressWeek() {
    List listWeek = countAllCompletionWeekly().where((n) => n > 0).toList();
    return (listWeek.length * progressWeek).toInt();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HabitProvider>(context);
    final now = DateTime.now();
    final data = StateService.getMonthlyHabitData(provider.habits, now);
    double countHabits = (25 / provider.habits.length);
    List<double> lst = data.map((n) => (n * countHabits)).toList();
    int monthProgress = lst.reduce((a, b) => a + b).toInt();

    return Scaffold(
      appBar: const BarApp(titlePage: 'Stats', icon: null),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const Text(
              "Weekly Progress",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              color: Colors.transparent, // لا خلفية
              elevation: 0, // لا ظل
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                // ignore: deprecated_member_use
                side: BorderSide(color: Colors.white.withOpacity(0.1)),
              ),
              borderOnForeground: true,
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Habits Completion",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${countProgressWeek()}%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),

                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "This Week ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "+10",
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ====================================
                    HabitBarChart(
                      toYList: countAllCompletionWeekly(),
                      listBar: const [
                        "Mon",
                        "Tus",
                        "Wen",
                        "Thu",
                        "Fri",
                        "Sat",
                        "Sun",
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Monthly Overview",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              color: Colors.transparent, // لا خلفية
              elevation: 0, // لا ظل
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                // ignore: deprecated_member_use
                side: BorderSide(color: Colors.white.withOpacity(0.1)),
              ),
              borderOnForeground: true,
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Habits Completion",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "$monthProgress%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),

                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "This Month ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "+10",
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // ====================================
                    HabitBarChart(
                      toYList: data,
                      listBar: const ["w1", "w2", "w3", "w4"],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
