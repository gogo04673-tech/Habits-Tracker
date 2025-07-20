import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_track/controllers/database/sqldb.dart';
import 'package:habit_track/controllers/state_management/habit_provider.dart';
import 'package:habit_track/features/habit/habit.dart';
import 'package:habit_track/features/tools/icon.dart';
import 'package:habit_track/features/tools/material_button.dart';
import 'package:habit_track/features/tools/text_form_filed.dart';

import 'package:provider/provider.dart';

class AddHabit extends StatefulWidget {
  const AddHabit({super.key});

  @override
  State<AddHabit> createState() => _AddHabit();
}

class _AddHabit extends State<AddHabit> {
  // Controllers
  final TextEditingController habitName = TextEditingController();
  final TextEditingController description = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final List<TextEditingController> subTasksController = [
    TextEditingController(),
  ];

  SqlDb sqldb = SqlDb();

  @override
  void dispose() {
    habitName.dispose();
    description.dispose();
    scrollController.dispose();
    for (var ctrl in subTasksController) {
      ctrl.dispose();
    }
    super.dispose();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void addSubTaskField() {
    setState(() {
      subTasksController.add(TextEditingController());
    });
    scrollToBottom();
  }

  Widget _buildFrequencyButton(
    String title,
    bool selected,
    VoidCallback onTap,
  ) {
    return ButtonMaterial(title: title, changeColor: selected, onTap: onTap);
  }

  Widget _buildSubTasksList() {
    return Column(
      children: List.generate(subTasksController.length, (i) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: TextFiledForm(
            hintText: "SubTask ${i + 1}",
            controller: subTasksController[i],
          ),
        );
      }),
    );
  }

  void saveHabit() async {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    final subTasks = subTasksController
        .map((c) => c.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    HabitProvider provider = context.read<HabitProvider>();
    Habit newHabit = Habit(
      nameHabit: habitName.text,
      descHabit: description.text,
      subTasks: subTasks,
      frequency: provider.frequency,
      icon: provider.pathImage,
      baseIcon: provider.pathImage,
      dateTime: today,
    );

    // Add habit for use provider
    provider.addHabit(newHabit);

    // ! SQFLIte
    int response = await sqldb.insertData("""
INSERT INTO 'habits' (
'nameHabit', 
'descHabit', 
'subTasks', 
'frequency',
'icon', 
'baseIcon', 
'dateTime', 
'completedDays') 
VALUES ('
${habitName.text}', 
'${description.text}', 
'$subTasks', 
'${provider.frequency}', 
'${provider.pathImage}',
'${provider.pathImage}', 
'$today',
'${[today]}');

""");
    print(response);

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // * appBar is here
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "New Habit",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF111C22),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.clear, size: 30, color: Colors.white),
        ),
      ),

      // * Body is here
      body: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 30, top: 15),
        child: ListView(
          controller: scrollController,
          children: [
            Row(
              children: [
                // ? add icon of habit is here
                InkWell(
                  onTap: () {
                    Get.dialog(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                      ),
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
                                Consumer<HabitProvider>(
                                  builder: (context, prov, child) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: IconHabit(
                                        imagePath: prov.pathImage,
                                      ),
                                    );
                                  },
                                ),

                                const Divider(color: Colors.white10),

                                Consumer<HabitProvider>(
                                  builder: (context, prov, child) {
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 5,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 5,
                                          ),
                                      itemCount: prov.imagesPath.length,

                                      itemBuilder: (context, i) {
                                        String path = prov.imagesPath[i];
                                        return InkWell(
                                          onTap: () {
                                            prov.changePathImage(path);
                                            Get.back();
                                          },
                                          child: IconHabit(imagePath: path),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: IconHabit(
                    imagePath: context.watch<HabitProvider>().pathImage,
                  ),
                ),

                // * text filed form is here
                Expanded(
                  child: TextFiledForm(
                    hintText: "Habit Name",
                    controller: habitName,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            TextFiledForm(
              hintText: "Description (Optional)",
              controller: description,
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            const Text(
              "Frequency",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            Consumer<HabitProvider>(
              builder: (context, prov, child) {
                return Row(
                  children: [
                    _buildFrequencyButton("Daily", prov.dailyColor, () {
                      prov.choiceDeadLine(true, false, false, "Daily");
                    }),
                    _buildFrequencyButton("Weekly", prov.weekColor, () {
                      prov.choiceDeadLine(false, true, false, "weekly");
                    }),
                    _buildFrequencyButton("Specific Days", prov.daysColor, () {
                      prov.choiceDeadLine(false, false, true, "Specific Days");
                    }),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "SubTasks (Optional)",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: addSubTaskField,
                  icon: const Icon(Icons.add, color: Colors.white, size: 30),
                ),
              ],
            ),
            _buildSubTasksList(),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 150,
        height: 50,
        child: FloatingActionButton(
          onPressed: saveHabit,
          backgroundColor: const Color(0xFF47b5eb),
          child: const Text(
            "Save Habit",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
