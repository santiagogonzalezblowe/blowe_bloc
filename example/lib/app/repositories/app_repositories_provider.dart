import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/repositories/book/book_repository.dart';
import 'package:example/app/services/book/book_service.dart';
import 'package:flutter/material.dart';

class AppRepositoriesProvider extends StatelessWidget {
  const AppRepositoriesProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => BookRepository(
            context.read<BookService>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
