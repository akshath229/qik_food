import 'package:flutter/material.dart';


class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColour;
  final Color iconColor;
  final double size;

  const AppIcon({Key? key,
  required this.icon,
  this.size=45,
  this.backgroundColour=Colors.white,
  this.iconColor=Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: backgroundColour
      ),
      child: Icon(icon),
    );
  }
}
