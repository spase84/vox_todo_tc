import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vox_todo/app/domain/entity/todo.dart';
import 'package:vox_todo/app/settings/colors.dart';
import 'package:vox_todo/generated/locale_keys.g.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {required this.todo,
      required this.onTap,
      required this.onDelete,
      super.key});

  final Todo todo;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  static const _extentRatio = 0.24;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Slidable(
            key: ValueKey(todo.id),
            endActionPane: ActionPane(
              extentRatio: _extentRatio,
              motion: const ScrollMotion(),
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Slidable.of(context)?.close();
                      onDelete();
                    },
                    child: ColoredBox(
                      color: Colors.red.withValues(alpha: .4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.delete,
                              color: AppColors.textPrimary),
                          Text(
                            LocaleKeys.delete.tr(),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            child: ColoredBox(
              color: AppColors.backgroundGrey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todo.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppColors.primary,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          if (todo.description.isNotEmpty)
                            Text(
                              todo.description,
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          const SizedBox(width: 16),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(LocaleKeys.createdAt.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                )),
                        Text(
                          DateFormat.MMMMd(context.locale.languageCode)
                              .format(todo.createdAt),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Text(
                          DateFormat.Hms(context.locale.languageCode)
                              .format(todo.createdAt),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        if (todo.updatedAt != todo.createdAt) ...[
                          const SizedBox(
                            height: 16,
                          ),
                          Text(LocaleKeys.updatedAt.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: AppColors.textPrimary,
                                  )),
                          Text(
                            DateFormat.MMMMd(context.locale.languageCode)
                                .format(todo.updatedAt),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            DateFormat.Hms(context.locale.languageCode)
                                .format(todo.updatedAt),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
