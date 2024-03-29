import 'dart:io';


import 'package:carrentalapp/widgets/customtextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class Uploadscreen extends StatefulWidget {
  const Uploadscreen({super.key});

  @override
  State<Uploadscreen> createState() => _UploadscreenState();
}

class _UploadscreenState extends State<Uploadscreen> {
  final TextEditingController nameconroller = TextEditingController();
  final TextEditingController nameconroller2 = TextEditingController();
  final TextEditingController priceconroller = TextEditingController();
  final TextEditingController aboutconroller = TextEditingController();
  final TextEditingController seatconroller = TextEditingController();
  final TextEditingController speeedconroller = TextEditingController();
  List<File> images = [];
  File? imagefile;
  Reference? ref;
  CollectionReference? imgref;

  List<String> imageurl = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imgref = FirebaseFirestore.instance.collection("imageurl");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(children: [
          customtextfield(
              controller: nameconroller,
              hinttxt: "car compnay",
              hintcolor: Colors.green,
              command: "enter",
              obscureText: false,
              command2: "enter"),
          const SizedBox(
            height: 10,
          ),
          customtextfield(
              controller: nameconroller2,
              hinttxt: "car type",
              hintcolor: Colors.green,
              obscureText: false,
              command: "enter",
              command2: "enter"),
          const SizedBox(
            height: 10,
          ),
          customtextfield(
              controller: priceconroller,
              hinttxt: "car prize",
              hintcolor: Colors.green,
              obscureText: false,
              command: "enter",
              command2: "enter"),
          const SizedBox(
            height: 10,
          ),
          customtextfield(
              controller: aboutconroller,
              hinttxt: "car about",
              hintcolor: Colors.green,
              obscureText: false,
              command: "enter",
              command2: "enter"),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          customtextfield(
              controller: seatconroller,
              hinttxt: "car seat",
              hintcolor: Colors.green,
              obscureText: false,
              command: "enter",
              command2: "enter"),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          customtextfield(
              controller: speeedconroller,
              hinttxt: "car speed",
              hintcolor: Colors.green,
              obscureText: false,
              command: "enter",
              command2: "enter"),
          Expanded(
            child: GridView.builder(
              itemCount: images.length + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return index == 0
                    ? Center(
                        child: IconButton(
                            onPressed: () async {
                              var img = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              imagefile = File(img!.path);
                              setState(() {
                                images.add(imagefile!);
                              });
                              String uuid = const Uuid().v4();
                              var reference = await FirebaseStorage.instance
                                  .ref()
                                  .child("storeimage/$uuid.jpg")
                                  .putFile(imagefile!);
                              var imgurl = await reference.ref
                                  .getDownloadURL()
                                  .then((value) => imgref!.add({
                                        "url": value,
                                        "company": nameconroller.text,
                                        "type": nameconroller2.text,
                                        "price": priceconroller.text,
                                        "about": aboutconroller.text,
                                        "seat": seatconroller.text,
                                        "speed": speeedconroller.text
                                      }));
                              print(imgurl);
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                      )
                    : Container(
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(images[index - 1]))),
                      );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
