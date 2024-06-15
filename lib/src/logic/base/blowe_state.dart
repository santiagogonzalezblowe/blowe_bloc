import 'package:equatable/equatable.dart';

/// Base state class for BloweBloc.
abstract class BloweState extends Equatable {
  /// Creates an instance of BloweBlocState.
  const BloweState();

  @override
  List<Object?> get props => [];
}

/// Initial state of the Bloc.
class BloweInitial extends BloweState {}

/// State indicating that an operation is in progress.
class BloweInProgress extends BloweState {}

/// State indicating that an operation has completed successfully and contains
/// data of type T. Can include an isLoadingMore flag for pagination operations.
class BloweCompleted<T> extends BloweState {
  /// Creates an instance of BloweCompleted with the given data.
  ///
  /// - [data]: The data of the completed state.
  /// - [isLoadingMore]: Indicates if more data is being loaded
  /// (default is false).
  const BloweCompleted(this.data, {this.isLoadingMore = false});

  /// The data of the completed state.
  final T data;

  /// Indicates if more data is being loaded.
  final bool isLoadingMore;

  @override
  List<Object?> get props => [data, isLoadingMore];
}

/// State indicating that an error has occurred and contains the exception.
class BloweError extends BloweState {
  /// Creates an instance of BloweError with the given exception.
  ///
  /// - [error]: The exception that caused the error state.
  const BloweError(this.error);

  /// The exception that caused the error state.
  final Exception error;

  @override
  List<Object> get props => [error];
}
