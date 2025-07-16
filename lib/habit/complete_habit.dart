import 'package:flutter/material.dart';
import 'package:habit_track/myTools/icon.dart';

class AppearCompleteHabit extends StatefulWidget {
  const AppearCompleteHabit({
    super.key,
    required this.title,
    required this.pathIcon,
    required this.isDone,
    this.onTap,
  });
  final String title;
  final String pathIcon;
  final bool isDone;
  final void Function()? onTap;

  @override
  State<AppearCompleteHabit> createState() => _AppearCompleteHabit();
}

class _AppearCompleteHabit extends State<AppearCompleteHabit> {
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

      leading: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: widget.onTap,
        child: IconHabit(imagePath: widget.pathIcon),
      ),

      trailing: Icon(
        Icons.circle,
        color: widget.isDone ? Colors.green : Colors.grey,
        size: 12,
      ),
    );
  }
}
