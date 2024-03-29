import 'package:carrentalapp/view/admin/affo_singleview.dart';
import 'package:carrentalapp/view/user/new_singleview.dart';
import 'package:carrentalapp/view/user/popular_singleview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carrentalapp/widgets/customtext.dart';

class customstreambuilder extends StatelessWidget {
  const customstreambuilder({super.key, required this.collection});
  final String collection;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(collection).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState) {
          return ListView.builder(
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 20,
                  right: 20,
                ),
                child: Container(
                  height: 150,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange,
                  ),
                  child: const CircularProgressIndicator(),
                ),
              );
            },
          );
        }
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, top: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    if (collection == "imageurl") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Popularsingleview(
                                docid:
                                    snapshot.data!.docs[index].id.toString()),
                          ));
                    } else if (collection == "imageurl2") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Affordablesingleview(
                                docid:
                                    snapshot.data!.docs[index].id.toString()),
                          ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Newwstsingleview(
                                docid:
                                    snapshot.data!.docs[index].id.toString()),
                          ));
                    }
                  },
                  child: Container(
                    height: 150,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 222, 214, 214),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      snapshot.data!.docs[index].get("url")))),
                        ),
                        customtext(
                            title: snapshot.data!.docs[index].get("company"),
                            color: Colors.black,
                            size: 15,
                            fontWeight: FontWeight.bold),
                        customtext(
                            title: snapshot.data!.docs[index].get("type"),
                            color: Colors.black,
                            size: 10,
                            fontWeight: FontWeight.w500),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Expanded(
            child: ListView.builder(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20),
                  child: Container(
                      height: 150,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange,
                      ),
                      child: const Icon(Icons.error)),
                );
              },
            ),
          );
        }
      },
    );
  }
}
