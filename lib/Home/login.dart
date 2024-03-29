import 'package:carrentalapp/view/user/maun_page.dart';
import 'package:carrentalapp/view/user/passreset.dart';

import 'package:carrentalapp/view/admin/main_page.dart';

import 'package:carrentalapp/utilities/constants.dart';
import 'package:carrentalapp/widgets/customcontainer.dart';
import 'package:carrentalapp/widgets/customtext.dart';
import 'package:carrentalapp/widgets/customtextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void store() async {
    if (emailcontroller.text=="haniya@gmail.com") {
    //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setBool("adlogin", true);
    // } else {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("login", true);
    }
  }

  bool isvisible = true;
  Future authenticatinlogin(
      {required email, required password, required context}) async {
    try {
      var reference = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = reference.user;
      if (user!.uid == Myconstants().adminId) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return const Adminmainscreen();
          },
        ));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return const Mainscreen();
          },
        ));
      }
    } on FirebaseAuthException {
      Fluttertoast.showToast(msg: "error", backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 241, 229, 229),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const customtext(
                    title: "Log In",
                    color: Color.fromARGB(255, 10, 68, 12),
                    size: 40,
                    fontWeight: FontWeight.bold),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 30),
                  child: Container(
                    width: 330,
                    height: 400,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20)),
                    child: Form(
                      key: formkey,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 30),
                        child: Column(
                          children: [
                            customtextfield(
                                obscureText: false,
                                controller: emailcontroller,
                                hinttxt: "  Email",
                                prefix: const Icon(
                                  Icons.mail,
                                  color: Colors.white,
                                ),
                                hintcolor: Colors.white,
                                command: "enter email",
                                command2: "enter proper way of email"),
                            const SizedBox(
                              height: 40,
                            ),
                            customtextfield(
                              controller: passcontroller,
                              obscureText: isvisible,
                              hinttxt: "password",
                              hintcolor: Colors.white,
                              command: "enter password",
                              command2: "enter strong password",
                              prefix: const Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              suffici: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isvisible = !isvisible;
                                    });
                                  },
                                  icon: Icon(
                                    isvisible
                                        ? Icons.visibility
                                        : Icons.visibility,
                                    color:
                                        isvisible ? Colors.white : Colors.blue,
                                  )),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const Passresetscreen(),
                                  )),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 140, top: 15),
                                child: customtext(
                                    title: "forget password?",
                                    color: Colors.blue,
                                    size: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (formkey.currentState!.validate()) {
                                  authenticatinlogin(
                                      email: emailcontroller.text,
                                      password: passcontroller.text,
                                      context: context);
                                }
                                store();
                              },
                              child: const customcontainer(
                                  textwidget: customtext(
                                      title: "Login",
                                      color: Colors.black,
                                      size: 20,
                                      fontWeight: FontWeight.bold),
                                  color: Colors.white,
                                  height: 45,
                                  width: 200,
                                  curve: 30),
                            )
                          ],
                        ),
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
