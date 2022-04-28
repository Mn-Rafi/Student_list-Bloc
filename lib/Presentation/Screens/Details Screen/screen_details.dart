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
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Student Details'),
      ),
      body: Center(
        child: Container(
          height: 450,
          width: 300,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 216, 242, 252),
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 234, 234, 234),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: -20,
                    left: -50,
                    child: Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(255, 141, 236, 255)
                                .withOpacity(0.5)
                                .withOpacity(
                                    0.5) //background color with opacity
                            ))),
                Positioned(
                    left: -80,
                    top: -50,
                    child: Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(255, 90, 212, 252)
                                .withOpacity(0.5)))),
                Positioned(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        sizedBox3,
                        imagePath == null
                            ? const CircleAvatar(
                                radius: 100,
                                backgroundColor: Colors.blue,
                              )
                            : CircleAvatar(
                                radius: 100,
                                backgroundImage: FileImage(File(imagePath!)),
                              ),
                        sizedBox3,
                        Card(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 141, 236, 255),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: 200,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Name : ',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.red,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        " $initialName",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 141, 236, 255),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: 200,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Phone : ',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.red,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        " $initialAge",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 141, 236, 255),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: 200,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Domain : ',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.red,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        " $initialDomain",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
