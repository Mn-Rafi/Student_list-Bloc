import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_list_bloc/data/studentdb.dart';
import 'package:student_list_bloc/main.dart';

part 'studentlist_state.dart';

class StudentlistCubit extends Cubit<StudentlistState> {
  StudentlistCubit() : super(StudentlistState(list: Hive.box<StudentDb>(studentDb).values.toList()));

  String imageAdd(String imageUl) {
    emit(StudentlistState(imageUrl: imageUl, list: Hive.box<StudentDb>(studentDb).values.toList()));
    return state.imageUrl!;
  }

  List<StudentDb> allStudents(List<StudentDb> list){
    emit(StudentlistState(list: list));
    return state.list;
  }

  delete(int key){
    Hive.box<StudentDb>(studentDb).delete(key);
  }
}


final studentListCubit = StudentlistCubit();