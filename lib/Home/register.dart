import 'package:carrentalapp/view/user/thankyou_splash.dart';

import 'package:carrentalapp/widgets/customcontainer.dart';
import 'package:carrentalapp/widgets/customtext.dart';
import 'package:carrentalapp/widgets/customtextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController dobcontroller = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isvisible = true;
  final String urlimg =
      "https://img.freepik.com/premium-vector/user-profile-icon-flat-style-member-avatar-vector-illustration-isolated-background-human-permission-sign-business-concept_157943-15752.jpg?size=338&ext=jpg&ga=GA1.1.735520172.1710547200&semt=ais";
  Future authenticationsignup(
      {required email,
      required name,
      required phone,
      required password,
      required dob,
      required String urlimg,
      required BuildContext context}) async {
    try {
      var ref = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      var docid = ref.user!.uid.toString();
      var data = {
        "email": email,
        "pasword": password,
        "name": name,
        "phone": phone,
        "dob": dob,
        "url": urlimg
      };
      var dbref = FirebaseFirestore.instance
          .collection("mydatabase")
          .doc(docid)
          .set(data);
      Fluttertoast.showToast(msg: "Success");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Splash2screen(),
          ));
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.code);
    } catch (e) {
      Fluttertoast.showToast(msg: "failed");
    }
  }

  Future databasestore(email, pass, name, phone, docid) async {
    var data = {
      "email": email,
      "pasword": pass,
      "name": name,
      "phone": phone,
      "url": urlimg
    };
    var dbref = await FirebaseFirestore.instance
        .collection("mydatabase")
        .doc(docid)
        .set(data);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.only(top: 100, left: 15, right: 15),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  const customtext(
                      title: "Hello Friend",
                      color: Colors.white,
                      size: 30,
                      fontWeight: FontWeight.bold),
                  const SizedBox(
                    height: 40,
                  ),
                  customtextfield(
                      obscureText: false,
                      controller: emailcontroller,
                      hinttxt: "  Email",
                      hintcolor: Colors.white,
                      prefix: const Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                      command: "enter email",
                      command2: "enter proper way of email"),
                  const SizedBox(
                    height: 45,
                  ),
                  customtextfield(
                      obscureText: false,
                      controller: namecontroller,
                      hinttxt: "  Name",
                      hintcolor: Colors.white,
                      prefix: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      command: "enter name",
                      command2: "enter full name"),
                  const SizedBox(
                    height: 45,
                  ),
                  customtextfield(
                      obscureText: false,
                      controller: phonecontroller,
                      hinttxt: "  Phone",
                      hintcolor: Colors.white,
                      prefix: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      command: "enter phone no",
                      command2: "enter 10 digit phone"),
                  const SizedBox(
                    height: 45,
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
                          isvisible ? Icons.visibility : Icons.visibility,
                          color: isvisible ? Colors.white : Colors.blue,
                        )),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  customtextfield(
                      obscureText: false,
                      controller: dobcontroller,
                      hinttxt: "     Date of birth",
                      hintcolor: Colors.white,
                      command: "enter DOB",
                      command2: "ente proper date"),
                  const SizedBox(
                    height: 90,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        authenticationsignup(
                            email: emailcontroller.text,
                            name: namecontroller.text,
                            phone: phonecontroller.text,
                            password: passcontroller.text,
                            dob: dobcontroller.text,
                            urlimg: urlimg,
                            context: context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("successly registered"),
                          duration: Duration(seconds: 3),
                        ));
                      }
                    },
                    child: const customcontainer(
                        textwidget: customtext(
                            title: "Sign Up",
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
    );
  }
}
