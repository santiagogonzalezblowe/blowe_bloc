import 'package:blowe_bloc/blowe_bloc.dart';

/// Event used to load the search history.
class BloweLoadSearchHistory extends BloweEvent {}

/// Event used to add an item to the search history.
class BloweAddSearchHistory<T> extends BloweEvent {
  /// Creates an instance of BloweAddSearchHistory with the given item.
  ///
  /// - [item]: The item to add to the search history.
  const BloweAddSearchHistory(this.item);

  /// The item to add to the search history.
  final T item;

  @override
  List<Object?> get props => [item];
}

/// Event used to remove an item from the search history.
class BloweRemoveSearchHistory<T> extends BloweEvent {
  /// Creates an instance of BloweRemoveSearchHistory with the given item.
  ///
  /// - [item]: The item to remove from the search history.
  const BloweRemoveSearchHistory(this.item);

  /// The item to remove from the search history.
  final T item;

  @override
  List<Object?> get props => [item];
}

/// Event used to clear the search history.
class BloweClearSearchHistory extends BloweEvent {}
