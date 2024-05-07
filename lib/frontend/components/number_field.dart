import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xizmatdamiz/frontend/style/color.dart';

class NumberField extends StatelessWidget {
  const NumberField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: RGBcolor().mainColor, style: BorderStyle.solid)),
      width: 50,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          style: const TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
          decoration: const InputDecoration(border: InputBorder.none),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1)
          ],
        ),
      ),
    );
  }
}
