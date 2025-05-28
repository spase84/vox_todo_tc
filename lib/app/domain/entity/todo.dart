import 'package:isar/isar.dart';

part 'todo.g.dart';

@Collection()
class Todo {
  Id? id = Isar.autoIncrement;
  late String title;
  late String description;
  late DateTime createdAt;
  late DateTime updatedAt;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });
}
