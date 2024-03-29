import 'package:carrentalapp/view/user/affo_booking.dart';
import 'package:carrentalapp/widgets/customcontainer.dart';
import 'package:carrentalapp/widgets/customtext.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class Affordablesingleview extends StatefulWidget {
  const Affordablesingleview({super.key, required this.docid});
  final String docid;

  @override
  State<Affordablesingleview> createState() => _AffordablesingleviewState();
}

class _AffordablesingleviewState extends State<Affordablesingleview> {
  bool isliked = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("imageurl2")
              .doc(widget.docid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return Stack(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Affordablesingleview(
                              docid: snapshot.data!.toString()),
                        )),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                customtext(
                                    title: snapshot.data!["type"].toString(),
                                    color: Colors.black,
                                    size: 23,
                                    fontWeight: FontWeight.w700),
                                const SizedBox(
                                  width: 10,
                                ),
                                customtext(
                                    title: snapshot.data!["company"].toString(),
                                    color: Colors.black,
                                    size: 23,
                                    fontWeight: FontWeight.w500),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isliked = !isliked;
                                        });
                                      },
                                      icon: Icon(
                                        isliked
                                            ? EvaIcons.heart
                                            : EvaIcons.heartOutline,
                                        color:
                                            isliked ? Colors.red : Colors.black,
                                        size: 30,
                                      )),
                                )
                              ],
                            ),
                            customtext(
                                title: snapshot.data!["price"].toString(),
                                color: Colors.orange,
                                size: 18,
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 320,
                    child: Container(
                      height: 400,
                      width: 400,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 220, 206, 206),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 50, left: 20, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const customtext(
                                title: "About",
                                color: Colors.black,
                                size: 18,
                                fontWeight: FontWeight.bold),
                            const SizedBox(
                              height: 5,
                            ),
                            customtext(
                                title: snapshot.data!["about"].toString(),
                                color: Colors.black,
                                size: 15,
                                fontWeight: FontWeight.w500),
                            const SizedBox(
                              height: 10,
                            ),
                            const customtext(
                                title: "Specification",
                                color: Colors.black,
                                size: 18,
                                fontWeight: FontWeight.bold),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    const Icon(
                                      Icons.speed_outlined,
                                      size: 30,
                                    ),
                                    customtext(
                                        title:
                                            snapshot.data!["speed"].toString(),
                                        color: Colors.black,
                                        size: 10,
                                        fontWeight: FontWeight.bold),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 70,
                                  width: 5,
                                  decoration:
                                      const BoxDecoration(color: Colors.grey),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    const Icon(
                                      Icons.airline_seat_recline_extra,
                                      size: 30,
                                    ),
                                    customtext(
                                        title:
                                            snapshot.data!["seat"].toString(),
                                        color: Colors.black,
                                        size: 10,
                                        fontWeight: FontWeight.bold),
                                  ],
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Affobookingscreen(
                                          docid:
                                              snapshot.data!.id.toString()))),
                              child: const Padding(
                                  padding: EdgeInsets.only(top: 20, left: 30),
                                  child: customcontainer(
                                      textwidget: Center(
                                        child: customtext(
                                            title: "Book Now",
                                            color: Colors.white,
                                            size: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      color: Colors.green,
                                      height: 40,
                                      width: 300,
                                      curve: 30)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      left: 20,
                      top: 40,
                      child: Container(
                        height: 350,
                        width: 350,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    snapshot.data!["url"].toString()))),
                      ))
                ],
              );
            } else {
              return const Center(
                child: Icon(Icons.error),
              );
            }
          },
        ),
      ),
    );
  }
}
