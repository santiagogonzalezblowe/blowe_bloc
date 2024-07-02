import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/enums/genre.dart';
import 'package:example/app/extensions/string.dart';
import 'package:example/app/services/book/models/book_model.dart';
import 'package:example/app/widgets/book_card.dart';
import 'package:example/features/books/logic/books_bloc.dart';
import 'package:example/features/books/logic/cubit/books_filter_cubit.dart';
import 'package:flutter/material.dart';

class BooksListView extends StatelessWidget {
  const BooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksFilterCubit, bool>(
      builder: (context, showAvailables) {
        return BlowePaginationListView<BooksBloc, BookModel, BloweNoParams,
            Genre>(
          itemBuilder: (context, item) => BookCard(book: item),
          filter: (item) => showAvailables ? item.available : !item.available,
          paramsProvider: () => const BloweNoParams(),
          emptyWidget: const Center(child: Text('No books found')),
          groupBy: (item) => item.genre,
          groupHeaderBuilder: (context, group, items) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                group.name.capitalize(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          },
        );
      },
    );
  }
}
