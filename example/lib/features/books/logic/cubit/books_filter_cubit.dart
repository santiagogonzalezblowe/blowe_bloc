import 'package:blowe_bloc/blowe_bloc.dart';

class BooksFilterCubit extends Cubit<bool> {
  BooksFilterCubit() : super(true);

  void toggle() => emit(!state);
}
