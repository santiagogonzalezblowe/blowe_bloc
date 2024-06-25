import 'package:example/features/books/logic/books_blocs_provider.dart';
import 'package:example/features/books/ui/widgets/books_filter.dart';
import 'package:example/features/books/ui/widgets/books_list_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  static String get routePath => '/books';
  static String get routeName => 'books';

  static void go(BuildContext context) => context.goNamed(routeName);

  @override
  Widget build(BuildContext context) {
    return const BooksBlocsProvider(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: BooksFilter(),
            ),
            Expanded(child: BooksListView()),
          ],
        ),
      ),
    );
  }
}
