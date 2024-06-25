import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/repositories/book/book_repository.dart';
import 'package:example/app/services/book/models/book_model.dart';

class LoadBookBloc extends BloweLoadBloc<BookModel, BloweNoParams> {
  LoadBookBloc(this._bookRepository);

  final BookRepository _bookRepository;

  @override
  Future<BookModel> load(BloweNoParams params) =>
      _bookRepository.loadRandomBook();
}
