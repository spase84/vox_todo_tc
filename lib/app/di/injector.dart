import 'package:kiwi/kiwi.dart';
// import 'package:notes/app/data/datasource/isar_datasource.dart';
// import 'package:notes/app/data/datasource/note_datasource.dart';
// import 'package:notes/app/data/repository/note_repository_impl.dart';
// import 'package:notes/app/domain/repository/note_repository.dart';

part 'injector.g.dart';

abstract class Injector {
  static late KiwiContainer container;

  static Future<void> setup() async {
    container = KiwiContainer();
    await _$Injector()._configure();
  }

  static final T Function<T>([String? name]) resolve = container.resolve;

  Future<void> _configure() async {
    // _configureDataSource();
    // _configureRepositories();
  }

  // @Register.factory(NoteDataSource, from: IsarDatasource)
  // void _configureDataSource();

  // @Register.factory(NoteRepository, from: NoteRepositoryImpl)
  // void _configureRepositories();
}
