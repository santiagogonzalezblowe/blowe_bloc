import 'package:equatable/equatable.dart';

/// Base state class for BloweBloc.
///
/// [BloweState] serves as the base class for various states in the BloweBloc.
/// It extends [Equatable] to enable value comparisons, making it easier to
/// handle state changes in the bloc.
abstract class BloweState<T> extends Equatable {
  /// Creates an instance of BloweState.
  ///
  /// [history] represents the search history and is optional. If not provided,
  /// it defaults to null.
  const BloweState({
    this.history,
  });

  /// The search history.
  final T? history;

  @override
  List<Object?> get props => [history];
}

/// Initial state of the Bloc.
///
/// This state indicates that the bloc has been initialized but no operations
/// have been performed yet.
class BloweInitial<T> extends BloweState<T> {
  /// Creates an instance of BloweInitial.
  ///
  /// [history] represents the search history and is optional. If not provided,
  /// it defaults to null.
  const BloweInitial({super.history});
}

/// State indicating that an operation is in progress.
///
/// This state is used to indicate that a fetch or any other asynchronous
/// operation is currently ongoing.
class BloweInProgress<T> extends BloweState<T> {
  /// Creates an instance of BloweInProgress.
  ///
  /// [history] represents the search history and is optional. If not provided,
  /// it defaults to null.
  const BloweInProgress({super.history});
}

/// State indicating that an operation has completed successfully.
///
/// This state contains the result of the completed operation, represented by
/// [data]. It also indicates whether more data is being loaded through
/// [isLoadingMore].
class BloweCompleted<T> extends BloweState<T> {
  /// Creates an instance of BloweCompleted with the given data.
  ///
  /// - [data]: The data of the completed state.
  /// - [isLoadingMore]: Indicates if more data is being loaded
  /// (default is false).
  /// - [history]: Represents the search history and is optional.
  /// If not provided, it defaults to null.
  const BloweCompleted(
    this.data, {
    super.history,
    this.isLoadingMore = false,
  });

  /// The data of the completed state.
  final T data;

  /// Indicates if more data is being loaded.
  final bool isLoadingMore;

  @override
  List<Object?> get props => [data, isLoadingMore, history];
}

/// State indicating that an error has occurred.
///
/// This state contains the exception that caused the error.
class BloweError<T> extends BloweState<T> {
  /// Creates an instance of BloweError with the given exception.
  ///
  /// - [error]: The exception that caused the error state.
  /// - [history]: Represents the search history and is optional.
  /// If not provided, it defaults to null.
  const BloweError(this.error, {super.history});

  /// The exception that caused the error state.
  final Exception error;

  @override
  List<Object?> get props => [error, history];
}
