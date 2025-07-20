import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_track/features/tools/appbar.dart';
import 'package:habit_track/features/tools/text_form_filed.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  late TextEditingController newPassword;

  @override
  void initState() {
    super.initState();
    newPassword = TextEditingController();
  }

  Widget baseText(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarApp(
        titlePage: "Change Password",
        leading: true,
        onTap: () {
          Get.back();
        },
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),

        child: ListView(
          children: [
            Column(
              children: [
                // * Image profile is here
                const SizedBox(height: 15),

                // * Text form filed to Current Password
                baseText("Current Password"),
                TextFiledForm(
                  hintText: "Enter Current password",
                  controller: newPassword,
                ),

                const SizedBox(height: 15),

                // * Text form filed to new Password
                baseText("New Password"),
                TextFiledForm(
                  hintText: "Enter new password",
                  controller: newPassword,
                ),

                const SizedBox(height: 15),

                // * Text form filed to confirm new Password
                baseText("Confirm new Password"),
                TextFiledForm(
                  hintText: "Confirm new password",
                  controller: newPassword,
                ),

                const SizedBox(height: 20),

                // Button change password
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Color(0xFF47b5eb),
                      ),
                    ),

                    onPressed: () {},
                    child: const Text(
                      "Change Password",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
