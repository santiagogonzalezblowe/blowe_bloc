import 'package:example/app/enums/genre.dart';

class BookModel {
  BookModel({
    required this.title,
    required this.author,
    required this.description,
    required this.genre,
    required this.available,
  });

  final String title;
  final String author;
  final String description;
  final Genre genre;
  final bool available;
}
