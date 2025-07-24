import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_track/controllers/state_management/auth_provider.dart';
import 'package:habit_track/controllers/state_management/habit_provider.dart';
import 'package:habit_track/controllers/state_management/theme_provider.dart';
import 'package:habit_track/controllers/state_management/time_provider.dart';
import 'package:habit_track/controllers/notification/notification_service.dart';
import 'package:habit_track/features/auth/auth_wrapper.dart';
import 'package:provider/provider.dart' as pr;
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init notificationsPlugin
  NotificationService().initialize();

  // * init firebase
  await Firebase.initializeApp();

  runApp(
    pr.MultiProvider(
      providers: [
        pr.ChangeNotifierProvider(create: (_) => HabitProvider()),
        pr.ChangeNotifierProvider(create: (_) => TimeProvider()),
        pr.ChangeNotifierProvider(create: (_) => AuthProvider()),
        pr.ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner:
          false, // * remove debug banner from application
      home: const AuthWrapper(),
      theme: pr.Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
