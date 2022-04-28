import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_list_bloc/Logic/bloc/search_bloc.dart';
import 'package:student_list_bloc/Logic/cubit/studentlist_cubit.dart';
import 'package:student_list_bloc/Presentation/Screens/Add%20Student/screen_manage_student.dart';
import 'package:student_list_bloc/Presentation/Screens/Details%20Screen/screen_details.dart';
import 'package:student_list_bloc/Presentation/Widgets/customtextformfield.dart';
import 'package:student_list_bloc/data/studentdb.dart';
import 'package:student_list_bloc/main.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String searchValue = '';
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('List of students'),
      ),
      body: Column(
        children: [
          sizedBox2,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                onChanged: (value) {
                  context.read<SearchBloc>().add(EnterValues(input: value));
                  searchValue = value;
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blueAccent,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: const Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blueAccent,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "Search here...",
                )),
          ),
          sizedBox2,
          Expanded(
            child: BlocBuilder<StudentlistCubit, StudentlistState>(
                builder: (context, state) {
              late List<StudentDb> dbList;

              dbList = state.list;
              return dbList.isNotEmpty
                  ? ListView.builder(
                      itemCount: dbList.length,
                      itemBuilder: (context, index) => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Positioned(
                                  top: -20,
                                  left: -60,
                                  child: Container(
                                      height: 250,
                                      width: 250,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color.fromARGB(
                                                  255, 141, 236, 255)
                                              .withOpacity(0.5)
                                              .withOpacity(
                                                  0.5) //background color with opacity
                                          ))),
                              Positioned(
                                  right: -120,
                                  top: -50,
                                  child: Container(
                                      height: 180,
                                      width: 180,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color.fromARGB(
                                                  255, 90, 212, 252)
                                              .withOpacity(0.5)))),
                              Positioned(
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => ScreenDetails(
                                              imagePath: dbList[index].imageUrl,
                                              initialAge: dbList[index].age,
                                              initialDomain: dbList[index].domain,
                                              initialName: dbList[index].name,
                                            )));
                                  },
                                  title: Text(dbList[index].name),
                                  leading: dbList[index].imageUrl == null
                                      ? const CircleAvatar(
                                          backgroundColor: Colors.blue,
                                        )
                                      : CircleAvatar(
                                          backgroundImage: FileImage(
                                            File(dbList[index].imageUrl!),
                                          ),
                                        ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (ctx) => ManageAddStudent(
                                                searchKey: searchValue,
                                                appBar: "Edit Student",
                                                dbKey: dbList[index].key,
                                                imagePath: dbList[index].imageUrl,
                                                initialAge: dbList[index].age,
                                                initialDomain:
                                                    dbList[index].domain,
                                                initialName: dbList[index].name,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          context
                                              .read<StudentlistCubit>()
                                              .delete(dbList[index].key);
                                          context
                                              .read<StudentlistCubit>()
                                              .allStudents(
                                                Hive.box<StudentDb>(studentDb)
                                                    .values
                                                    .toList(),
                                              );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const Center(child: Text('No data Found'));
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => ManageAddStudent(
                appBar: "Add Student",
                searchKey: searchValue,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
