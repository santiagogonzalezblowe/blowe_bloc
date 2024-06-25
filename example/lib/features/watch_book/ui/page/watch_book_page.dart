import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/services/book/models/book_model.dart';
import 'package:example/app/widgets/book_card.dart';
import 'package:example/features/watch_book/logic/watch_book_bloc.dart';
import 'package:example/features/watch_book/logic/watch_book_blocs_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WatchBookPage extends StatelessWidget {
  const WatchBookPage({super.key});

  static String get routePath => '/watch-book';
  static String get routeName => 'watchBook';

  static void go(BuildContext context) => context.goNamed(routeName);

  @override
  Widget build(BuildContext context) {
    return WatchBookBlocsProvider(
      child: Scaffold(
        body: BlocBuilder<WatchBookBloc, BloweState>(
          builder: (context, state) {
            if (state is BloweInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is BloweError) {
              return Center(
                child: Text(state.error.toString()),
              );
            }
            if (state is BloweCompleted<BookModel>) {
              return BookCard(book: state.data);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
