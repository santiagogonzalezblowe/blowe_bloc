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

class BloweSearchDelegate<
    B extends BloweSearchBloc<T, P>,
    T extends BloweSerializableItem,
    P extends BloweSearchParams> extends SearchDelegate<T?> {
  BloweSearchDelegate({
    // super.searchFieldStyle,
    // super.searchFieldDecorationTheme,
    // super.textInputAction,
    required this.bloc,
    required this.itemBuilder,
    required this.paramsProvider,
    super.searchFieldLabel,
    super.keyboardType,
    this.initialBuilder,
    this.emptyBuilder,
    this.historyItemBuilder,
  });

  final B bloc;
  final BloweSearchInitialBuilder<T>? initialBuilder;
  final BloweSearchItemBuilder<T> itemBuilder;
  final BloweSearchEmptyWidgetBuilder? emptyBuilder;
  final BloweSearchItemBuilder<T>? historyItemBuilder;

  /// A function that provides parameters for the BloweFetch event.
  final BloweFetchParamsProvider<P> paramsProvider;

  @override
  List<Widget> buildActions(BuildContext context) {
    if (query.isEmpty) return [];

    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
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
    bloc.add(BloweFetch<P>(paramsProvider()));
    return _getBody(context, bloc, initialBuilder);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
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
              return historyItemBuilder != null
                  ? historyItemBuilder!(context, item, close)
                  : ListTile(
                      title: Text(item.toString()),
                      onTap: () {
                        query = item.toString();
                        showResults(context);
                      },
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
                  bloc.add(BloweFetch(paramsProvider()));
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
            itemBuilder: (context, item) => itemBuilder(context, item, close),
            paramsProvider: paramsProvider,
            emptyWidget: emptyBuilder?.call(context, query),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
