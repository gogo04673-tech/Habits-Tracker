import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get/get.dart';
import 'package:habit_track/controllers/database/sqldb.dart';
import 'package:habit_track/controllers/state_management/habit_provider.dart';

import 'package:habit_track/features/habit/appear_habit.dart';
import 'package:habit_track/features/habit/habit.dart';
import 'package:habit_track/features/habit/view_habit.dart';

import 'package:habit_track/features/tools/appbar.dart';
import 'package:habit_track/features/tools/text.dart';

import 'package:provider/provider.dart' as prov;

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _Home();
}

class _Home extends ConsumerState<Home> {
  SqlDb sqldb = SqlDb();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      // ignore: use_build_context_synchronously
      prov.Provider.of<HabitProvider>(context, listen: false).checkDailyReset();
    });
  }

  //* Card of today quote is here
  Widget _cardQuote() {
    return Stack(
      children: [
        Image.asset(
          'images/quote.png',
          fit: BoxFit.cover, // Fill the card
        ),

        // Optional: Add your quote text here
        Positioned(
          top: 140,
          left: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            // decoration: BoxDecoration(
            //   color: Colors.black.withOpacity(0.6),
            //   borderRadius: BorderRadius.circular(8),
            // ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainText(
                  text:
                      "The only way to do great \nwork is to love what you do.",
                ),

                Text(
                  "Stave Jobs",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // * appBar is here
      appBar: const BarApp(titlePage: "Daily Habits"),

      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            // * text of Today's Quote
            const MainText(text: "Today's Quote"),

            //* Card of today quote
            _cardQuote(),

            // * text Habits
            const MainText(text: "Habits"),

            // ! List of habits in ( List Tile)
            prov.Consumer<HabitProvider>(
              builder: (context, prov, child) {
                return Column(
                  children: [
                    ...List.generate(prov.habits.length, (i) {
                      Habit habit = prov.habits[i];
                      return InkWell(
                        onTap: () async {
                          Get.to(() => ViewHabit(habit: habit));
                        },
                        child: AppearHabit(
                          habit: habit,
                          onTap: () {
                            if (habit.icon == prov.doneIcon) {
                              prov.markHabitNotAsDone(habit);
                            } else {
                              prov.markHabitAsDone(habit);
                            }
                          },
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
