import 'package:carrentalapp/view/user/maun_page.dart';
import 'package:carrentalapp/widgets/customtext.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Bookdetailsscreen extends StatefulWidget {
  const Bookdetailsscreen({super.key});

  @override
  State<Bookdetailsscreen> createState() => _BookdetailsscreenState();
}

class _BookdetailsscreenState extends State<Bookdetailsscreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade200,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Mainscreen(),
                      ));
                },
                child:
                    const Text("Home", style: TextStyle(color: Colors.white))),
          ],
          title: const Center(
            child: customtext(
                title: "Booking",
                color: Colors.white,
                size: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("bookdetails").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title:
                            Text(snapshot.data!.docs[index].get("useremail")),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data!.docs[index].get("username")),
                            Row(
                              children: [
                                Text(snapshot.data!.docs[index].get("type")),
                                Text(snapshot.data!.docs[index].get("company")),
                              ],
                            ),
                            Text(snapshot.data!.docs[index].get("destination")),
                            Text(
                                "From:${snapshot.data!.docs[index].get("from").toString()}"),
                            Text(
                                "To: ${snapshot.data!.docs[index].get("to").toString()}"),
                          ],
                        ),
                      ),
                      const Divider()
                    ],
                  );
                },
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
