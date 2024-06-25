import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/repositories/book/book_repository.dart';
import 'package:example/app/services/book/models/book_model.dart';

class WatchBookBloc extends BloweWatchBloc<BookModel, BloweNoParams> {
  WatchBookBloc(this._bookRepository);

  final BookRepository _bookRepository;

  @override
  Stream<BookModel> watch(BloweNoParams params) =>
      _bookRepository.watchRandomBook();
}
