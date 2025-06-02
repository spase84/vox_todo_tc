import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vox_todo/app/data/datasource/interface/todo_datasource.dart'
    show TodoDataSource;
import 'package:vox_todo/app/domain/entity/todo.dart'
    show GetTodoCollection, Todo, TodoQuerySortBy, TodoSchema;

class IsarDatasource implements TodoDataSource {
  IsarDatasource() {
    db = _openDb();
  }

  late Future<Isar> db;

  @override
  Future<List<Todo>> getList({required int page, required int pageSize}) async {
    final isar = await db;
    return isar.todos
        .where()
        .sortByUpdatedAtDesc()
        .offset((page - 1) * pageSize)
        .limit(pageSize)
        .findAllSync();
  }

  @override
  Future<Todo?> get(int id) async {
    final isar = await db;
    return isar.todos.getSync(id);
  }

  @override
  Future<void> save(Todo todo) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.todos.putSync(todo));
  }

  Future<Isar> _openDb() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [TodoSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> delete(int id) async {
    final isar = await db;
    return isar.writeTxn(() => isar.todos.delete(id));
  }
}
