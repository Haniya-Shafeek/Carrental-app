import 'package:carrentalapp/controllers/splash_controller.dart';

import 'package:carrentalapp/widgets/customtext.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashprovider = Provider.of<Splashcontrol1er>(context, listen: true);
    Future.delayed(const Duration(seconds: 4))
        .whenComplete(() => splashprovider.checklogin(context));
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: customtext(
          title: "Car2go",
          color: Colors.orange,
          size: 35,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
