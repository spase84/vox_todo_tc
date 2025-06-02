import 'package:flutter_riverpod/flutter_riverpod.dart' show StateNotifier;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart'
    show PagingController;
import 'package:vox_todo/app/di/injector.dart' show Injector;
import 'package:vox_todo/app/domain/entity/todo.dart';
import 'package:vox_todo/app/domain/repository/todo_repository.dart'
    show TodoRepository;
import 'package:vox_todo/app/features/todo/list/domain/state.dart';
import 'package:vox_todo/app/settings/constants.dart' show AppConstants;

final class ListScreenNotifier extends StateNotifier<TodoListState> {
  ListScreenNotifier() : super(const TodoListStateLoading());

  final TodoRepository _repository = Injector.resolve<TodoRepository>();

  final PagingController<int, Todo> _pagingController = PagingController(
    firstPageKey: 1,
  );

  void init() {
    _pagingController.addPageRequestListener(_fetchPage);
    state = TodoListStateSuccess(pagingController: _pagingController);
  }

  Future<void> _fetchPage(int page) async {
    final items = await _repository.getList(
      page: page,
      pageSize: AppConstants.pageSize,
    );

    if (items.length < AppConstants.pageSize) {
      _pagingController.appendLastPage(items);
    } else {
      _pagingController.appendPage(items, page + 1);
    }
  }

  Future<void> fetch(int page) async {
    state = const TodoListStateLoading();

    // TODO: fetch data

    state = TodoListStateSuccess(pagingController: _pagingController);
  }

  void refresh() {
    _pagingController.refresh();
  }

  void deleteNote(int noteId) async {
    // await _repository.deleteNote(noteId);
    _pagingController.refresh();
  }
}
