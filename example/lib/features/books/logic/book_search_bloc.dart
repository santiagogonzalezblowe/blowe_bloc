import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/repositories/book/book_repository.dart';
import 'package:example/app/services/book/models/book_model.dart';

class BookSearchBloc extends BloweSearchBloc<BookModel, BookSearchParams> {
  final BookRepository bookRepository;

  BookSearchBloc(this.bookRepository) : super();

  @override
  Future<BlowePaginationModel<BookModel>> load(
    BookSearchParams params,
    int page,
  ) =>
      bookRepository.loadBooksByQuery(page, params.query);

  @override
  BookModel fromJson(Map<String, dynamic> json) => BookModel.fromJson(json);
}

class BookSearchParams extends BloweSearchParams {
  const BookSearchParams(super.query);
}
