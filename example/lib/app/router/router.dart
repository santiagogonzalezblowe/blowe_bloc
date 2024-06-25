import 'package:example/app/widgets/shell_home_scaffold.dart';
import 'package:example/features/books/ui/page/books_page.dart';
import 'package:example/features/load_book/ui/page/load_book_page.dart';
import 'package:example/features/login/ui/page/login_page.dart';
import 'package:example/features/watch_book/ui/page/watch_book_page.dart';
import 'package:go_router/go_router.dart';

GoRouter get goRouter {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: LoginPage.routePath,
        name: LoginPage.routeName,
        builder: (context, state) => const LoginPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => ShellHomeScaffold(
          navigationShell: navigationShell,
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: LoadBookPage.routePath,
                name: LoadBookPage.routeName,
                builder: (context, state) => const LoadBookPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: BooksPage.routePath,
                name: BooksPage.routeName,
                builder: (context, state) => const BooksPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: WatchBookPage.routePath,
                name: WatchBookPage.routeName,
                builder: (context, state) => const WatchBookPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
