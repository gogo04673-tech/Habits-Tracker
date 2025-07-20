import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_track/controllers/state_management/auth_provider.dart';
import 'package:habit_track/controllers/state_management/habit_provider.dart';
import 'package:habit_track/controllers/state_management/theme_provider.dart';
import 'package:habit_track/controllers/state_management/time_provider.dart';
import 'package:habit_track/controllers/notification/notification_service.dart';
import 'package:habit_track/features/auth/auth_wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init notificationsPlugin
  NotificationService().initialize();

  // * init firebase
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HabitProvider()),
        ChangeNotifierProvider(create: (_) => TimeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const AuthWrapper(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

/// ThemeData(
       // scaffoldBackgroundColor: const Color(0xFF111C22),
       /// bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//backgroundColor: Color(0xFF192933),
       // ),
        // You can add other theme properties here
      //),
