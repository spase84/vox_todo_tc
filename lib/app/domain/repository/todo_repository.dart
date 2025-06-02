import 'package:vox_todo/app/domain/entity/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getList({required int page, required int pageSize});
  Future<Todo?> get(int id);
  Future<void> save(Todo note);
  Future<void> delete(int id);
}
