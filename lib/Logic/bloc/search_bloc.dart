import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_list_bloc/Logic/cubit/studentlist_cubit.dart';
import 'package:student_list_bloc/data/studentdb.dart';
import 'package:student_list_bloc/main.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc()
      : super(SearchInitial(
            allStudents: studentListCubit
                .allStudents(Hive.box<StudentDb>(studentDb).values.toList()))) {
    on<SearchEvent>((event, emit) {
      if (event is EnterValues) {
        List<StudentDb> newListofStudents = Hive.box<StudentDb>(studentDb)
            .values
            .toList()
            .where((element) =>
                element.name.toLowerCase().contains(event.input.toLowerCase()))
            .toList();
        emit(SearchInitial(
            allStudents: studentListCubit.allStudents(newListofStudents)));
        print('Shavammmmmmmmmmmmmmmmmmmm111111111');
        print(newListofStudents);
      }
      if (event is ClearValues) {
        List<StudentDb> allStudents =
            Hive.box<StudentDb>(studentDb).values.toList().toList();
        emit(SearchInitial(
            allStudents: studentListCubit.allStudents(allStudents)));
        print('Shavammmmmmmmmmmmmmmmmmmm');
        print(allStudents);
      }
    });
  }
}
