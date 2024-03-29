import 'package:carrentalapp/view/admin/main_page.dart';
import 'package:carrentalapp/view/admin/update_tabbar.dart';

import 'package:carrentalapp/view/admin/popular_upload.dart';
import 'package:carrentalapp/view/admin/affod_upload.dart';
import 'package:carrentalapp/view/admin/new_upload.dart';
import 'package:carrentalapp/widgets/customtext.dart';
import 'package:flutter/material.dart';

class Tabbarscreen extends StatefulWidget {
  const Tabbarscreen({super.key});

  @override
  State<Tabbarscreen> createState() => _TabbarscreenState();
}

class _TabbarscreenState extends State<Tabbarscreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade200,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Adminmainscreen(),
                      ));
                },
                child: const Text("save"))
          ],
          title: const customtext(
              title: "Add image",
              color: Colors.white,
              size: 20,
              fontWeight: FontWeight.bold),
          bottom: const TabBar(tabs: [
            Tab(
              text: "Popular",
            ),
            Tab(
              text: "Affordable",
            ),
            Tab(
              text: "New",
            )
          ]),
        ),
        body: const TabBarView(
            children: [Uploadscreen(), Upload2screen(), Upload3screen()]),
      ),
    );
  }
}
