import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../utils/mask_enum_util.dart';

class RoundedTextField extends StatelessWidget {

  RoundedTextField({
    super.key,
    required this.hint,
    required this.textController,
    required this.icon,
    required this.obscureText,
    required this.maskType
  });

  final String hint;
  final TextEditingController textController;
  final Icon icon;
  final bool obscureText;
  final MaskCustomType maskType;

  var maskInputFormatter = MaskTextInputFormatter();

  @override
  Widget build(BuildContext context) {
    switch (maskType) {
      case MaskCustomType.none:
        maskInputFormatter = MaskTextInputFormatter();
        break;
      case MaskCustomType.phone:
        maskInputFormatter = MaskTextInputFormatter(
            mask: '+55 (##) #####-####',
            filter: { "#": RegExp(r'[0-9]') },
            type: MaskAutoCompletionType.lazy
        );
        break;
    }

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: const Color(0xffEEEEEE),
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 20),
              blurRadius: 100,
              color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextField(
        controller: textController,
        cursorColor: const Color(0xff2e2e2e),
        decoration: InputDecoration(
          icon: icon,
          focusColor: const Color(0xff2e2e2e),
          hintText: hint,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        obscureText: obscureText,
        inputFormatters: [maskInputFormatter]
      ),
    );
  }
}