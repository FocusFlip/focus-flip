import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon(
      {super.key, required this.size, required this.icon, required this.color});

  final double size;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size / 3),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(
        icon,
        color: Colors.white,
        size: size,
      ),
    );
  }
}
