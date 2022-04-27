import 'package:hive_flutter/hive_flutter.dart';

part 'studentdb.g.dart';

@HiveType(typeId: 0)
class StudentDb extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String age;

  @HiveField(2)
  final String domain;

  @HiveField(3)
  final String? imageUrl;

  StudentDb({
    required this.name,
    required this.age,
    required this.domain,
    required this.imageUrl,
  });
}
