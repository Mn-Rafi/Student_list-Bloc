part of 'studentlist_cubit.dart';

@immutable
class StudentlistState {
  final String? imageUrl;
  final List<StudentDb> list;
  const StudentlistState({this.imageUrl, required this.list});
}

class AllStudentState extends StudentlistState {
  final List<StudentDb> studentsList;
  const AllStudentState({required this.studentsList})
      : super(list: studentsList);
}

class NoResultState extends StudentlistState {
  NoResultState({List<StudentDb>? list}) : super(list: []);
}
