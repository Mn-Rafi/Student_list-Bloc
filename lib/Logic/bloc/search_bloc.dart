import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_list_bloc/data/studentdb.dart';
import 'package:student_list_bloc/main.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc()
      : super(SearchInitial(
            allStudents: Hive.box<StudentDb>(studentDb).values.toList())) {
    on<SearchEvent>((event, emit) {
      if (event is EnterValues) {
        List<StudentDb> newListofStudents = Hive.box<StudentDb>(studentDb)
            .values
            .toList()
            .where((element) =>
                element.name.toLowerCase().contains(event.input.toLowerCase()))
            .toList();
        emit(SearchInitial(allStudents: newListofStudents));

        print('SAKKUDUUUUUUUUUUUUUUU');
        print(newListofStudents.length);
      } else if (event is ClearValues) {
        emit(SearchInitial(
            allStudents: Hive.box<StudentDb>(studentDb).values.toList()));
      }
    });
  }
}
