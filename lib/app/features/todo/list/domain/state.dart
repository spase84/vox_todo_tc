import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart'
    show PagingController;
import 'package:vox_todo/app/domain/entity/todo.dart' show Todo;

sealed class TodoListState {
  const TodoListState();
}

class TodoListStateLoading extends TodoListState {
  const TodoListStateLoading();
}

class TodoListStateError extends TodoListState {
  const TodoListStateError({required this.message});
  final String message;
}

class TodoListStateSuccess extends TodoListState {
  const TodoListStateSuccess({required this.pagingController});
  final PagingController<int, Todo> pagingController;
}
