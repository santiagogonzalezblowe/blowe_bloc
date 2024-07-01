import 'package:blowe_bloc/blowe_bloc.dart';

/// BloweLoadBloc extends BloweBloc and provides a structure for loading data
/// using a provided load method.
abstract class BloweLoadBloc<T, P> extends BloweBloc<T, P> {
  /// Creates an instance of BloweLoadBloc.
  ///
  /// - [initialData]: Optional initial data to set the state to BloweCompleted.
  BloweLoadBloc([super.initialData]);

  /// Method to load data using the provided parameters.
  ///
  /// - [params]: The parameters for loading data.
  Future<T> load(P params);

  @override
  Future<void> onFetch(
    BloweFetch<P> event,
    Emitter<BloweState<T>> emit,
  ) async {
    emit(BloweInProgress<T>());

    try {
      final data = await load(event.params!);
      add(BloweUpdateData(data));
    } catch (e) {
      emit(
        BloweError(
          e is Exception ? e : Exception('An error occurred'),
        ),
      );
    }
  }
}
