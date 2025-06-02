import 'package:kiwi/kiwi.dart';
import 'package:vox_todo/app/data/datasource/isar_datasource.dart'
    show IsarDatasource;
import 'package:vox_todo/app/data/datasource/interface/todo_datasource.dart'
    show TodoDataSource;
import 'package:vox_todo/app/data/repository/todo_repository_impl.dart'
    show TodoRepositoryImpl;
import 'package:vox_todo/app/domain/repository/todo_repository.dart'
    show TodoRepository;

part 'injector.g.dart';

abstract class Injector {
  static late KiwiContainer container;

  static Future<void> setup() async {
    container = KiwiContainer();
    await _$Injector()._configure();
  }

  static final T Function<T>([String? name]) resolve = container.resolve;

  Future<void> _configure() async {
    _configureDataSource();
    _configureRepositories();
  }

  @Register.factory(TodoDataSource, from: IsarDatasource)
  void _configureDataSource();

  @Register.factory(TodoRepository, from: TodoRepositoryImpl)
  void _configureRepositories();
}
