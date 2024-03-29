
import 'package:carrentalapp/widgets/customtext.dart';
import 'package:flutter/material.dart';
class customcontainer2 extends StatelessWidget {
  const customcontainer2({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: customtext(
            title: title,
            color: Colors.black,
            size: 15,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
