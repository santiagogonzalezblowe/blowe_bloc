import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/repositories/book/book_repository.dart';
import 'package:example/features/books/logic/books_bloc.dart';
import 'package:example/features/books/logic/cubit/books_filter_cubit.dart';
import 'package:flutter/material.dart';

class BooksBlocsProvider extends StatelessWidget {
  const BooksBlocsProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BooksBloc(
            context.read<BookRepository>(),
          )..add(const BloweFetch(BloweNoParams())),
        ),
        BlocProvider(
          create: (context) => BooksFilterCubit(),
        ),
      ],
      child: child,
    );
  }
}
