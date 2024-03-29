import 'package:carrentalapp/view/user/home.dart';
import 'package:carrentalapp/view/user/profile.dart';
import 'package:carrentalapp/view/user/search.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  int currentindex = 0;
  List pages = [
    const Homescreen(),
    const Searchscreen(),
    const Profilescreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          onTap: (index) {
            setState(() {
              currentindex = index;
            });
          },
          backgroundColor: Colors.black,
          color: Colors.white,
          items: const [
            Icon(Icons.home),
            Icon(
              Icons.search,
            ),
            Icon(Icons.person)
          ]),
      body: pages[currentindex],
    );
  }
}
