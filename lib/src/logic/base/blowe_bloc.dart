import 'package:blowe_bloc/blowe_bloc.dart';

/// BloweBloc is an abstract class that extends Bloc and serves as the base
/// for managing specific events and states in the blowe_bloc package.
/// It provides a structure for handling data fetching, updating, resetting,
/// and pagination.
abstract class BloweBloc<T, P> extends Bloc<BloweEvent, BloweState<T>> {
  /// Creates an instance of BloweBloc.
  ///
  /// If [initialData] is provided, the initial state will be
  /// BloweCompleted<T>(initialData). Otherwise, the initial state will be
  /// BloweInitial().
  ///
  /// - [initialData]: Optional initial data to set the state to BloweCompleted.
  BloweBloc([T? initialData])
      : super(
          initialData != null
              ? BloweCompleted<T>(initialData)
              : BloweInitial<T>(),
        ) {
    on<BloweFetch<P>>(_onFetch);
    on<BloweUpdateData<T>>(_onUpdateData);
    on<BloweReset>(onReset);
    on<BloweFetchMore<P>>(_onFetchMore);
  }

  /// Abstract method that must be implemented by derived classes to handle
  /// the BloweFetch event. This method is invoked when BloweFetch is called.
  ///
  /// - [event]: The event containing parameters for fetching data.
  /// - [emit]: The function to emit states.
  Future<void> onFetch(
    BloweFetch<P> event,
    Emitter<BloweState<T>> emit,
  );

  Future<void> _onFetch(
    BloweFetch<P> event,
    Emitter<BloweState<T>> emit,
  ) {
    if (event.params == null && P != BloweNoParams) {
      throw Exception('Params cannot be null');
    }

    return onFetch(event, emit);
  }

  /// Abstract method that must be implemented by derived classes to handle
  /// the BloweFetchMore event. This method is invoked when BloweFetchMore
  /// is called.
  ///
  /// - [event]: The event containing parameters for fetching more data.
  /// - [emit]: The function to emit states.
  Future<void> onFetchMore(
    BloweFetchMore<P> event,
    Emitter<BloweState<T>> emit,
  ) =>
      throw UnimplementedError();

  Future<void> _onFetchMore(
    BloweFetchMore<P> event,
    Emitter<BloweState<T>> emit,
  ) {
    if (event.params == null && P != BloweNoParams) {
      throw Exception('Params cannot be null');
    }

    return onFetchMore(event, emit);
  }

  void _onUpdateData(
    BloweUpdateData<T> event,
    Emitter<BloweState<T>> emit,
  ) =>
      emit(BloweCompleted<T>(event.data, history: state.history));

  /// Emits the BloweInitial state to reset the Bloc to its initial state.
  /// This method is invoked when BloweReset is called.
  ///
  /// - [event]: The event triggering the reset.
  /// - [emit]: The function to emit states.
  void onReset(
    BloweReset event,
    Emitter<BloweState<T>> emit,
  ) =>
      emit(BloweInitial<T>(history: state.history));
}
