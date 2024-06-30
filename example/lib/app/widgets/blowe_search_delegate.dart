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

class BloweSearchDelegate<B extends BlowePaginationBloc<dynamic, P>, T, P>
    extends SearchDelegate<T?> {
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
  });

  final B bloc;
  final BloweSearchInitialBuilder<T>? initialBuilder;
  final BloweSearchItemBuilder<T> itemBuilder;

  /// A function that provides parameters for the BloweFetch event.
  final BloweFetchParamsProvider<P> paramsProvider;

  @override
  List<Widget> buildActions(BuildContext context) {
    if (query.isEmpty) return [];

    return [
      IconButton(
        onPressed: () {
          query = '';
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
    return _getBody(context, bloc, initialBuilder);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _getBody(context, bloc, initialBuilder);
  }

  Widget _getBody(
    context,
    B bloc,
    BloweSearchInitialBuilder<T>? initialBuilder,
  ) {
    return BlocBuilder<B, BloweState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is BloweInitial) {
          if (initialBuilder != null) {
            return initialBuilder(context, close);
          }
        }

        if (state is BloweInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is BloweCompleted<BlowePaginationModel<T>>) {
          final items = state.data.items;

          if (items.isEmpty) {
            return const Center(
              child: Text('No results found'),
            );
          }

          return BlowePaginationListView<B, T, P, void>(
            itemBuilder: (context, item) {
              return itemBuilder(context, item, close);
            },
            paramsProvider: paramsProvider,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
