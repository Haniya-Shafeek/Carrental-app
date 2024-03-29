import 'package:carrentalapp/widgets/customcontainer.dart';
import 'package:carrentalapp/widgets/customtext.dart';
import 'package:carrentalapp/widgets/customtextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Passresetscreen extends StatefulWidget {
  const Passresetscreen({super.key});

  @override
  State<Passresetscreen> createState() => _PassresetscreenState();
}

class _PassresetscreenState extends State<Passresetscreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future passwordreset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailcontroller.text);
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text("Go to your email and reset password"),
        ),
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(e.message.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 47, 47),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 100, top: 80),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("assets/images/passiconimage.png"))),
                ),
              ),
              const SizedBox(
                height: 90,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: customtext(
                  title: "Forget password",
                  color: Colors.white,
                  size: 27,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                child: customtextfield(
                    controller: emailcontroller,
                    hinttxt: "   Enter Your Email",
                    obscureText: false,
                    hintcolor: Colors.white,
                    prefix: const Icon(
                      Icons.mail,
                      color: Colors.white,
                    ),
                    command: "enter mail",
                    command2: "proper mail"),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 130),
                child: GestureDetector(
                  onTap: () {
                    passwordreset();
                  },
                  child: const customcontainer(
                      textwidget: customtext(
                        title: "Reset Password",
                        color: Colors.white,
                        size: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      color: Colors.red,
                      height: 50,
                      width: 150,
                      curve: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
