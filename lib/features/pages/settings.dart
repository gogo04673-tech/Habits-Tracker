import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:get/get.dart';
import 'package:habit_track/controllers/state_management/theme_provider.dart';

import 'package:habit_track/controllers/state_management/time_provider.dart';
import 'package:habit_track/controllers/notification/notification_service.dart';
import 'package:habit_track/features/pages/change_pass.dart';
import 'package:habit_track/features/pages/edit_profile.dart';
import 'package:habit_track/features/tools/appbar.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  // * text is here
  Widget upText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // * List is here
  Widget listTile(String title, String? subtitle, Widget trailing) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "$title\n",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: subtitle,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),

        trailing,
      ],
    );
  }

  Widget rowArrow(String text, void Function()? onPressed) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        /*  */
        children: [
          Text(
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),

          Icon(
            Icons.arrow_forward,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }

  // * Date time picker
  pickerTime() {
    return picker.DatePicker.showTimePicker(
      context,
      showTitleActions: true,
      currentTime: DateTime.now(),

      onConfirm: (time) {
        TimeProvider prov = context.read<TimeProvider>();
        prov.formatTimeOfDay(time);
        NotificationService().scheduleDaily(
          title: "Reminder Time",
          body: "This time of habit",
          hour: time.hour,
          minute: time.minute,
        );
      },
      locale: picker.LocaleType.en,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarApp(titlePage: 'Settings', icon: null),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // * Text notification is here
            upText("Notifications"),

            const SizedBox(height: 20),

            // Daily Reminder is here
            listTile(
              "Daily Reminder",
              'Enable or disable daily reminder',
              Consumer<TimeProvider>(
                builder: (context, provider, child) {
                  return Switch(
                    value: provider.allowReminder,
                    onChanged: (value) => provider.changeMode(value),

                    activeTrackColor: const Color.fromARGB(255, 54, 87, 105),
                    inactiveTrackColor: const Color(0xFF243b47),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Reminder Time  is here
            listTile(
              "Reminder Time",
              'Set the time for your daily reminder',
              Consumer<TimeProvider>(
                builder: (context, provider, child) {
                  return InkWell(
                    onTap: () {
                      if (provider.allowReminder) {
                        pickerTime();
                      } else {
                        Get.snackbar(
                          "Time Reminder",
                          "Please Enable Daily Reminder if you want Reminder",
                        );
                      }
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Text(
                      provider.timeReminder.isEmpty
                          ? provider.constTime
                          : provider.timeReminder,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),
            // * text Appearance is here
            upText("Appearance"),

            const SizedBox(height: 20),

            // Theme  is here
            listTile(
              "Theme",
              'Switch between light and dark mode',
              Consumer<ThemeProvider>(
                builder: (context, theme, child) {
                  return Switch(
                    value: theme.isDark,
                    onChanged: theme.changeTheme,
                    activeTrackColor: const Color(0xFF243b47),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            // * Account is here
            upText("Account"),

            const SizedBox(height: 20),
            rowArrow("Edit Profile", () {
              Get.to(() => const EditProfile());
            }),

            // * Edit account is here
            const SizedBox(height: 20),
            rowArrow("Change Password", () {
              Get.to(() => const ChangePassword());
            }),
          ],
        ),
      ),
    );
  }
}
