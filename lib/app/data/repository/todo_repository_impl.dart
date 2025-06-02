import 'package:vox_todo/app/data/datasource/interface/todo_datasource.dart'
    show TodoDataSource;
import 'package:vox_todo/app/domain/entity/todo.dart' show Todo;
import 'package:vox_todo/app/domain/repository/todo_repository.dart'
    show TodoRepository;

final class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl({required this.dataSource});

  final TodoDataSource dataSource;

  @override
  Future<List<Todo>> getList({required int page, required int pageSize}) async {
    return dataSource.getList(page: page, pageSize: pageSize);
  }

  @override
  Future<Todo?> get(int id) async {
    return dataSource.get(id);
  }

  @override
  Future<void> save(Todo note) async {
    return dataSource.save(note);
  }

  @override
  Future<bool> delete(int id) async {
    return dataSource.delete(id);
  }
}
