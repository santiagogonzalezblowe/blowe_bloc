import 'dart:async';
import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:flutter/material.dart';

/// A typedef for the initial builder function used in BloweSearchDelegate.
///
/// - [context]: The BuildContext of the widget.
/// - [close]: A function to close the search delegate with a result.
typedef BloweSearchInitialBuilder<T> = Widget Function(
  BuildContext context,
  void Function(BuildContext context, T? result) close,
);

/// A typedef for the item builder function used in BloweSearchDelegate.
///
/// - [context]: The BuildContext of the widget.
/// - [item]: The item to build a widget for.
/// - [close]: A function to close the search delegate with a result.
/// - [save]: A function to save the selected item to the search history.
typedef BloweSearchItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  void Function(BuildContext context, T? result) close,
  void Function(T item) save,
);

/// A typedef for the empty widget builder function used in BloweSearchDelegate.
///
/// - [context]: The BuildContext of the widget.
/// - [query]: The search query.
typedef BloweSearchEmptyWidgetBuilder = Widget Function(
  BuildContext context,
  String query,
);

/// A typedef for the params provider function used in BloweSearchDelegate.
///
/// - [query]: The search query.
typedef BloweSearchParamsProvider<P> = P Function(String query);

/// A delegate for searching with automatic history management and
/// debounce support.
///
/// This delegate uses a BloweSearchBloc to handle the search state and history.
/// It provides suggestions based on the search query and shows search results
/// when the user submits a query.
class BloweSearchDelegate<
    B extends BloweSearchBloc<T, P>,
    T extends BloweSerializableItem,
    P extends BloweSearchParams> extends SearchDelegate<T?> {
  /// Creates an instance of BloweSearchDelegate.
  ///
  /// - [bloc]: The search bloc to use for managing search state and history.
  /// - [itemBuilder]: The builder function to create list items.
  /// - [paramsProvider]: A function that provides parameters for the BloweFetch
  /// event.
  /// - [searchFieldLabel]: The label for the search field (optional).
  /// - [keyboardType]: The type of keyboard to use for the search field
  /// (optional).
  /// - [initialBuilder]: A builder function for the initial state when the
  /// search query is empty (optional).
  /// - [emptyBuilder]: A builder function for the empty state when no results
  /// are found (optional).
  BloweSearchDelegate({
    required this.bloc,
    required this.itemBuilder,
    required this.paramsProvider,
    super.searchFieldLabel,
    super.keyboardType,
    this.initialBuilder,
    this.emptyBuilder,
  }) : _debouncer = _Debouncer(milliseconds: 300);

  /// The search bloc to use for managing search state and history.
  final B bloc;

  /// A builder function for the initial state when the search query is empty.
  final BloweSearchInitialBuilder<T>? initialBuilder;

  /// A builder function to create list items.
  final BloweSearchItemBuilder<T> itemBuilder;

  /// A builder function for the empty state when no results are found.
  final BloweSearchEmptyWidgetBuilder? emptyBuilder;

  /// A debouncer to prevent excessive search requests.
  final _Debouncer _debouncer;

  /// A function that provides parameters for the BloweFetch event.
  final BloweSearchParamsProvider<P> paramsProvider;

  @override
  List<Widget> buildActions(BuildContext context) {
    if (query.isEmpty) return [];

    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
          bloc.reset();
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _debouncer.run(() {
      if (query.isNotEmpty) {
        bloc.fetch(paramsProvider(query));
      } else {
        bloc.reset();
      }
    });
    return _getBody(context, bloc, initialBuilder);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _debouncer.run(() {
      if (query.isNotEmpty) {
        bloc.fetch(paramsProvider(query));
      } else {
        bloc.reset();
      }
    });
    return _getBody(context, bloc, initialBuilder, isSuggestions: true);
  }

  Widget _getBody(
    BuildContext context,
    B bloc,
    BloweSearchInitialBuilder<T>? initialBuilder, {
    bool isSuggestions = false,
  }) {
    return BlocBuilder<B, BloweState<BlowePaginationModel<T>>>(
      bloc: bloc,
      builder: (context, state) {
        if (isSuggestions && query.isEmpty) {
          final history = state.history?.items.reversed.toList() ?? [];
          if (history.isEmpty) {
            return initialBuilder?.call(context, close) ??
                const SizedBox.shrink();
          }

          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final item = history[index];
              return Dismissible(
                key: ValueKey(item),
                onDismissed: (direction) {
                  bloc.removeSearchHistory(item);
                },
                background: Container(color: Colors.red),
                child: itemBuilder(
                  context,
                  item,
                  close,
                  (T item) => bloc.addSearchHistory(item),
                ),
              );
            },
          );
        }
        if (state is BloweInProgress<BlowePaginationModel<T>>) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is BloweError<BlowePaginationModel<T>>) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.error.toString()),
              ElevatedButton(
                onPressed: () => bloc.fetch(paramsProvider(query)),
                child: const Text('Retry'),
              ),
            ],
          );
        }

        if (state is BloweCompleted<BlowePaginationModel<T>>) {
          final items = state.data.items;

          if (items.isEmpty) {
            return emptyBuilder?.call(context, query) ??
                const Center(child: Text('No results found'));
          }

          return BlowePaginationListView<B, T, P, void>(
            bloc: bloc,
            itemBuilder: (context, item) {
              return itemBuilder(
                context,
                item,
                close,
                (T item) => bloc.addSearchHistory(item),
              );
            },
            paramsProvider: () => paramsProvider(query),
            emptyWidget: emptyBuilder?.call(context, query),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

/// A class to debounce user input to prevent excessive search requests.
class _Debouncer {
  _Debouncer({required this.milliseconds});

  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
