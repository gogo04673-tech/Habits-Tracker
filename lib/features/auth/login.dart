import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_track/features/auth/signin.dart';
import 'package:habit_track/features/tools/text_form_filed.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  // controllers
  late TextEditingController email;
  late TextEditingController password;

  GlobalKey<FormState> formState = GlobalKey();

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // * Image is board
                Container(
                  color: const Color(0xFFf6f6f6),
                  child: Image.asset("images/board.png"),
                ),

                // * Text Welcome Back
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // * Text Email
                Container(
                  margin: const EdgeInsets.all(10),
                  child: const Text(
                    "Email",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                // * TextFiledForm <Email>
                TextFiledForm(
                  hintText: "Enter your email",
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    // Simple email regex
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                // height 15
                const SizedBox(height: 15),

                // * Text Password
                Container(
                  margin: const EdgeInsets.all(10),
                  child: const Text(
                    "Password",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                // * TextFiledForm <PassWord>
                TextFiledForm(
                  hintText: "Enter your password",
                  obscureText: true,
                  stateIcon: true,

                  controller: password,
                  validator: (value) {
                    if (value == null && value!.isEmpty) {
                      return "Please enter a valid password";
                    }

                    return null;
                  },
                ),

                // height 15
                const SizedBox(height: 10),

                // * Button Login
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent, // Add this line
                  onTap: () async {
                    if (formState.currentState!.validate()) {
                      try {
                        // ignore: unused_local_variable
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                              email: email.text,
                              password: password.text,
                            );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xFF47b4ea),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // height 15
                const SizedBox(height: 10),

                // text --------- Or continue with --------
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Color(0xFF7393a4),
                          thickness: 1,
                          endIndent: 10,
                        ),
                      ),
                      Text(
                        "Or continue with  ",
                        style: TextStyle(color: Color(0xFF7393a4)),
                      ),
                      Expanded(
                        child: Divider(
                          color: Color(0xFF7393a4),
                          thickness: 1,
                          endIndent: 10,
                        ),
                      ),
                    ],
                  ),
                ),

                // height 15
                const SizedBox(height: 5),
                // * Button Login
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xFF243b47),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    padding: const EdgeInsets.all(3),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.g_mobiledata, size: 40, color: Colors.white),
                        Text(
                          "Continue with Google",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Go To Create a new account
                InkWell(
                  onTap: () {
                    Get.to(() => const SignIn());
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: const Center(
                    child: Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(
                        color: Color(0xFF7393a4),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF7393a4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
