import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vox_todo/app/di/injector.dart';
import 'package:vox_todo/app/domain/entity/todo.dart';
import 'package:vox_todo/app/domain/repository/todo_repository.dart';
import 'package:vox_todo/app/features/todo/add/domain/state.dart';
import 'package:vox_todo/generated/locale_keys.g.dart';

final class AddScreenNotifier extends StateNotifier<AddTodoScreenState> {
  AddScreenNotifier() : super(const AddTodoScreenStateInitial(null));
  final TodoRepository _repository = Injector.resolve<TodoRepository>();

  Todo? todo;

  Future<void> init(int? id) async {
    if (id != null) {
      todo = await _repository.get(id);
    }

    state = AddTodoScreenStateInitial(todo);
  }

  void onTitleChanged(String value) {
    if (todo == null) {
      final now = DateTime.now();
      todo = Todo(
        id: null,
        title: value,
        description: '',
        createdAt: now,
        updatedAt: now,
      );
    } else {
      todo = todo!.copyWith(title: value);
    }
  }

  void onDescriptionChanged(String value) {
    if (todo == null) {
      final now = DateTime.now();
      todo = Todo(
        id: null,
        title: '',
        description: value,
        createdAt: now,
        updatedAt: now,
      );
    } else {
      todo = todo!.copyWith(description: value);
    }
  }

  void onSubmit() {
    if (todo != null && todo!.isValid()) {
      // if note have id, then we update existing note and should set updatedAt
      if (todo!.id != null) {
        todo = todo!.copyWith(updatedAt: DateTime.now());
      }

      _repository.save(todo!);
      state = const AddTodoScreenStateSuccess();
    } else {
      state = AddTodoScreenStateError(LocaleKeys.titleCantBeEmpty.tr());
    }
  }
}
