import 'package:flutter/material.dart';

class BarApp extends StatelessWidget implements PreferredSizeWidget {
  const BarApp({
    super.key,
    required this.titlePage,
    this.icon,
    this.onPressed,
    this.leading = false,
    this.onTap,
  });
  final String titlePage;
  final IconData? icon;
  final void Function()? onPressed;
  final void Function()? onTap;
  final bool leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: !leading
          ? null
          : IconButton(
              onPressed: onTap,
              icon: const Icon(Icons.arrow_back),
              color: Theme.of(context).colorScheme.primary,
            ),
      centerTitle: true,
      title: Text(
        titlePage,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),

      actions: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          iconSize: 30,
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
