import 'package:vox_todo/app/domain/entity/todo.dart';

abstract class TodoDataSource {
  Future<List<Todo>> getList({required int page, required int pageSize});
  Future<void> save(Todo todo);
  Future<Todo?> get(int id);
  Future<bool> delete(int id);
}
