import 'dart:async';

import 'package:blowe_bloc/blowe_bloc.dart';

/// BloweWatchBloc extends BloweBloc and provides a structure for watching data
/// changes using a provided watch method.
abstract class BloweWatchBloc<T, P> extends BloweBloc<T, P> {
  /// Creates an instance of BloweWatchBloc.
  ///
  /// - [initialData]: Optional initial data to set the state to BloweCompleted.
  BloweWatchBloc([super.initialData]);

  StreamSubscription<T>? _streamSubscription;

  /// Method to watch data changes using the provided parameters.
  ///
  /// - [params]: The parameters for watching data changes.
  Stream<T> watch(P params);

  @override
  Future<void> onFetch(
    BloweFetch<P> event,
    Emitter<BloweState<T>> emit,
  ) async {
    emit(BloweInProgress<T>());

    await _streamSubscription?.cancel();

    final completer = Completer<void>();

    _streamSubscription = watch(event.params).listen(
      (data) {
        if (!emit.isDone) {
          add(BloweUpdateData(data));
        }
      },
      onError: (dynamic e) {
        if (!emit.isDone) {
          emit(
            BloweError(
              e is Exception ? e : Exception('An error occurred'),
            ),
          );
        }
      },
      onDone: () {
        if (!completer.isCompleted) {
          completer.complete();
        }
      },
    );

    return completer.future;
  }

  @override
  void onReset(BloweReset event, Emitter<BloweState<T>> emit) {
    emit(BloweInitial<T>());
    _streamSubscription?.cancel();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
