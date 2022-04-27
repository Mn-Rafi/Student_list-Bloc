import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonnText;
  final VoidCallback? onTap;
  const CustomButton({
    Key? key,
    required this.buttonnText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? (){},
      child: Container(
        padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Color.fromARGB(255, 255, 255, 255),
                ],
              )),
          child: Text(buttonnText)),
    );
  }
}
