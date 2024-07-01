import 'package:flutter/material.dart';

class SearchBookButton extends StatelessWidget {
  const SearchBookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        // final result = await showSearch<BookModel?>(
        //   context: context,
        //   useRootNavigator: true,

        //   ),
        // );

        // if (context.mounted) {
        //   if (result != null) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(
        //         content: Text('Selected book: ${result.title}'),
        //       ),
        //     );
        //   } else {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(
        //         content: Text('No book selected'),
        //       ),
        //     );
        //   }
        // }
      },
      child: const Icon(Icons.search),
    );
  }
}
