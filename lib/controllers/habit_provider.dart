import 'package:flutter/material.dart';
import 'package:habit_track/habit/habit_class.dart';

class HabitProvider with ChangeNotifier {
  final List<Habit> _habits = [];

  HabitProvider() {
    _loadDefaultTestHabit(); // 👈 يتم تنفيذها مباشرة عند إنشاء الـ Provider
    _load2DefaultTestHabit(); // 👈 يتم تنفيذها مباشرة عند إنشاء الـ Provider
  }

  void _loadDefaultTestHabit() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final yesterdayDateOnly = DateTime(
      yesterday.year,
      yesterday.month,
      yesterday.day,
    );
    final today = DateTime.now();
    final todayDateOnly = DateTime(today.year, today.month, today.day);

    final testHabit = Habit(
      nameHabit: 'Drink Water 💧',
      descHabit: 'I drank 8 cups of water yesterday.',
      subTasks: [],
      frequency: 'Daily',
      baseIcon: 'icons/run.png',
      icon: 'icons/run.png',
      dateTime: DateTime.now(),
      completedDays: [yesterdayDateOnly, todayDateOnly],
    );

    _habits.add(testHabit);
  }

  void _load2DefaultTestHabit() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final yesterdayDateOnly = DateTime(
      yesterday.year,
      yesterday.month,
      yesterday.day,
    );
    // final twoday = DateTime.now().subtract(const Duration(days: 1));
    // final twodayDateOnly = DateTime(twoday.year, twoday.month, twoday.day);

    final testHabit = Habit(
      nameHabit: 'Run',
      descHabit: 'I drank 8 cups of water yesterday.',
      subTasks: ["subtask"],
      frequency: 'Daily',
      baseIcon: 'icons/run.png',
      icon: 'icons/run.png',
      dateTime: DateTime.now(),
      completedDays: [yesterdayDateOnly],
    );

    _habits.add(testHabit);
  }

  String pathImage = 'icons/run.png';
  String doneIcon = "icons/check.png";

  void changePathImage(String path) {
    pathImage = path;
    notifyListeners();
  }

  bool dailyColor = false;
  bool weekColor = false;
  bool daysColor = false;
  String frequency = "";

  // * frequency function is here
  void choiceDeadLine(bool daily, bool weekly, bool days, String freq) {
    dailyColor = daily;
    weekColor = weekly;
    daysColor = days;
    frequency = freq;
    notifyListeners();
  }

  List imagesPath = [
    'icons/book.png',
    'icons/run.png',
    'icons/muscle.png',
    'icons/pencil.png',
    'icons/sun.png',
    'icons/gym.png',
  ];

  List<Habit> get habits => _habits;

  void addHabit(Habit habit) {
    _habits.add(habit);
    notifyListeners();
  }

  void updateHabit(Habit habit) {
    final index = _habits.indexWhere((c) => c.id == habit.id);
    if (index != -1) {
      _habits[index] = habit;
      notifyListeners();
    }
  }

  DateTime _selectedDay = DateTime.now();

  DateTime get selectedDay => _selectedDay;

  void updateSelectedDay(DateTime newDay) {
    _selectedDay = newDay;
    notifyListeners();
  }

  bool isHabitCompletedOn(Habit habit, DateTime day) {
    final d = DateTime(day.year, day.month, day.day);
    return habit.completedDays.any(
      (completedDate) =>
          completedDate.year == d.year &&
          completedDate.month == d.month &&
          completedDate.day == d.day,
    );
  }

  void markHabitNotAsDone(Habit habit) {
    habit.icon = habit.baseIcon;
    notifyListeners();
  }

  void markHabitAsDone(Habit habit) {
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);
    habit.icon = doneIcon;
    habit.lastCheckedDate = todayOnly;
    notifyListeners();
  }

  void checkDailyReset() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (var habit in _habits) {
      if (habit.lastCheckedDate == null ||
          !isSameDay(habit.lastCheckedDate!, today)) {
        if (habit.icon == doneIcon) {
          habit.completedDays.add(yesterday);
        }
        habit.icon = habit.baseIcon;
        habit.lastCheckedDate = today;
      }
    }

    notifyListeners();
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
