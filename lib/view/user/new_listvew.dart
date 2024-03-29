import 'package:carrentalapp/view/user/new_singleview.dart';
import 'package:carrentalapp/widgets/customtext.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Newestview extends StatefulWidget {
  const Newestview({super.key});

  @override
  State<Newestview> createState() => _NewestviewState();
}

class _NewestviewState extends State<Newestview> {
  double rating = 0;
  Future<void> _loadrating() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      rating = preferences.getDouble("rating3") ?? 0;
    });
  }

  Future<void> _saverating(double rating) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setDouble("rating3", rating);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadrating();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const customtext(
              title: "Newest",
              color: Colors.black,
              size: 18,
              fontWeight: FontWeight.bold),
        ),
        body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("imageurl3").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: double.infinity,
                      height: 400,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(30)),
                      child: const CircularProgressIndicator(),
                    ),
                  );
                },
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Newwstsingleview(
                              docid: snapshot.data!.docs[index].id.toString()),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        width: 400,
                        height: 170,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(-3, 5)),
                            ],
                            color: const Color.fromARGB(255, 245, 241, 241),
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 45, left: 20),
                              child: Column(
                                children: [
                                  customtext(
                                      title: snapshot.data!.docs[index]
                                          .get("company"),
                                      color: Colors.black,
                                      size: 15,
                                      fontWeight: FontWeight.bold),
                                  customtext(
                                      title: snapshot.data!.docs[index]
                                          .get("type"),
                                      color: Colors.black,
                                      size: 15,
                                      fontWeight: FontWeight.bold),
                                  customtext(
                                      title: snapshot.data!.docs[index]
                                          .get("price"),
                                      color: Colors.black,
                                      size: 15,
                                      fontWeight: FontWeight.normal),
                                  RatingBar.builder(
                                    initialRating: rating,
                                    itemSize: 20,
                                    updateOnDrag: true,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (value) {
                                      setState(() {
                                        rating = value;
                                        _saverating(rating);
                                      });
                                    },
                                  ),
                                  customtext(
                                      title: "Rating :$rating",
                                      color: Colors.black,
                                      size: 10,
                                      fontWeight: FontWeight.bold)
                                ],
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 300,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(snapshot
                                          .data!.docs[index]
                                          .get("url")))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: double.infinity,
                      height: 400,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(Icons.error),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
