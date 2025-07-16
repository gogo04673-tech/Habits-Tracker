import 'package:flutter/material.dart';
import 'package:habit_track/myTools/icon.dart';

class AppearHabit extends StatefulWidget {
  const AppearHabit({
    super.key,
    required this.title,
    required this.subtitle,
    required this.path,
    this.onTap,
  });
  final String title;
  final String subtitle;
  final String path;
  final void Function()? onTap;

  @override
  State<AppearHabit> createState() => _Habit();
}

class _Habit extends State<AppearHabit> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "${widget.title[0].toUpperCase()}${widget.title.substring(1)}",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        "SubTasks: ${widget.subtitle}",
        style: const TextStyle(color: Color.fromARGB(255, 189, 205, 214)),
      ),
      leading: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: widget.onTap,
        child: IconHabit(imagePath: widget.path),
      ),
      trailing: SizedBox(
        width: 80, // Adjust width as needed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              "75%", // Your progress number
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: 0.75, // 75% progress
              backgroundColor: Colors.white24,
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
