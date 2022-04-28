import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_list_bloc/Logic/bloc/search_bloc.dart';
import 'package:student_list_bloc/data/studentdb.dart';
import 'package:student_list_bloc/main.dart';
part 'studentlist_state.dart';

class StudentlistCubit extends Cubit<StudentlistState> {
  final List<StudentDb> listofStudents;
  final SearchBloc searchBloc;
  late StreamSubscription subscription;

  StudentlistCubit({
    required this.listofStudents,
    required this.searchBloc,
  }) : super(StudentlistState(list: listofStudents)) {
    emit(AllStudentState(studentsList: listofStudents));
    subscription = searchBloc.stream.listen((state) {
      if (state is SearchInitial) {
        studentListUpdated(state.allStudents);
      } else {
        emit(AllStudentState(studentsList: listofStudents));
      }
    });
  }

  void studentListUpdated(List<StudentDb> list) {
    emit(AllStudentState(studentsList: list));
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }

  String imageAdd(String imageUl) {
    emit(StudentlistState(
        imageUrl: imageUl,
        list: Hive.box<StudentDb>(studentDb).values.toList()));
    return state.imageUrl!;
  }

  List<StudentDb> allStudents(List<StudentDb> list) {
    emit(StudentlistState(list: list));
    return state.list;
  }

  delete(int key) {
    Hive.box<StudentDb>(studentDb).delete(key);
  }
}
