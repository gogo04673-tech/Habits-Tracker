import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_track/controllers/state_management/habit_provider.dart';
import 'package:habit_track/features/tools/icon.dart';

import 'package:provider/provider.dart';

class DialogIcons extends StatefulWidget {
  const DialogIcons({super.key});

  @override
  State<DialogIcons> createState() => _Dialog();
}

class _Dialog extends State<DialogIcons> {
  _dialog() {
    return Get.dialog(
      Center(
        child: Material(
          // 👈 أضف هذا
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            width: 300,
            decoration: BoxDecoration(
              color: const Color(0xFF111C22),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Select Icon",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.clear, color: Colors.white),
                    ),
                  ],
                ),
                const Text(
                  "Select an icon to make it visualized",
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 10,
                    decoration: TextDecoration.none,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: IconHabit(
                    imagePath: context.read<HabitProvider>().pathImage,
                  ),
                ),
                const Divider(color: Colors.white10),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  itemCount: context.read<HabitProvider>().imagesPath.length,
                  itemBuilder: (context, i) {
                    String path = context.read<HabitProvider>().imagesPath[i];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          context.read<HabitProvider>().pathImage = path;
                        });
                      },
                      child: IconHabit(imagePath: path),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _dialog();
  }
}
