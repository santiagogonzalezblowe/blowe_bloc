import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/enums/genre.dart';
import 'package:example/app/services/book/models/book_model.dart';
import 'package:example/app/widgets/blowe_search_delegate.dart';
import 'package:example/app/widgets/book_card.dart';
import 'package:example/features/books/logic/books_bloc.dart';
import 'package:flutter/material.dart';

class SearchBookButton extends StatelessWidget {
  const SearchBookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final result = await showSearch<BookModel?>(
          context: context,
          useRootNavigator: true,
          delegate: BloweSearchDelegate<BooksBloc, BookModel, BloweNoParams>(
            searchFieldLabel: 'Search books',
            paramsProvider: () => const BloweNoParams(),
            itemBuilder: (context, item, close) => BookCard(
              book: item,
              onTap: () => close(context, item),
            ),
            emptyBuilder: (context, query) {
              return Center(
                child: Text(
                  'No books found for query: $query',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              );
            },
            bloc: context.read<BooksBloc>(),
            initialBuilder: (context, close) {
              final books = [
                BookModel(
                  title: 'The Hobbit',
                  author: 'J.R.R. Tolkien',
                  available: true,
                  genre: Genre.fantasy,
                  description:
                      'The Hobbit is set within Tolkien\'s fictional universe and follows the quest of home-loving Bilbo Baggins, the titular hobbit, to win a share of the treasure guarded by Smaug the dragon.',
                ),
                BookModel(
                  title: 'The Lord of the Rings',
                  author: 'J.R.R. Tolkien',
                  available: false,
                  genre: Genre.fantasy,
                  description:
                      'The Lord of the Rings is an epic high-fantasy novel by the English author and scholar J. R. R. Tolkien. Set in Middle-earth, the world at some distant time in the past, the story began as a sequel to Tolkien\'s 1937 children\'s book The Hobbit, but eventually developed into a much larger work.',
                ),
                BookModel(
                  title: 'The Silmarillion',
                  author: 'J.R.R. Tolkien',
                  available: true,
                  genre: Genre.fantasy,
                  description:
                      'The Silmarillion is a collection of mythopoeic works by English writer J. R. R. Tolkien, edited and published posthumously by his son, Christopher Tolkien, in 1977, with assistance from Guy Gavriel Kay.',
                ),
              ];
              return ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return BookCard(
                    book: books[index],
                    onTap: () => close(context, books[index]),
                  );
                },
              );
            },
          ),
        );

        if (context.mounted) {
          if (result != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Selected book: ${result.title}'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No book selected'),
              ),
            );
          }
        }
      },
      child: const Icon(Icons.search),
    );
  }
}
