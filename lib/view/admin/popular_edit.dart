import 'dart:io';

import 'package:carrentalapp/view/admin/popular_view.dart';

import 'package:carrentalapp/widgets/customtext.dart';
import 'package:carrentalapp/widgets/customtextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class Updatedetailsscreen extends StatefulWidget {
  const Updatedetailsscreen({super.key, required this.docid});
  final String docid;

  @override
  State<Updatedetailsscreen> createState() => _UpdatedetailsscreenState();
}

class _UpdatedetailsscreenState extends State<Updatedetailsscreen> {
  final TextEditingController nameconroller = TextEditingController();
  final TextEditingController nameconroller2 = TextEditingController();
  final TextEditingController priceconroller = TextEditingController();
  List<File> images = [];
  File? imagefile;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const customtext(
                title: "Single car details",
                color: Colors.black,
                size: 20,
                fontWeight: FontWeight.bold),
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("imageurl")
                .doc(widget.docid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 60),
                    child: Column(
                      children: [
                        Stack(children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage(snapshot.data!["url"].toString()),
                          ),
                          Positioned(
                              top: 60,
                              left: 60,
                              child: IconButton(
                                  onPressed: () async {
                                    var img = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    imagefile = File(img!.path);
                                    setState(() {
                                      images.add(imagefile!);
                                    });
                                    String uuid = const Uuid().v4();
                                    var reference = await FirebaseStorage
                                        .instance
                                        .ref()
                                        .child("storeimage/$uuid.jpg")
                                        .putFile(imagefile!);

                                    await reference.ref.getDownloadURL().then(
                                          (value) => FirebaseFirestore.instance
                                              .collection("imageurl")
                                              .doc(widget.docid)
                                              .update({
                                            "url": value,
                                            "type": nameconroller.text,
                                            "company": nameconroller2.text,
                                            "price": priceconroller.text
                                          }),
                                        );
                                  },
                                  icon: const Icon(
                                    Icons.photo_camera,
                                    size: 30,
                                    color: Colors.white,
                                  )))
                        ]),
                        customtextfield(
                            controller: nameconroller,
                            obscureText: false,
                            hinttxt: snapshot.data!["type"].toString(),
                            hintcolor: Colors.white,
                            command: "",
                            command2: ""),
                        const SizedBox(
                          height: 30,
                        ),
                        customtextfield(
                            controller: nameconroller2,
                            obscureText: false,
                            hinttxt: snapshot.data!["company"].toString(),
                            hintcolor: Colors.white,
                            command: "",
                            command2: ""),
                        const SizedBox(
                          height: 30,
                        ),
                        customtextfield(
                            controller: priceconroller,
                            obscureText: false,
                            hinttxt: snapshot.data!["price"].toString(),
                            hintcolor: Colors.white,
                            command: "",
                            command2: ""),
                        const SizedBox(
                          height: 70,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const Popularupdatescrren(),
                              )),
                          child: Container(
                            height: 40,
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(30)),
                            child: const Center(
                              child: customtext(
                                  title: "Update",
                                  color: Colors.white,
                                  size: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Text("something wrong");
              }
            },
          )),
    );
  }
}
