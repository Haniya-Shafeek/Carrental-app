import 'package:carrentalapp/view/admin/admin_profile.dart';
import 'package:carrentalapp/view/admin/book_details.dart';
import 'package:carrentalapp/view/admin/update_tabbar.dart';
import 'package:carrentalapp/view/admin/users_details.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Adminmainscreen extends StatefulWidget {
  const Adminmainscreen({super.key});

  @override
  State<Adminmainscreen> createState() => _AdminmainscreenState();
}

class _AdminmainscreenState extends State<Adminmainscreen> {
  int currentindex = 0;
  List pages = [
    const Userdetailsscreen(),
    const Updatescreen(),
    const Bookdetailsscreen(),
    const Adminprofilepage()
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
            Icon(Icons.groups_3),
            Icon(
              Icons.update,
            ),
            Icon(Icons.car_rental),
            Icon(Icons.person)
          ]),
      body: pages[currentindex],
    );
  }
}
