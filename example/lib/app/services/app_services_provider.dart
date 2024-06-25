import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/services/book/book_service.dart';
import 'package:flutter/material.dart';

class AppServicesProvider extends StatelessWidget {
  const AppServicesProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => const BookService(),
        ),
      ],
      child: child,
    );
  }
}
