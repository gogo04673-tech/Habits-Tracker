import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_track/features/tools/appbar.dart';
import 'package:habit_track/features/tools/text_form_filed.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  late TextEditingController name;
  late TextEditingController bio;

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    bio = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarApp(
        titlePage: "Edit Profile",
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
                InkWell(
                  onTap: () {
                    print("tap");
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),

                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(100),
                      child: Image.asset(
                        "images/profile.png",
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // * Username is here
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Mohamed Eljihad\n",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "        @Username",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // * Text form filed to name
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 2,
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextFiledForm(hintText: "Enter you name", controller: name),

                // * Text form filed to Bio
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 2,
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Bio",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextFiledForm(hintText: "Bio", controller: bio, maxLines: 7),
              ],
            ),
          ],
        ),
      ),

      floatingActionButton: SizedBox(
        width: 140,
        height: 50,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF47b5eb),
          child: const Text(
            "Save change",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
