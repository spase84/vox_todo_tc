import 'package:go_router/go_router.dart' show GoRoute, GoRouter;
import 'package:vox_todo/app/features/todo/list/list_screen.dart'
    show ListScreen;
import 'package:vox_todo/app/settings/routes.dart' show Routes;

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: Routes.list,
      path: '/',
      builder: (context, state) => ListScreen(),
    ),
    // GoRoute(
    //   name: Routes.add,
    //   path: '/add',
    //   builder: (context, state) => AddScreen(
    //     noteId: state.extra as int?,
    //   ),
    // ),
  ],
);
