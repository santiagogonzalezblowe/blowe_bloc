import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/enums/genre.dart';

class BookModel extends BloweSerializableItem {
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

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      title: json['title'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      genre: Genre.values[json['genre'] as int],
      available: json['available'] as bool,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'description': description,
      'genre': genre.index,
      'available': available,
    };
  }

  @override
  List<Object?> get props => [title, author, description, genre, available];
}
