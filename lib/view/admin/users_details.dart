import 'package:carrentalapp/widgets/customtext.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Userdetailsscreen extends StatefulWidget {
  const Userdetailsscreen({super.key});

  @override
  State<Userdetailsscreen> createState() => _UserdetailsscreenState();
}

class _UserdetailsscreenState extends State<Userdetailsscreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade200,
          title: const Center(
            child: customtext(
                title: "Users",
                color: Colors.white,
                size: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("mydatabase").snapshots(),
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
                  return ListTile(
                      title: Row(children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(snapshot.data!.docs[index].get("url")),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data!.docs[index].get("email")),
                        Text(snapshot.data!.docs[index].get("name")),
                        Text(snapshot.data!.docs[index].get("phone")),
                      ],
                    ),
                  ]));
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
