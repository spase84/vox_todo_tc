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

  bool get isShouldShowUpdatedAt => updatedAt != createdAt;

  Todo copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Note{id: $id, title: $title, description: $description, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  bool isValid() {
    return title.isNotEmpty;
  }
}
