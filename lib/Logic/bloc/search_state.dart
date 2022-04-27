part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {
  final List<StudentDb> allStudents;
  const SearchInitial({
    required this.allStudents,
  });
}
