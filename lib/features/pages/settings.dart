import 'package:flutter/material.dart';
import 'package:habit_track/features/tools/appbar.dart';



class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BarApp(titlePage: 'Settings', icon: null),

    );
  }
}
