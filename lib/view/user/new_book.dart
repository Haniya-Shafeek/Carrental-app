import 'package:carrentalapp/view/user/book_splash.dart';
import 'package:carrentalapp/view/user/new_singleview.dart';
import 'package:carrentalapp/widgets/customcontainer.dart';
import 'package:carrentalapp/widgets/customtext.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Newbookscreen extends StatefulWidget {
  const Newbookscreen({super.key, required this.docid});
  final String docid;
  @override
  State<Newbookscreen> createState() => _NewbookscreenState();
}

class _NewbookscreenState extends State<Newbookscreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late User? _curretuser;
  String email = "";
  String name = "";
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
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdetails();
    fetchdetails();
  }

  static const LatLng _pgoogleplex =
      LatLng(37.43296265331129, -122.08832357078792);
  String _selecteditem = "Delhi";
  DateTime selecteddate = DateTime.now();
  DateTime selecteddate2 = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("imageurl3")
              .doc(widget.docid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return Stack(
                children: [
                  const SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: GoogleMap(
                        initialCameraPosition:
                            CameraPosition(target: _pgoogleplex, zoom: 15)),
                  ),
                  Positioned(
                      left: 10,
                      top: 170,
                      child: Container(
                        height: 400,
                        width: 380,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const customtext(
                                    title: "Pick up",
                                    color: Colors.black,
                                    size: 15,
                                    fontWeight: FontWeight.bold),
                                Container(
                                  height: 50,
                                  width: 400,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        DropdownButton(
                                          value: _selecteditem,
                                          items: <String>[
                                            "Delhi",
                                            "Banglure",
                                            "Kochi",
                                            "chennai",
                                            "calicut",
                                            "pondicherry"
                                          ]
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) =>
                                                      DropdownMenuItem<String>(
                                                          value: value,
                                                          child: SizedBox(
                                                              width: 250,
                                                              child:
                                                                  Text(value))))
                                              .toList(),
                                          onChanged: (String? newvalue) {
                                            setState(() {
                                              _selecteditem = newvalue!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const customtext(
                                    title: "From",
                                    color: Colors.black,
                                    size: 15,
                                    fontWeight: FontWeight.bold),
                                Container(
                                  height: 50,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            final DateTime? dateTime =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: selecteddate,
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(3000));
                                            setState(() {
                                              selecteddate = dateTime!;
                                            });
                                          },
                                          icon:
                                              const Icon(Icons.calendar_month)),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                          "${selecteddate.day}/${selecteddate.month}/${selecteddate.year}")
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const customtext(
                                    title: "To",
                                    color: Colors.black,
                                    size: 15,
                                    fontWeight: FontWeight.bold),
                                Container(
                                  height: 50,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            final DateTime? dateTime2 =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: selecteddate,
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(3000));
                                            setState(() {
                                              selecteddate2 = dateTime2!;
                                            });
                                          },
                                          icon:
                                              const Icon(Icons.calendar_month)),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                          "${selecteddate2.day}/${selecteddate2.month}/${selecteddate2.year}")
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 35),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection("bookdetails")
                                              .doc(widget.docid)
                                              .set({
                                            "company": snapshot.data!["type"]
                                                .toString(),
                                            "type": snapshot.data!["company"]
                                                .toString(),
                                            "destination": _selecteditem,
                                            "from": selecteddate,
                                            "to": selecteddate2,
                                            "username": name,
                                            "useremail": email
                                          });
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const Splashscreen3(),
                                              ));
                                        },
                                        child: const customcontainer(
                                            textwidget: customtext(
                                                title: "Rent",
                                                color: Colors.white,
                                                size: 15,
                                                fontWeight: FontWeight.bold),
                                            color: Colors.green,
                                            height: 30,
                                            width: 150,
                                            curve: 50),
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Newwstsingleview(
                                                      docid: snapshot.data!.id
                                                          .toString()),
                                            )),
                                        child: const customcontainer(
                                            textwidget: customtext(
                                                title: "Cancel",
                                                color: Colors.white,
                                                size: 15,
                                                fontWeight: FontWeight.bold),
                                            color: Colors.blue,
                                            height: 30,
                                            width: 150,
                                            curve: 50),
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                        ),
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
