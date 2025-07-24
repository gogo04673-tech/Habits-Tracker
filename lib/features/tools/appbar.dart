import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BarApp extends ConsumerWidget implements PreferredSizeWidget {
  const BarApp({
    super.key,
    required this.titlePage,
    this.iconButton,
    this.onPressed,
    this.leading = false,
    this.onTap,
  });
  final String titlePage;
  final Widget? iconButton;
  final void Function()? onPressed;
  final void Function()? onTap;
  final bool leading;

  @override
  Widget build(BuildContext context, ref) {
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

      // actions: [
      //   Consumer(
      //     builder: (context, ref, child) {
      //       return Builder(
      //         builder: (context) => IconButton(
      //           onPressed: () {
      //             ref.watch(ZoomNotifier).toggle!();
      //           },
      //           icon: const Icon(Icons.settings),
      //         ),
      //       );
      //     },
      //   ),
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
