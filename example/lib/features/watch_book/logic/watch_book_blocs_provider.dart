import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/repositories/book/book_repository.dart';
import 'package:example/features/watch_book/logic/watch_book_bloc.dart';
import 'package:flutter/material.dart';

class WatchBookBlocsProvider extends StatelessWidget {
  const WatchBookBlocsProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WatchBookBloc(
        context.read<BookRepository>(),
      )..add(const BloweFetch(BloweNoParams())),
      child: child,
    );
  }
}
