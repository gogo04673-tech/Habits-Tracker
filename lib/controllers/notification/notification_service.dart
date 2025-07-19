import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // Initialize the plugin and timezone
  Future<void> initialize() async {
    if (_isInitialized) return;

    // init timezone
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    // Android init settings
    const initSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // * Request Notifications Android
    notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    // iOS init settings
    const initSettingsIos = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Combined init settings
    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIos,
    );

    await notificationsPlugin.initialize(initSettings);
    _isInitialized = true;
  }

  // Notification details setup
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "habit_channel_id",
        "Habit Notifications",
        channelDescription: "Reminders for daily habits",
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  // Show notification immediately
  Future<void> showNotification({
    int id = 0,
    String? title = "Default Title",
    String? body = "Default Body",
  }) async {
    return notificationsPlugin.show(id, title, body, notificationDetails());
  }

  // Schedule notification at specific hour/minute today and daily
  Future<void> scheduleDaily({
    int id = 2,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfTime(hour, minute),
      notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  

  // Cancel all notifications
  Future<void> cancelNotification() async {
    await notificationsPlugin.cancelAll();
  }
}
