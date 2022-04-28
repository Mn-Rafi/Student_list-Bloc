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
    return Scaffold(
      appBar: AppBar(
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
              print('OKKKDAAAAAAAAAAAAAAAAAAA == ${state.list.length}');
              print('ENNEDAAAAAAAAAAAAAAAAAAAAAAAAAA ==  ${dbList.length}');
              return dbList.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: dbList.length,
                      itemBuilder: (context, index) => Card(
                        margin: const EdgeInsets.all(10),
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
                                        appBar: "Edit Student",
                                        dbKey: dbList[index].key,
                                        imagePath: dbList[index].imageUrl,
                                        initialAge: dbList[index].age,
                                        initialDomain: dbList[index].domain,
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
                                  context.read<StudentlistCubit>().allStudents(
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
              builder: (ctx) => const ManageAddStudent(
                appBar: "Add Student",
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
