import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import 'package:habit_track/features/habit/add_habit.dart';
import 'package:habit_track/features/pages/calendar.dart';
import 'package:habit_track/features/pages/home.dart';
import 'package:habit_track/features/pages/settings.dart';
import 'package:habit_track/features/pages/stats.dart';
import 'package:habit_track/features/provider/riverpod.dart';

class SwitchPage extends ConsumerWidget {
  final PageController _pageController = PageController();

  SwitchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Riverpod Provider
    var controller = ref.watch(ZoomNotifier);
    var bottomIndex = ref.watch(bottomNavIndex.notifier);

    return ZoomDrawer(
      controller: controller,
      menuScreen: const DrawerScreen(),
      mainScreen: MainPage(
        pageController: _pageController,
        onTap: (int index) {
          bottomIndex.state = index;
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        },
      ),
      disableDragGesture: false,
      borderRadius: 30.0,
      duration: const Duration(milliseconds: 600),
      showShadow: true,
      angle: -12.0,

      menuBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      slideWidth: MediaQuery.of(context).size.width * 0.8,
      style: DrawerStyle.defaultStyle,
      openCurve: Curves.easeInOut,
      closeCurve: Curves.easeInOut,
      // mainScreenScale: 0.8,
      // dragOffset: 0.3,
    );
  }
}

// * ZoomDrawer Menu Screen is here

class MainPage extends ConsumerWidget {
  final PageController pageController;
  final Function(int) onTap;

  const MainPage({
    super.key,
    required this.pageController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var bottomIndex = ref.watch(bottomNavIndex);

    final List<IconData> iconList = [
      Icons.home,
      Icons.calendar_today,
      Icons.bar_chart,
      Icons.settings,
    ];

    final List<Widget> pages = [
      const Home(),
      const CalendarPage(),
      const StatsPage(),
      const SettingsPage(),
    ];

    Offset? dragStartPosition;
    bool canOpenDrawer = false;

    return Scaffold(
      body: Listener(
        onPointerDown: (details) {
          dragStartPosition = details.position;
          canOpenDrawer = details.position.dx < 30;
        },
        onPointerMove: (details) {
          if (canOpenDrawer && dragStartPosition != null) {
            if ((details.position.dx - dragStartPosition!.dx).abs() > 20) {
              ZoomDrawer.of(context)?.toggle();
              canOpenDrawer = false;
            }
          }
        },
        child: PageView(
          controller: pageController,
          onPageChanged: onTap,
          physics: const ClampingScrollPhysics(),
          children: pages,
        ),
      ),
      floatingActionButton: bottomIndex == 0
          ? FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () => Get.to(() => const AddHabit()),
              backgroundColor: const Color(0xFF47b5eb),
              child: const Icon(Icons.add, color: Colors.black, size: 25),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        splashColor: Colors.white,
        blurEffect: true,
        tabBuilder: (int index, bool isActive) {
          return Icon(
            iconList[index],
            size: isActive ? 30 : 24,
            color: isActive
                ? Theme.of(context).colorScheme.primary
                : Colors.grey,
          );
        },
        activeIndex: bottomIndex,
        gapLocation: bottomIndex == 0 ? GapLocation.center : GapLocation.none,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 30,
        rightCornerRadius: 30,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        onTap: onTap,
      ),
    );
  }
}

// *  Drawer Screen is here
class DrawerScreen extends ConsumerStatefulWidget {
  const DrawerScreen({super.key});

  @override
  ConsumerState<DrawerScreen> createState() => _DrawerScreen();
}

class _DrawerScreen extends ConsumerState<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 500,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),

        child: Material(
          color: Colors.transparent,
          child: ListView(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Image.asset("images/profile.png"),
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 20, bottom: 10),
                    child: Text(
                      "Sophia",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // * show item drawer isd here
              const ItemDrawer(icon: Icons.person, text: 'Profile'),
              const ItemDrawer(icon: Icons.settings, text: 'Settings'),
              const ItemDrawer(icon: Icons.archive, text: 'Achievement'),
              const ItemDrawer(
                icon: Icons.help_outline_outlined,
                text: 'Help & Feedback',
              ),
              const ItemDrawer(icon: Icons.output_sharp, text: 'Sign Out'),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemDrawer extends StatelessWidget {
  const ItemDrawer({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });
  final IconData icon;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      padding: const EdgeInsets.all(7),
      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      child: Row(
        children: [
          Icon(icon),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    ),
  );
}
