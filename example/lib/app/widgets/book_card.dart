import 'package:example/app/extensions/genre.dart';
import 'package:example/app/services/book/models/book_model.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
    this.onTap,
  });

  final BookModel book;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: ListTile(
          title: Text(book.title),
          subtitle: Text(book.author),
          leading: Icon(book.genre.icon),
          trailing: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: book.available ? Colors.green : Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
