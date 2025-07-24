import 'package:flutter/material.dart';
import 'package:habit_track/features/habit/habit.dart';
import 'package:habit_track/features/tools/icon.dart';

class AppearHabit extends StatefulWidget {
  const AppearHabit({super.key, this.onTap, required this.habit});
  final Habit habit;
  final void Function()? onTap;

  @override
  State<AppearHabit> createState() => _Habit();
}

class _Habit extends State<AppearHabit> {
  double countProgress() {
    double total = widget.habit.completedDays.length * (100 / 7);
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "${widget.habit.nameHabit[0].toUpperCase()}${widget.habit.nameHabit.substring(1)}",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        "SubTasks: ${widget.habit.subTasks.join(", ")}",
        style: Theme.of(context).textTheme.bodySmall,
      ),
      leading: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: widget.onTap,
        child: IconHabit(imagePath: widget.habit.icon),
      ),
      trailing: SizedBox(
        width: 80, // Adjust width as needed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "${countProgress().toStringAsFixed(2)}%", // Your progress number
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: countProgress() / 100, // 75% progress
              backgroundColor: Colors.grey,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              minHeight: 3,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
      ),
    );
  }
}
