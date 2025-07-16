

import 'package:habit_track/features/habit/habit.dart';

class StateService {
  // get date now of today
  static getToday() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  // * get start of week day
  static getStartOfWeek() {
    DateTime today = getToday();
    return today.subtract(Duration(days: today.weekday - 1));
  }

  static List<DateTime> getDaysInCurrentWeek() {
    final start = getStartOfWeek();
    return List.generate(7, (i) {
      return start.add(Duration(days: i));
    });
  }

  static bool isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  static int countHabitsCompletedInDay({
    required List<DateTime> completedDays,
    required DateTime day,
  }) {
    return completedDays.where((d) => isSameDay(d, day)).length;
  }

  static DateTime cleanDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static List<int> getWeeklyCompletionCounts(List<DateTime> completedDays) {
    final weekDays = getDaysInCurrentWeek();
    return weekDays.map((day) {
      return countHabitsCompletedInDay(completedDays: completedDays, day: day);
    }).toList();
  }

  // ! Monthly
  static List<double> getMonthlyHabitData(
    List<Habit> habits,
    DateTime monthDate,
  ) {
    List<double> weeklyCounts = [0, 0, 0, 0];

    for (var habit in habits) {
      for (var date in habit.completedDays) {
        if (date.year == monthDate.year && date.month == monthDate.month) {
          int weekIndex = ((date.day - 1) ~/ 7);
          if (weekIndex < 4) {
            print(weekIndex);
            weeklyCounts[weekIndex]++;
          }
        }
      }
    }

    return weeklyCounts.map((e) => e.toDouble()).toList();
  }
}
