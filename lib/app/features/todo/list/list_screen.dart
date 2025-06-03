import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart'
    show PagedChildBuilderDelegate, PagedSliverList;
import 'package:vox_todo/app/domain/entity/todo.dart';
import 'package:vox_todo/app/features/todo/list/domain/list_provider.dart'
    show ListScreenNotifier;
import 'package:vox_todo/app/features/todo/list/domain/state.dart';
import 'package:vox_todo/app/features/todo/list/widgets/list_item.dart';
import 'package:vox_todo/app/settings/colors.dart' show AppColors;
import 'package:vox_todo/app/settings/routes.dart' show Routes;
import 'package:vox_todo/generated/locale_keys.g.dart' show LocaleKeys;

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late final StateNotifierProvider<ListScreenNotifier, TodoListState> _provider;

  @override
  void initState() {
    super.initState();
    _provider = StateNotifierProvider<ListScreenNotifier, TodoListState>((_) {
      return ListScreenNotifier()..init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.listScreenTitle).tr(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Builder(builder: (context) {
              return Consumer(
                builder: (context, ref, _) => IconButton(
                  icon: const Icon(Icons.add, color: AppColors.secondary),
                  onPressed: () async {
                    await context.pushNamed(Routes.add);
                    if (!context.mounted) {
                      return;
                    }
                    ref.read(_provider.notifier).refresh();
                  },
                ),
              );
            }),
          ),
        ],
      ),
      body: _ListScreenBody(provider: _provider),
    );
  }
}

class _ListScreenBody extends ConsumerWidget {
  const _ListScreenBody({required this.provider});

  final StateNotifierProvider<ListScreenNotifier, TodoListState> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(provider, (_, state) {
      if (state is TodoListStateError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }
    });

    final state = ref.watch(provider);

    return switch (state) {
      TodoListStateLoading() =>
        const Center(child: CircularProgressIndicator()),
      TodoListStateError(message: final message) =>
        Center(child: Text(message)),
      TodoListStateSuccess(pagingController: final pagingController) =>
        RefreshIndicator(
          onRefresh: () async => ref.read(provider.notifier).refresh(),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: PagedSliverList.separated(
                  pagingController: pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Todo>(
                    firstPageProgressIndicatorBuilder: (_) => const Center(
                      child: CircularProgressIndicator(
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    noItemsFoundIndicatorBuilder: (context) => SizedBox.expand(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(LocaleKeys.emptyListText,
                                  style: Theme.of(context).textTheme.titleLarge)
                              .tr(),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              LocaleKeys.emptyListDescription,
                              style: Theme.of(context).textTheme.labelSmall,
                              textAlign: TextAlign.center,
                            ).tr(),
                          ),
                        ],
                      ),
                    ),
                    itemBuilder: (context, item, i) => ListItem(
                      todo: item,
                      onTap: () async {
                        await context.pushNamed(Routes.add, extra: item.id);
                        if (!context.mounted) {
                          return;
                        }
                        ref.read(provider.notifier).refresh();
                      },
                      onDelete: () {
                        ref.read(provider.notifier).delete(item.id!);
                      },
                    ),
                  ),
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                ),
              ),
            ],
          ),
        ),
    };
  }
}
