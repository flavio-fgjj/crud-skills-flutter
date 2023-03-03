import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {

  const RoundedButton({
    super.key,
    required this.text,
    required this.color
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Color(0xffEEEEEE)),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      );
  }
}