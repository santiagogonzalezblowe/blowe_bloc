import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/services/book/models/book_model.dart';
import 'package:example/features/books/logic/book_search_bloc.dart';
import 'package:flutter/material.dart';

class SearchBookButton extends StatelessWidget {
  const SearchBookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'searchBookButton',
      onPressed: () async {
        final result = await showSearch<BookModel?>(
          context: context,
          useRootNavigator: true,
          delegate:
              BloweSearchDelegate<BookSearchBloc, BookModel, BookSearchParams>(
            bloc: context.read<BookSearchBloc>(),
            itemBuilder: (context, item, close, save) {
              return ListTile(
                title: Text(item.title),
                onTap: () {
                  save(item);
                  close(context, item);
                },
              );
            },
            paramsProvider: (query) => BookSearchParams(query),
            // initialBuilder: (context, close) {
            //   return const Center(
            //     child: Text('Search for books'),
            //   );
            // },
            emptyBuilder: (context, query) {
              return Center(
                child: Text('No results found for "$query"'),
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
