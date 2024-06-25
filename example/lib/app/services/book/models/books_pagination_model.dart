import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/services/book/models/book_model.dart';

class BooksPaginationModel extends BlowePaginationModel<BookModel> {
  BooksPaginationModel({required super.items, required super.totalCount});
}
