import 'dart:io';

import 'package:carrentalapp/Home/login.dart';
import 'package:carrentalapp/Home/welcome.dart';
import 'package:carrentalapp/widgets/custcontainer2.dart';
import 'package:carrentalapp/widgets/customtext.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  final TextEditingController namecontroller = TextEditingController();
  File? imagefile;
  FirebaseAuth auth = FirebaseAuth.instance;
  late User? _curretuser;
  String email = "";
  String name = "";
  String pass = "";
  String phone = "";
  String dob = "";
  bool isuploading = false;
  String imageurl = "";

  void getdetails() async {
    _curretuser = FirebaseAuth.instance.currentUser;

    if (_curretuser != null) {
      fetchdetails();
    }
  }

  void fetchdetails() async {
    DocumentSnapshot usersnapshot = await FirebaseFirestore.instance
        .collection("mydatabase")
        .doc(_curretuser!.uid)
        .get();
    setState(() {
      name = usersnapshot["name"];
      email = usersnapshot["email"];
      pass = usersnapshot["pasword"];
      phone = usersnapshot["phone"];
      dob = usersnapshot["dob"];
      imageurl = usersnapshot["url"];
    });
  }

  void store() async {
    SharedPreferences Preferences = await SharedPreferences.getInstance();
    Preferences.setBool("login", false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdetails();
    fetchdetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple.shade200,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade200,
          title: const Center(
            child: customtext(
                title: "Profile",
                color: Colors.black,
                size: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 120),
                    child: Stack(
                      children: [
                        imageurl.isNotEmpty
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(imageurl),
                              )
                            : const CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    "https://img.freepik.com/premium-vector/user-profile-icon-flat-style-member-avatar-vector-illustration-isolated-background-human-permission-sign-business-concept_157943-15752.jpg?size=338&ext=jpg&ga=GA1.1.735520172.1710547200&semt=ais"),
                              ),
                        Positioned(
                            top: 60,
                            left: 60,
                            child: IconButton(
                                onPressed: () async {
                                  var img = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  imagefile = File(img!.path);

                                  String uuid = const Uuid().v4();
                                  var reference = await FirebaseStorage.instance
                                      .ref()
                                      .child("storeimage/$uuid.jpg")
                                      .putFile(imagefile!);
                                  await reference.ref.getDownloadURL().then(
                                      (value) => FirebaseFirestore.instance
                                          .collection("mydatabase")
                                          .doc(_curretuser!.uid)
                                          .update({"url": value}));
                                },
                                icon: const Icon(Icons.photo_camera)))
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                const customtext(
                    title: "Name",
                    color: Colors.black,
                    size: 18,
                    fontWeight: FontWeight.w500),
                const SizedBox(
                  height: 10,
                ),
                customcontainer2(title: name),
                const SizedBox(
                  height: 15,
                ),
                const customtext(
                    title: "Email",
                    color: Colors.black,
                    size: 18,
                    fontWeight: FontWeight.w500),
                const SizedBox(
                  height: 10,
                ),
                customcontainer2(title: email),
                const SizedBox(
                  height: 15,
                ),
                const customtext(
                    title: "Phone",
                    color: Colors.black,
                    size: 18,
                    fontWeight: FontWeight.w500),
                const SizedBox(
                  height: 10,
                ),
                customcontainer2(title: phone),
                const SizedBox(
                  height: 15,
                ),
                const customtext(
                    title: "Password",
                    color: Colors.black,
                    size: 18,
                    fontWeight: FontWeight.w500),
                const SizedBox(
                  height: 10,
                ),
                customcontainer2(title: pass),
                const SizedBox(
                  height: 15,
                ),
                const customtext(
                    title: "Date of birth",
                    color: Colors.black,
                    size: 18,
                    fontWeight: FontWeight.w500),
                const SizedBox(
                  height: 10,
                ),
                customcontainer2(title: dob),
                const SizedBox(
                  height: 15,
                ),
                const customtext(
                    title: "Country",
                    color: Colors.black,
                    size: 18,
                    fontWeight: FontWeight.w500),
                const SizedBox(
                  height: 10,
                ),
                const customcontainer2(title: "origin"),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () {
                    store();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Loginscreen(),
                        ));
                  },
                  child: const customtext(
                      title: "Log_out the account",
                      color: Colors.red,
                      size: 18,
                      fontWeight: FontWeight.w500),
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      _curretuser = FirebaseAuth.instance.currentUser;
                      await _curretuser!.delete();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Welcomescreen(),
                          ));
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const customtext(
                      title: "Delete the account",
                      color: Colors.red,
                      size: 18,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
