import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/services/book/models/book_model.dart';
import 'package:example/app/widgets/book_card.dart';
import 'package:example/features/load_book/logic/load_book_bloc.dart';
import 'package:example/features/load_book/logic/load_book_blocs_provider.dart';
import 'package:example/features/load_book/ui/widgets/load_book_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoadBookPage extends StatelessWidget {
  const LoadBookPage({super.key});

  static String get routePath => '/load-book';
  static String get routeName => 'loadBook';

  static void go(BuildContext context) => context.goNamed(routeName);

  @override
  Widget build(BuildContext context) {
    return LoadBookBlocsProvider(
      child: Scaffold(
        floatingActionButton: const LoadBookButton(),
        body: BlocBuilder<LoadBookBloc, BloweState>(
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
            return const Center(
              child: Text('Press the button to load a book'),
            );
          },
        ),
      ),
    );
  }
}
