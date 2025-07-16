import 'package:flutter/material.dart';

class IconHabit extends StatefulWidget {
  const IconHabit({super.key, required this.imagePath});
  final String imagePath;

  @override
  State<IconHabit> createState() => _Icon();
}

class _Icon extends State<IconHabit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: const Color(0xFF243b47),
        borderRadius: BorderRadius.circular(10),
      ),
      // child: const Icon(Icons.book, color: Colors.white),
      child: Image.asset(widget.imagePath, color: Colors.white, width: 25),
    );
  }
}
