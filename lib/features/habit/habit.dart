import 'package:uuid/uuid.dart';

class Habit {
  final String baseIcon;
  final String id;
  final String nameHabit;
  final String descHabit;
  final List<String> subTasks;
  final String frequency;
  String icon;
  final DateTime dateTime;
  final List<DateTime> completedDays;
  DateTime? lastCheckedDate; // <-- أضف هذا

  Habit({
    required this.baseIcon,
    String? id,
    required this.nameHabit,
    required this.descHabit,
    required this.subTasks,
    required this.frequency,
    required this.icon,
    required this.dateTime,
    List<DateTime>? completedDays,
    this.lastCheckedDate,
  }) : id = id ?? const Uuid().v4(),
      completedDays = completedDays ?? [];
}
