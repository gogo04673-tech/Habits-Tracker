import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_track/controllers/habit_provider.dart';
import 'package:habit_track/habit/habit_class.dart';
import 'package:habit_track/habit/view_habit.dart';
import 'package:habit_track/habit/appear_habit.dart';
import 'package:habit_track/tools_page/appbar.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      // ignore: use_build_context_synchronously
      Provider.of<HabitProvider>(context, listen: false).checkDailyReset();
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
                Text(
                  "The only way to do great \nwork is to love what you do.",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
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
      appBar: const BarApp(titlePage: "Daily Habits", icon: Icons.settings),

      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            // * text of Today's Quote
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Text(
                "Today's Quote",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //* Card of today quote
            _cardQuote(),

            // * text Habits
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                "Habits",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            
            // ! List of habits in ( List Tile)
            Consumer<HabitProvider>(
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
                          title: habit.nameHabit,
                          subtitle: habit.subTasks.join(", "),
                          path: habit.icon,
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
