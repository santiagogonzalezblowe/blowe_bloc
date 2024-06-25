import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/repositories/book/book_repository.dart';
import 'package:example/features/load_book/logic/load_book_bloc.dart';
import 'package:flutter/material.dart';

class LoadBookBlocsProvider extends StatelessWidget {
  const LoadBookBlocsProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoadBookBloc(
        context.read<BookRepository>(),
      ),
      child: child,
    );
  }
}
