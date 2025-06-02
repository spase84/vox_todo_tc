// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configureDataSource() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory<TodoDataSource>((c) => IsarDatasource());
  }

  @override
  void _configureRepositories() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory<TodoRepository>(
        (c) => TodoRepositoryImpl(dataSource: c<TodoDataSource>()));
  }
}
