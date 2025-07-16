import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_track/controllers/habit/habit_provider.dart';
import 'package:habit_track/controllers/models/state_service.dart';
import 'package:habit_track/features/habit/habit.dart';
import 'package:habit_track/features/tools/icon.dart';
import 'package:habit_track/features/tools/line_chart.dart';
import 'package:habit_track/features/tools/text_form_filed.dart';

import 'package:provider/provider.dart';

class ViewHabit extends StatefulWidget {
  const ViewHabit({super.key, required this.habit});
  final Habit habit;

  @override
  State<ViewHabit> createState() => _ViewHabitState();
}

class _ViewHabitState extends State<ViewHabit> {
  final ScrollController scrollController = ScrollController();

  late TextEditingController nameController;
  late TextEditingController descriptionController;
  List<TextEditingController> subTasksControllers = [];
  late List<bool> isCheckedList;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.habit.nameHabit);
    descriptionController = TextEditingController(text: widget.habit.descHabit);

    final subTasks = widget.habit.subTasks;

    subTasksControllers = subTasks
        .map((task) => TextEditingController(text: task.toString()))
        .toList();

    context.read<HabitProvider>().pathImage = widget.habit.icon;

    isCheckedList = List.generate(subTasksControllers.length, (i) => false);
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    for (var controller in subTasksControllers) {
      controller.dispose();
    }
    scrollController.dispose();
    super.dispose();
  }

  List<double> countAllCompletionWeekly() {
    HabitProvider provider = Provider.of<HabitProvider>(context);

    List<DateTime> allCompletionHabit = provider.habits
        .expand((h) => h.completedDays)
        .toList();

    return StateService.getWeeklyCompletionCounts(
      allCompletionHabit,
    ).map((e) => e.toDouble()).toList();
  }

  double progressWeek = 14.285714286;
  int countProgressWeek() {
    List listWeek = countAllCompletionWeekly().where((n) => n > 0).toList();
    return (listWeek.length * progressWeek).toInt();
  }

  void _saveAndGoBack() {
    List<String> subTasks = subTasksControllers
        .map((c) => c.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    Habit editHabit = Habit(
      id: widget.habit.id,
      nameHabit: nameController.text,
      descHabit: descriptionController.text,
      subTasks: subTasks,
      frequency: widget.habit.frequency,
      icon: context.read<HabitProvider>().pathImage,
      baseIcon: widget.habit.baseIcon,
      dateTime: widget.habit.dateTime,
      completedDays: widget.habit.completedDays,
    );

    context.read<HabitProvider>().updateHabit(editHabit);

    Get.back();
  }

  // ! count list chart

  // * dialog edit subtasks
  void _subTaskDialog(int i) {
    Get.dialog(
      Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: 150,
            margin: const EdgeInsets.only(
              bottom: 30,
              top: 10,
              right: 10,
              left: 10,
            ),

            decoration: BoxDecoration(
              color: const Color(0xFF111C22),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Edit subTask: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        setState(() {
                          Get.back();
                        });
                      },
                      icon: const Icon(Icons.done),
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                TextFiledForm(
                  hintText: "Edit name",
                  controller: subTasksControllers[i],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // * dialog icons
  void _dialog() {
    Get.dialog(
      Center(
        child: Material(
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
                        Get.back();
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

  PreferredSizeWidget _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: _saveAndGoBack,
        icon: const Icon(Icons.arrow_back, size: 30, color: Colors.white),
      ),
      centerTitle: true,
      title: const Text(
        "Habit Details",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xFF111C22),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 30, top: 15),
        child: ListView(
          controller: scrollController,
          children: [
            // ✅ Icon + Name
            Row(
              children: [
                InkWell(
                  onTap: _dialog,
                  child: IconHabit(
                    imagePath: context.read<HabitProvider>().pathImage,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFiledForm(
                    hintText: "Habit Name",
                    controller: nameController,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ✅ Description
            TextFiledForm(
              hintText: "Description",
              controller: descriptionController,
              maxLines: 2,
            ),

            const SizedBox(height: 20),

            // ✅ SubTasks
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "SubTasks",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      subTasksControllers.add(TextEditingController());
                      isCheckedList.add(false);
                    });
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),

            // * Subtasks on checkbox
            ...List.generate(subTasksControllers.length, (i) {
              return InkWell(
                onTap: () {
                  _subTaskDialog(i);
                },
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Row(
                  children: [
                    // check Box is here
                    Checkbox(
                      value: isCheckedList[i],
                      onChanged: (value) {
                        setState(() {
                          isCheckedList[i] = value!;
                        });
                      },
                    ),

                    Text(
                      "${subTasksControllers[i].text[0].toUpperCase()}${subTasksControllers[i].text.substring(1)}",
                      style: TextStyle(
                        color: isCheckedList[i] ? Colors.white24 : Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        decoration: isCheckedList[i]
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,

                        decorationColor: isCheckedList[i]
                            ? Colors.white24
                            : Colors.white,
                      ),
                    ),

                    // * Remove subtask is here
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              subTasksControllers.removeAt(i);
                            });
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            // ✅ Frequency
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Frequency",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),

            // * Appear frequency the habit
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                widget.habit.frequency,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // * Progress is here
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Progress\n\n",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const TextSpan(
                      text: "Weekly Progress\n",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "${countProgressWeek()}%\n",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: "Last 7 Days ",
                      style: TextStyle(color: Colors.white38, fontSize: 15),
                    ),
                    const TextSpan(
                      text: "+10%",
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // * chart is here
            HabitProgressCard(completeDays: widget.habit.completedDays),
          ],
        ),
      ),
    );
  }
}
