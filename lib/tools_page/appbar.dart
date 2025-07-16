import 'package:flutter/material.dart';

class BarApp extends StatelessWidget implements PreferredSizeWidget {
  const BarApp({
    super.key,
    required this.titlePage,
    this.icon,
    this.onPressed,
  });
  final String titlePage;
  final IconData? icon ;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        titlePage,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xFF111C22),
      actions: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          iconSize: 30,
          color: Colors.white,
        ),
      ],
    );
  }

  @override
  Size get preferredSize =>  const Size.fromHeight(kToolbarHeight);


}