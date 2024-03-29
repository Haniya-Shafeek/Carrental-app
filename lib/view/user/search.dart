import 'package:carrentalapp/utilities/lists.dart';
import 'package:carrentalapp/widgets/customtext.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  final TextEditingController searchcontroller = TextEditingController();
  String _selecteditem = "Tesla Model3";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 8,
            top: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: searchcontroller,
                decoration: InputDecoration(
                    suffix: DropdownButton(
                      value: _selecteditem,
                      items: Lists()
                          .cars
                          .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: SizedBox(
                                    width: 100,
                                    child: Text(value),
                                  )))
                          .toList(),
                      onChanged: (String? newvalue) {
                        setState(() {
                          _selecteditem = newvalue!;
                        });
                      },
                    ),
                    hintText: _selecteditem,
                    helperStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    contentPadding: const EdgeInsets.all(2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                      30,
                    ))),
              ),
              const SizedBox(
                height: 15,
              ),
              const customtext(
                  title: "Popular Brands",
                  color: Colors.black,
                  size: 17,
                  fontWeight: FontWeight.bold),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  itemCount: Lists().brands.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Lists().brands[index])),
                              borderRadius: BorderRadius.circular(90)),
                        ),
                        customtext(
                            title: Lists().names[index],
                            color: Colors.black,
                            size: 15,
                            fontWeight: FontWeight.bold)
                      ],
                    );
                  },
                ),
              ),
              const customtext(
                  title: "Popular Cars",
                  color: Colors.black,
                  size: 17,
                  fontWeight: FontWeight.bold),
              Expanded(
                flex: 3,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("imageurl")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData) {
                        return GridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns
                            crossAxisSpacing:
                                10.0, // Spacing between each column
                            mainAxisSpacing: 10.0, // Spacing between each row
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              height: index.isEven ? 150.0 : 90.0,
                              width: 90,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(snapshot
                                          .data!.docs[index]
                                          .get("url")))),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Icon(Icons.error),
                        );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
