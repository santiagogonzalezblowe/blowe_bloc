import 'package:example/app/services/book/book_service.dart';
import 'package:example/app/services/book/models/book_model.dart';
import 'package:example/app/services/book/models/books_pagination_model.dart';

class BookRepository {
  BookRepository(this.bookService);

  final BookService bookService;

  BooksPaginationModel? _books;

  Future<BookModel> loadRandomBook() => bookService.loadRandomBook();

  Stream<BookModel> watchRandomBook() => bookService.watchRandomBook();

  Future<BooksPaginationModel> loadBooks(int page) async {
    final books = await bookService.loadBooks(page);

    if (page != 0) {
      final items = _books?.items ?? [];

      books.items.insertAll(0, items);
    }

    _books = books;

    return books;
  }
}
