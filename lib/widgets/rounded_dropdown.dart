import 'package:flutter/material.dart';

class RoundedDropdown extends StatelessWidget {

  RoundedDropdown({
    super.key,
    required this.hint,
    required this.newValue,
    required this.listValues
  });

  final Text hint;
  late String? newValue;
  final List<String> listValues;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(50),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(6),
          isExpanded: true,
          //value: newValue,
          items: listValues.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          hint: hint,
          onChanged: (String? value) {
            newValue = value;
          },
        ),
      ),
    );
  }
}