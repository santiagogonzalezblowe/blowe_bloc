import 'dart:async';
import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:flutter/material.dart';

typedef BloweSearchInitialBuilder<T> = Widget Function(
  BuildContext context,
  void Function(BuildContext context, T? result) close,
);

typedef BloweSearchItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  void Function(BuildContext context, T? result) close,
);

typedef BloweSearchEmptyWidgetBuilder = Widget Function(
  BuildContext context,
  String query,
);

typedef BloweSearchParamsProvider<P> = P Function(String query);

class BloweSearchDelegate<
    B extends BloweSearchBloc<T, P>,
    T extends BloweSerializableItem,
    P extends BloweSearchParams> extends SearchDelegate<T?> {
  BloweSearchDelegate({
    required this.bloc,
    required this.itemBuilder,
    required this.paramsProvider,
    super.searchFieldLabel,
    super.keyboardType,
    this.initialBuilder,
    this.emptyBuilder,
    this.historyItemBuilder,
  }) : _debouncer = _Debouncer(milliseconds: 300);

  final B bloc;
  final BloweSearchInitialBuilder<T>? initialBuilder;
  final BloweSearchItemBuilder<T> itemBuilder;
  final BloweSearchEmptyWidgetBuilder? emptyBuilder;
  final BloweSearchItemBuilder<T>? historyItemBuilder;
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
          bloc.add(BloweReset());
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
        bloc.add(BloweFetch<P>(paramsProvider(query)));
      } else {
        bloc.add(BloweReset());
      }
    });
    return _getBody(context, bloc, initialBuilder);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _debouncer.run(() {
      if (query.isNotEmpty) {
        bloc.add(BloweFetch<P>(paramsProvider(query)));
      } else {
        bloc.add(BloweReset());
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
          final history = state.history?.items ?? [];
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
                  bloc.add(BloweRemoveSearchHistory<T>(item));
                },
                background: Container(color: Colors.red),
                child: historyItemBuilder != null
                    ? historyItemBuilder!(context, item, close)
                    : ListTile(
                        title: Text(item.toString()),
                        onTap: () {
                          query = item.toString();
                          bloc.add(BloweAddSearchHistory<T>(item));
                          showResults(context);
                        },
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
                onPressed: () {
                  bloc.add(BloweFetch(paramsProvider(query)));
                },
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
              return GestureDetector(
                onTap: () {
                  bloc.add(BloweAddSearchHistory<T>(item));
                  close(context, item);
                },
                child: itemBuilder(context, item, close),
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
