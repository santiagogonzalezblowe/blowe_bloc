import 'package:example/app/extensions/stateful_navigation_shell.dart';
import 'package:example/features/login/ui/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellHomeScaffold extends StatelessWidget {
  const ShellHomeScaffold({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blowe Bloc Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => LoginPage.go(context),
          ),
        ],
      ),
      body: navigationShell,
      bottomNavigationBar: Builder(
        builder: (context) {
          return BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(navigationShell.loadBooksIcon),
                label: 'Load',
              ),
              BottomNavigationBarItem(
                icon: Icon(navigationShell.paginationBooksIcon),
                label: 'Pagination',
              ),
              BottomNavigationBarItem(
                icon: Icon(navigationShell.watchBookIcon),
                label: 'Watch',
              ),
            ],
            currentIndex: currentIndex,
            onTap: navigationShell.goBranch,
          );
        },
      ),
    );
  }
}
