import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function(String)? onChanged;
  final String label;
  final String? initialValue;
  final TextInputType keyBoard;
  final TextInputAction textInputAction;
  const CustomTextField({
    Key? key,
    this.onChanged,
    required this.label,
    this.initialValue,
    this.keyBoard = TextInputType.name,
    required this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      initialValue: initialValue,
      keyboardType: keyBoard,
      decoration: InputDecoration(
          border: const OutlineInputBorder(), label: Text(label)),
      onChanged: onChanged,
    );
  }
}

const SizedBox sizedBox1 = SizedBox(
  height: 10,
);
const SizedBox sizedBox2 = SizedBox(
  height: 20,
);
const SizedBox sizedBox3 = SizedBox(
  height: 30,
);
const SizedBox sizedBox4 = SizedBox(
  height: 40,
);
