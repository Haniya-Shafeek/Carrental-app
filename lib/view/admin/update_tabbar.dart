import 'package:carrentalapp/view/admin/affo_update.dart';
import 'package:carrentalapp/view/admin/upload_tabbar.dart';

import 'package:carrentalapp/view/admin/new_view.dart';

import 'package:carrentalapp/view/admin/popular_view.dart';

import 'package:carrentalapp/widgets/customtext.dart';

import 'package:flutter/material.dart';

class Updatescreen extends StatefulWidget {
  const Updatescreen({super.key});

  @override
  State<Updatescreen> createState() => _UpdatescreenState();
}

class _UpdatescreenState extends State<Updatescreen> {
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Tabbarscreen(),
                      ));
                },
                child: const Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ))
          ],
          title: const customtext(
              title: "Update",
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
        body: const TabBarView(children: [
          Popularupdatescrren(),
          Affoupdatescreen(),
          Newestupdatescreen()
        ]),
      ),
    );
  }
}
