import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vox_todo/app/features/todo/add/domain/add_provider.dart';
import 'package:vox_todo/app/features/todo/add/domain/state.dart';
import 'package:vox_todo/app/features/todo/add/widgets/todo_title_input.dart';
import 'package:vox_todo/app/features/widgets/unfocuser.dart';
import 'package:vox_todo/app/settings/colors.dart';
import 'package:vox_todo/generated/locale_keys.g.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({this.id, super.key});

  final int? id;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  late final StateNotifierProvider<AddScreenNotifier, AddTodoScreenState>
      _provider;

  @override
  void initState() {
    super.initState();
    _provider =
        StateNotifierProvider<AddScreenNotifier, AddTodoScreenState>((_) {
      return AddScreenNotifier()..init(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id != null
                ? LocaleKeys.editTodoTitle
                : LocaleKeys.addTodoTitle)
            .tr(),
        actions: [
          Consumer(builder: (context, ref, _) {
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: const Icon(Icons.done, color: AppColors.secondary),
                onPressed: ref.read(_provider.notifier).onSubmit,
              ),
            );
          }),
        ],
      ),
      body: _AddScreenBody(_provider),
    );
  }
}

class _AddScreenBody extends ConsumerWidget {
  const _AddScreenBody(this.provider);

  final StateNotifierProvider<AddScreenNotifier, AddTodoScreenState> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(provider, (_, state) {
      if (state is AddTodoScreenStateError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }

      if (state is AddTodoScreenStateSuccess) {
        context.pop();
      }
    });

    final state = ref.watch(provider);

    return switch (state) {
      AddTodoScreenStateInitial(todo: final todo) => Unfocuser(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 32),
              child: Column(
                children: [
                  TodoInput(
                    key: GlobalKey(),
                    title: LocaleKeys.todoNameTitle.tr(),
                    initialValue: todo?.title,
                    onChanged: ref.read(provider.notifier).onTitleChanged,
                  ),
                  const SizedBox(height: 24),
                  TodoInput(
                    key: GlobalKey(),
                    title: LocaleKeys.todoContextTitle.tr(),
                    initialValue: todo?.description,
                    onChanged: ref.read(provider.notifier).onDescriptionChanged,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: FilledButton(
                      onPressed: ref.read(provider.notifier).onSubmit,
                      child: Text(
                        todo != null ? LocaleKeys.update : LocaleKeys.save,
                      ).tr(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      AddTodoScreenStateError(message: final _) => const SizedBox.shrink(),
      AddTodoScreenStateSuccess() => const SizedBox.shrink(),
    };
  }
}
