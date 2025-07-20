import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_track/features/habit/add_habit.dart';
import 'package:habit_track/features/pages/calendar.dart';
import 'package:habit_track/features/pages/home.dart';
import 'package:habit_track/features/pages/settings.dart';
import 'package:habit_track/features/pages/stats.dart';

class SwitchPage extends StatefulWidget {
  const SwitchPage({super.key});

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  final PageController _pageController = PageController();
  int _bottomNavIndex = 0;

  final List<IconData> iconList = [
    Icons.home,
    Icons.calendar_today,
    Icons.bar_chart,
    Icons.settings,
  ];

  final List<Widget> pages = const [
    Home(),
    CalendarPage(),
    StatsPage(),
    SettingsPage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    setState(() => _bottomNavIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111C22),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),

      floatingActionButton: _bottomNavIndex == 0
          ? FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () async {
                await Get.to(() => const AddHabit());
              },
              backgroundColor: const Color(0xFF47b5eb),
              child: const Icon(Icons.add, color: Colors.black, size: 25),
            )
          : null,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // * Bottom navigator Bar is here
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          return Icon(
            iconList[index],
            size: isActive ? 30 : 24,
            color: isActive ? Colors.white : Colors.grey,
          );
        },
        activeIndex: _bottomNavIndex,
        gapLocation: _bottomNavIndex == 0
            ? GapLocation.center
            : GapLocation.none,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 30,
        rightCornerRadius: 30,
        backgroundColor: const Color(0xFF1a2a32),

        onTap: (index) => _onTap(index),
      ),
    );
  }
}
