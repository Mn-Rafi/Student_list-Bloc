import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:student_list_bloc/Logic/bloc/search_bloc.dart';
import 'package:student_list_bloc/Logic/cubit/studentlist_cubit.dart';
import 'package:student_list_bloc/Presentation/Widgets/custom_button.dart';
import 'package:student_list_bloc/Presentation/Widgets/customtextformfield.dart';
import 'package:student_list_bloc/data/studentdb.dart';
import 'package:student_list_bloc/main.dart';

class ManageAddStudent extends StatefulWidget {
  final String appBar;
  final String? imagePath;
  final String? initialName;
  final String? initialAge;
  final String? initialDomain;
  final int? dbKey;
  final String searchKey;
  const ManageAddStudent({
    Key? key,
    required this.appBar,
    this.imagePath,
    this.initialName,
    this.initialAge,
    this.initialDomain,
    this.dbKey,
    required this.searchKey,
  }) : super(key: key);

  @override
  State<ManageAddStudent> createState() => _ManageAddStudentState();
}

class _ManageAddStudentState extends State<ManageAddStudent> {
  String? newName;
  String? newAge;
  String? newDmain;
  int? keyFact;
  String? newImagePath;

  // final _formKey = GlobalKey<FormState>();
  Box<StudentDb> box = Hive.box<StudentDb>(studentDb);

  @override
  void initState() {
    newName = widget.initialName;
    newAge = widget.initialAge;
    newDmain = widget.initialDomain;
    newImagePath = widget.imagePath;
    keyFact = widget.dbKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(widget.appBar),
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 216, 242, 252),
            boxShadow: [
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
                  child: Center(
                    child: SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          BlocBuilder<StudentlistCubit, StudentlistState>(
                              builder: (context, state) {
                            return Column(
                              children: [
                                newImagePath == null
                                    ? const CircleAvatar(
                                        radius: 120,
                                        backgroundColor: Colors.blue,
                                      )
                                    : CircleAvatar(
                                        radius: 120,
                                        backgroundImage:
                                            FileImage(File(newImagePath!)),
                                      ),
                                sizedBox1,
                                TextButton(
                                  onPressed: () async {
                                    final pickedFile = await ImagePicker()
                                        .getImage(source: ImageSource.gallery);
                                    newImagePath = context
                                        .read<StudentlistCubit>()
                                        .imageAdd(pickedFile!.path);
                                  },
                                  child: const Text('Tap To Select image'),
                                ),
                              ],
                            );
                          }),
                          sizedBox1,
                          CustomTextField(
                            textInputAction: TextInputAction.next,
                            initialValue: newName ?? '',
                            label: 'Name',
                            onChanged: (value) {
                              newName = value;
                            },
                          ),
                          sizedBox1,
                          CustomTextField(
                            textInputAction: TextInputAction.next,
                            initialValue: newAge ?? '',
                            label: 'Phone Number',
                            onChanged: (value) {
                              newAge = value;
                            },
                            keyBoard: TextInputType.number,
                          ),
                          sizedBox1,
                          CustomTextField(
                            textInputAction: TextInputAction.done,
                            initialValue: newDmain ?? '',
                            label: 'Domain',
                            onChanged: (value) {
                              newDmain = value;
                            },
                          ),
                          sizedBox2,
                          BlocBuilder<StudentlistCubit, StudentlistState>(
                            builder: (context, state) {
                              return CustomButton(
                                buttonnText: "Submit",
                                onTap: () {
                                  submitFunction();
                                },
                              );
                            },
                          )
                        ],
                      ),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  submitFunction() async {
    if (newName == '' ||
        newDmain == '' ||
        newAge == '' ||
        newName == null ||
        newDmain == null ||
        newAge == null ||
        newImagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All fields are required')));
    } else {
      if (keyFact == null) {
        box.add(StudentDb(
            name: newName!,
            age: newAge!,
            domain: newDmain!,
            imageUrl: newImagePath));

        context.read<SearchBloc>().add(EnterValues(input: widget.searchKey));
        Navigator.of(context).pop();
      } else {
        box.put(
            widget.dbKey,
            StudentDb(
                name: newName!,
                age: newAge!,
                domain: newDmain!,
                imageUrl: newImagePath));
        context.read<SearchBloc>().add(EnterValues(input: widget.searchKey));
        Navigator.of(context).pop();
      }
    }
  }
}
