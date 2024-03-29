import 'package:carrentalapp/Home/login.dart';
import 'package:carrentalapp/widgets/customtext.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Splash2screen extends StatefulWidget {
  const Splash2screen({super.key});

  @override
  State<Splash2screen> createState() => _Splash2screenState();
}

class _Splash2screenState extends State<Splash2screen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3))
        .whenComplete(() => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Loginscreen(),
            )));
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/tickimage.png"))),
            ),
            const customtext(
              title: "Thank You!",
              color: Colors.white,
              size: 30,
              fontWeight: FontWeight.bold,
            )
          ],
        ),
      ),
    );
  }
}
