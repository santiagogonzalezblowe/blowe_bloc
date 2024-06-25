import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension StatefulNavigationShellExtension on StatefulNavigationShell {
  IconData get loadBooksIcon =>
      currentIndex == 0 ? Icons.book : Icons.book_outlined;
  IconData get paginationBooksIcon =>
      currentIndex == 1 ? Icons.pages : Icons.pages_outlined;
  IconData get watchBookIcon => currentIndex == 2
      ? Icons.local_attraction
      : Icons.local_attraction_outlined;
}
