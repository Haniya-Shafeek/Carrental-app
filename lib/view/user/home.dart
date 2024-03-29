import 'package:carrentalapp/view/user/affo_listview.dart';
import 'package:carrentalapp/view/user/new_listvew.dart';
import 'package:carrentalapp/view/user/popular_listview.dart';
import 'package:carrentalapp/view/user/popular_singleview.dart';
import 'package:carrentalapp/view/user/profile.dart';
import 'package:carrentalapp/widgets/customstreambulider.dart';
import 'package:carrentalapp/widgets/customtext.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late User? curretuser;
  String name = "";
  String imageurl = "";
  void getdetails() async {
    curretuser = FirebaseAuth.instance.currentUser;

    if (curretuser != null) {
      fetchdetails();
    }
  }

  void fetchdetails() async {
    DocumentSnapshot usersnapshot = await FirebaseFirestore.instance
        .collection("mydatabase")
        .doc(curretuser!.uid)
        .get();
    setState(() {
      name = usersnapshot["name"];

      imageurl = usersnapshot["url"];
    });
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
        backgroundColor: const Color.fromARGB(255, 238, 234, 234),
        body: Padding(
          padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profilescreen(),)),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.amber,
                      backgroundImage: NetworkImage(imageurl),
                    ),
                  ),
                  customtext(
                      title: name,
                      color: Colors.black,
                      size: 18,
                      fontWeight: FontWeight.bold),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications,
                        size: 30,
                        color: Colors.black,
                      ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const customtext(
                  title: "Choose A Car",
                  color: Colors.black,
                  size: 20,
                  fontWeight: FontWeight.w700),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const customtext(
                      title: "Popular",
                      color: Colors.black,
                      size: 18,
                      fontWeight: FontWeight.bold),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Popularview(),
                        )),
                    child: const customtext(
                        title: "view all",
                        color: Colors.blue,
                        size: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Expanded(
                child: customstreambuilder(
                  collection: "imageurl",
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const customtext(
                      title: "Affordable",
                      color: Colors.black,
                      size: 18,
                      fontWeight: FontWeight.bold),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Affordablescreen(),
                        )),
                    child: const customtext(
                        title: "view all",
                        color: Colors.blue,
                        size: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Expanded(
                child: customstreambuilder(
                  collection: "imageurl2",
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const customtext(
                      title: "Newest",
                      color: Colors.black,
                      size: 18,
                      fontWeight: FontWeight.bold),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Newestview(),
                        )),
                    child: const customtext(
                        title: "view all",
                        color: Colors.blue,
                        size: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Expanded(
                child: customstreambuilder(
                  collection: "imageurl3",
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
