import 'package:carrentalapp/view/user/maun_page.dart';
import 'package:carrentalapp/widgets/customtext.dart';
import 'package:flutter/material.dart';

class Splashscreen3 extends StatefulWidget {
  const Splashscreen3({super.key});

  @override
  State<Splashscreen3> createState() => _Splashscreen3State();
}

class _Splashscreen3State extends State<Splashscreen3> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3))
        .whenComplete(() => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Mainscreen(),
            )));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/tickimage.png"))),
            ),
            const customtext(
              title: "Thank You For Trusting Us",
              color: Colors.amber,
              size: 20,
              fontWeight: FontWeight.bold,
            ),
            const customtext(
              title: "Enjoy Your Journey",
              color: Colors.amber,
              size: 20,
              fontWeight: FontWeight.bold,
            )
          ],
        ),
      ),
    );
  }
}
