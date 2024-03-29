import 'package:carrentalapp/view/admin/popular_edit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Popularupdatescrren extends StatefulWidget {
  const Popularupdatescrren({super.key});

  @override
  State<Popularupdatescrren> createState() => _PopularupdatescrrenState();
}

class _PopularupdatescrrenState extends State<Popularupdatescrren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("imageurl").snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(
                              snapshot.data!.docs[index].get("url")),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(snapshot.data!.docs[index].get("type")),
                                Text(snapshot.data!.docs[index].get("company"))
                              ],
                            ),
                            Text(snapshot.data!.docs[index].get("price"))
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Updatedetailsscreen(
                                        docid: snapshot.data!.docs[index].id
                                            .toString()),
                                  ));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.amber,
                            )),
                      ],
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("imageurl")
                              .doc(snapshot.data!.docs[index].id)
                              .delete();
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.amber,
                        )),
                  );
                },
              );
            } else {
              return const Text("no data");
            }
          },
        ),
      ),
    );
  }
}
