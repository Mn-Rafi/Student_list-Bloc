part of 'studentlist_cubit.dart';

@immutable
class StudentlistState extends Equatable {
  final String? imageUrl;
   final List<StudentDb> list;
  const StudentlistState({
    this.imageUrl,
    required this.list
  });

  @override
  List<Object?> get props => [
    imageUrl,
    list
  ];

}




