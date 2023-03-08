import 'package:flutter/material.dart';

class RoundedButtonIcon extends StatelessWidget {

  const RoundedButtonIcon({
    super.key,
    required this.icon,
    required this.color
  });

  final Icon icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 50,
              color: Color(0xffEEEEEE)),
        ],
      ),
      child: icon,
    );
  }
}