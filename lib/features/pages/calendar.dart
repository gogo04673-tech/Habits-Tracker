import 'package:flutter/material.dart';
import 'package:habit_track/controllers/habit/habit_provider.dart';
import 'package:habit_track/features/habit/complete_habit.dart';
import 'package:habit_track/features/habit/habit.dart';
import 'package:habit_track/features/tools/appbar.dart';
import 'package:habit_track/features/tools/calendar_table.dart';

import 'package:provider/provider.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPage();
}

class _CalendarPage extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarApp(titlePage: 'Calendar'),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // * Calendar is here
            const CalendarTable(),

            // * Text of Habits Complete
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: const Text(
                "Habits Completion",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

            // * show completion habits
            Expanded(
              child: Consumer<HabitProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                    itemCount: provider.habits.length,
                    itemBuilder: (context, index) {
                      Habit habit = provider.habits[index];
                      bool isDone = provider.isHabitCompletedOn(
                        habit,
                        provider.selectedDay,
                      );

                      return !isDone
                          ? null
                          : AppearCompleteHabit(
                              title: habit.nameHabit,
                              pathIcon: habit.baseIcon,
                              isDone: isDone,
                            );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
