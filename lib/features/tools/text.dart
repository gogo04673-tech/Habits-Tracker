import 'package:flutter/material.dart';

class MainText extends StatefulWidget {
  const MainText({super.key, required this.text});
  final String text;

  @override
  State<MainText> createState() => _MainText();
}

class _MainText extends State<MainText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        widget.text, // * "Today's Quote"
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
