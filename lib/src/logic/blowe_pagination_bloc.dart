import 'package:blowe_bloc/blowe_bloc.dart';

/// BlowePaginationBloc extends BloweBloc and provides a structure for handling
/// paginated data using a provided load method.
abstract class BlowePaginationBloc<T extends BlowePaginationModel<dynamic>, P>
    extends BloweBloc<T, P> {
  /// Creates an instance of BlowePaginationBloc.
  ///
  /// - [initialData]: Optional initial data to set the state to BloweCompleted.
  BlowePaginationBloc([super.initialData]);

  /// Method to load paginated data using the provided parameters
  /// and page number.
  ///
  /// - [params]: The parameters for loading data.
  /// - [page]: The page number for pagination.
  Future<T> load(P params, int page);

  int _page = 0;

  @override
  Future<void> onFetch(
    BloweFetch<P> event,
    Emitter<BloweState<T>> emit,
  ) async {
    _page = 0;

    emit(BloweInProgress<T>(history: state.history));

    try {
      final data = await load(event.params!, _page);
      add(BloweUpdateData(data));
    } catch (e) {
      emit(
        BloweError(
          e is Exception ? e : Exception('An error occurred'),
          history: state.history,
        ),
      );
    }
  }

  @override
  Future<void> onFetchMore(
    BloweFetchMore<P> event,
    Emitter<BloweState<T>> emit,
  ) async {
    final state = this.state;
    if (state is! BloweCompleted<T>) return;

    _page++;

    emit(
      BloweCompleted(
        state.data,
        isLoadingMore: true,
        history: state.history,
      ),
    );

    try {
      final data = await load(event.params!, _page);
      add(BloweUpdateData(data));
    } catch (e) {
      emit(
        BloweError(
          e is Exception ? e : Exception('An error occurred'),
          history: state.history,
        ),
      );
    }
  }
}
