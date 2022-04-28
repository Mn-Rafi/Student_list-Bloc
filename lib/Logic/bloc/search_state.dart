part of 'search_bloc.dart';

abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {
  final List<StudentDb> allStudents;
  const SearchInitial({
    required this.allStudents,
  });
}
