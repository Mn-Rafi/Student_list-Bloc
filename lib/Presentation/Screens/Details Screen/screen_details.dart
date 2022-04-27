import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_list_bloc/Presentation/Widgets/customtextformfield.dart';

class ScreenDetails extends StatelessWidget {
  final String? imagePath;
  final String initialName;
  final String initialAge;
  final String initialDomain;
  const ScreenDetails({
    Key? key,
    required this.imagePath,
    required this.initialName,
    required this.initialAge,
    required this.initialDomain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(initialName),
            sizedBox3,
            imagePath == null
                ? const CircleAvatar(
                    radius: 120,
                    backgroundColor: Colors.blue,
                  )
                : CircleAvatar(
                    radius: 120,
                    backgroundImage: FileImage(File(imagePath!)),
                  ),
                sizedBox3,
                Text(initialAge),
                sizedBox3,
                Text(initialDomain)
          ],
        ),
      ),
    );
  }
}
