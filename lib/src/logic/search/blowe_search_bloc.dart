import 'dart:convert';
import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// BloweSearchBloc extends BlowePaginationBloc and provides a structure
/// for handling paginated data along with managing a search history.
///
/// This bloc supports loading, adding, removing, and clearing search history,
/// which is persisted using SharedPreferences.
abstract class BloweSearchBloc<T extends BloweSerializableItem,
        P extends BloweSearchParams>
    extends BlowePaginationBloc<BlowePaginationModel<T>, P> {
  /// Creates an instance of BloweSearchBloc.
  ///
  /// [initialData] can be optionally provided to set the initial state to
  /// BloweCompleted with the given data.
  BloweSearchBloc([super.initialData]) {
    on<BloweAddSearchHistory<T>>(_onAddSearchHistory);
    on<BloweRemoveSearchHistory<T>>(_onRemoveSearchHistory);
    on<BloweClearSearchHistory>(_onClearSearchHistory);
    on<BloweLoadSearchHistory>(_onLoadSearchHistory);

    // Load history initially
    add(BloweLoadSearchHistory());
  }

  /// List to hold the search history items.
  List<T> _historyItems = [];

  /// Loads the search history from SharedPreferences.
  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final key = _getHistoryKey;
    final historyJsonList = prefs.getStringList(key);

    if (historyJsonList != null) {
      _historyItems = historyJsonList.map((json) {
        final map = jsonDecode(json) as Map<String, dynamic>;
        return fromJson(map);
      }).toList();
    }
  }

  /// Saves the current search history to SharedPreferences.
  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final key = _getHistoryKey;
    final historyJsonList =
        _historyItems.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(key, historyJsonList);
  }

  /// Generates a unique key for storing the search history in
  /// SharedPreferences.
  String get _getHistoryKey => '${runtimeType}_search_history';

  /// Method to create an item from JSON.
  ///
  /// This method needs to be implemented by subclasses to handle the creation
  /// of T from a JSON map.
  T fromJson(Map<String, dynamic> json);

  /// Method to load data based on search parameters.
  ///
  /// This method needs to be implemented by subclasses to handle the loading
  /// of paginated data based on search parameters.
  @override
  Future<BlowePaginationModel<T>> load(P params, int page);

  /// Handles loading the search history.
  ///
  /// This method is called when the BloweLoadSearchHistory event is added.
  Future<void> _onLoadSearchHistory(
    BloweLoadSearchHistory event,
    Emitter<BloweState<BlowePaginationModel<T>>> emit,
  ) async {
    await _loadHistory();
    emit(_getUpdatedState(state));
  }

  /// Handles adding an item to the search history.
  ///
  /// This method is called when the BloweAddSearchHistory event is added.
  Future<void> _onAddSearchHistory(
    BloweAddSearchHistory<T> event,
    Emitter<BloweState<BlowePaginationModel<T>>> emit,
  ) async {
    _historyItems
      ..removeWhere((item) => item == event.item)
      ..add(event.item);
    await _saveHistory();
    emit(_getUpdatedState(state));
  }

  /// Handles removing an item from the search history.
  ///
  /// This method is called when the BloweRemoveSearchHistory event is added.
  Future<void> _onRemoveSearchHistory(
    BloweRemoveSearchHistory<T> event,
    Emitter<BloweState<BlowePaginationModel<T>>> emit,
  ) async {
    _historyItems.remove(event.item);
    await _saveHistory();
    emit(_getUpdatedState(state));
  }

  /// Handles clearing the search history.
  ///
  /// This method is called when the BloweClearSearchHistory event is added.
  Future<void> _onClearSearchHistory(
    BloweClearSearchHistory event,
    Emitter<BloweState<BlowePaginationModel<T>>> emit,
  ) async {
    _historyItems.clear();
    await _saveHistory();
    emit(_getUpdatedState(state));
  }

  /// Returns the updated state with the current history.
  ///
  /// This method updates the state to include the current search history,
  /// maintaining the same type of state as the current state.
  BloweState<BlowePaginationModel<T>> _getUpdatedState(
    BloweState<BlowePaginationModel<T>> currentState,
  ) {
    final historyPaginationModel = BlowePaginationModel<T>(
      items: _historyItems,
      totalCount: _historyItems.length,
    );

    if (currentState is BloweCompleted<BlowePaginationModel<T>>) {
      return BloweCompleted<BlowePaginationModel<T>>(
        currentState.data,
        history: historyPaginationModel,
        isLoadingMore: currentState.isLoadingMore,
      );
    }
    if (currentState is BloweInProgress<BlowePaginationModel<T>>) {
      return BloweInProgress<BlowePaginationModel<T>>(
        history: historyPaginationModel,
      );
    }
    if (currentState is BloweError<BlowePaginationModel<T>>) {
      return BloweError<BlowePaginationModel<T>>(
        currentState.error,
        history: historyPaginationModel,
      );
    }

    return BloweInitial<BlowePaginationModel<T>>(
      history: historyPaginationModel,
    );
  }

  /// Adds an item to the search history.
  ///
  /// - [item]: The item to be added to the search history.
  void addSearchHistory(T item) => add(BloweAddSearchHistory(item));

  /// Removes an item from the search history.
  ///
  /// - [item]: The item to be removed from the search history.
  void removeSearchHistory(T item) => add(BloweRemoveSearchHistory(item));

  /// Clears the entire search history.
  void clearSearchHistory() => add(BloweClearSearchHistory());

  /// Loads the search history.
  void loadSearchHistory() => add(BloweLoadSearchHistory());
}
