import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class customtext extends StatelessWidget {
  const customtext(
      {required this.title,
      super.key,
      required this.color,
      required this.size,
      required this.fontWeight});
  final String title;
  final Color color;
  final double size;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
          color: color, fontSize: size, fontWeight: fontWeight),
    );
  }
}
