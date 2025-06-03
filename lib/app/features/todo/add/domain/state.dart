import 'package:vox_todo/app/domain/entity/todo.dart';

sealed class AddTodoScreenState {
  const AddTodoScreenState();
}

final class AddTodoScreenStateInitial extends AddTodoScreenState {
  const AddTodoScreenStateInitial(this.todo);

  final Todo? todo;
}

final class AddTodoScreenStateError extends AddTodoScreenState {
  const AddTodoScreenStateError(this.message);

  final String message;
}

final class AddTodoScreenStateSuccess extends AddTodoScreenState {
  const AddTodoScreenStateSuccess();
}
