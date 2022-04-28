import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
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
  const ManageAddStudent({
    Key? key,
    required this.appBar,
    this.imagePath,
    this.initialName,
    this.initialAge,
    this.initialDomain,
    this.dbKey,
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
      appBar: AppBar(title: Text(widget.appBar)),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          // key: _formKey,
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
                            backgroundImage: FileImage(File(newImagePath!)),
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
                label: 'Age',
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
        ),
      )),
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
        context
            .read<StudentlistCubit>()
            .allStudents(Hive.box<StudentDb>(studentDb).values.toList());
        Navigator.of(context).pop();
      } else {
        box.put(
            widget.dbKey,
            StudentDb(
                name: newName!,
                age: newAge!,
                domain: newDmain!,
                imageUrl: newImagePath));
        context
            .read<StudentlistCubit>()
            .allStudents(Hive.box<StudentDb>(studentDb).values.toList());
        Navigator.of(context).pop();
      }
    }
  }
}
