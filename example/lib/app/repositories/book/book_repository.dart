import 'package:example/app/services/book/book_service.dart';
import 'package:example/app/services/book/models/book_model.dart';
import 'package:example/app/services/book/models/books_pagination_model.dart';

class BookRepository {
  BookRepository(this.bookService);

  final BookService bookService;

  Future<BookModel> loadRandomBook() => bookService.loadRandomBook();

  Stream<BookModel> watchRandomBook() => bookService.watchRandomBook();

  Future<BooksPaginationModel> loadBooks(int page) =>
      bookService.loadBooks(page);
}
