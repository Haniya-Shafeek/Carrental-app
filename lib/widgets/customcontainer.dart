import 'package:flutter/material.dart';

class customcontainer extends StatelessWidget {
  const customcontainer(
      {super.key, required this.textwidget, required this.color,required this.height,required this.width,required this.curve});
  final Widget textwidget;
  final Color color;
     final double width;
  final double height;
  final double curve;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(curve), color: color),
      child: Center(
        child: textwidget,
      ),
    );
  }
}



