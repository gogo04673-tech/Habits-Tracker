import 'package:flutter/material.dart';
import 'package:habit_track/controllers/models/provider.dart';
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
      style: const TextStyle(
        color: Colors.white,
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
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: subtitle,
                style: const TextStyle(
                  color: Colors.white38,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,/*  */
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),

        IconButton(
          onPressed: onPressed,
          color: Colors.white,
          icon: const Icon(Icons.arrow_forward),
        ),
      ],
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
              Consumer<Variables>(
                builder: (context, provider, child) {
                  return Switch(
                    value: provider.darkMode,
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
              Consumer<Variables>(
                builder: (context, provider, child) {
                  return InkWell(
                    onTap: () {},
                    child: const Text(
                      "9:00 AM",
                      style: TextStyle(
                        color: Colors.white,
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
              Consumer<Variables>(
                builder: (context, provider, child) {
                  return const Text(
                    "Light",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            // * Account is here
            upText("Account"),

            const SizedBox(height: 20),
            rowArrow("Edit Profile", () {}),

            // * Edit account is here
            const SizedBox(height: 20),
            rowArrow("Change Password", () {}),
          ],
        ),
      ),
    );
  }
}
