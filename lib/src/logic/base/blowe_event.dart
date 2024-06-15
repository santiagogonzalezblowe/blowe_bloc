import 'package:equatable/equatable.dart';

/// Base event class for BloweBloc.
abstract class BloweEvent extends Equatable {
  /// Creates an instance of BloweEvent.
  const BloweEvent();

  @override
  List<Object?> get props => [];
}

/// Event used to initiate data fetching. Contains a parameter of type P.
class BloweFetch<P> extends BloweEvent {
  /// Creates an instance of BloweFetch with the given parameters.
  ///
  /// - [params]: The parameters for the fetch event.
  const BloweFetch(this.params);

  /// The parameters for the fetch event.
  final P params;

  @override
  List<Object?> get props => [params];
}

/// Event used to fetch more data, typically used in pagination.
/// Contains a parameter of type P.
class BloweFetchMore<P> extends BloweEvent {
  /// Creates an instance of BloweFetchMore with the given parameters.
  ///
  /// - [params]: The parameters for the fetch more event.
  const BloweFetchMore(this.params);

  /// The parameters for the fetch more event.
  final P params;

  @override
  List<Object?> get props => [params];
}

/// Event used to update the current data. Contains data of type T.
class BloweUpdateData<T> extends BloweEvent {
  /// Creates an instance of BloweUpdateData with the given data.
  ///
  /// - [data]: The data to update.
  const BloweUpdateData(this.data);

  /// The data to update.
  final T data;

  @override
  List<Object?> get props => [data];
}

/// Event used to reset the Bloc to its initial state.
class BloweReset extends BloweEvent {}
