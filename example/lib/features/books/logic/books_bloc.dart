import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/repositories/book/book_repository.dart';
import 'package:example/app/services/book/models/books_pagination_model.dart';

class BooksBloc
    extends BlowePaginationBloc<BooksPaginationModel, BloweNoParams> {
  BooksBloc(this._bookRepository);

  final BookRepository _bookRepository;

  @override
  Future<BooksPaginationModel> load(BloweNoParams params, int page) =>
      _bookRepository.loadBooks(page);
}
