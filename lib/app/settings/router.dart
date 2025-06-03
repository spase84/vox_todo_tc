import 'package:go_router/go_router.dart' show GoRoute, GoRouter;
import 'package:vox_todo/app/features/todo/add/add_screen.dart';
import 'package:vox_todo/app/features/todo/list/list_screen.dart'
    show ListScreen;
import 'package:vox_todo/app/settings/routes.dart' show Routes;

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: Routes.list,
      path: '/',
      builder: (context, state) => const ListScreen(),
    ),
    GoRoute(
      name: Routes.add,
      path: '/add',
      builder: (context, state) => AddScreen(
        id: state.extra as int?,
      ),
    ),
  ],
);
