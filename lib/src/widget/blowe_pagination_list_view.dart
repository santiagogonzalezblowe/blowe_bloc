import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:flutter/material.dart';

/// Typedef for a widget builder function used by BlowePaginationListView.
///
/// - [context]: The BuildContext of the widget.
/// - [item]: The item to build a widget for.
typedef BlowePaginationListViewItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
);

/// Typedef for a function that provides parameters for the BloweFetch event.
typedef BloweFetchParamsProvider<P> = P Function();

/// Typedef for a function that filters items in the list.
typedef BloweItemFilter<T> = bool Function(T item);

/// Typedef for a function that groups items in the list.
typedef BloweItemGrouper<T, G> = G Function(T item);

/// Typedef for a widget builder function used to build the group header.
///
/// - [context]: The BuildContext of the widget.
/// - [group]: The group identifier.
/// - [items]: The list of items in the group.
typedef BloweGroupHeaderBuilder<T, G> = Widget Function(
  BuildContext context,
  G group,
  List<T> items,
);

/// A widget that displays a paginated list of items using a
/// BlowePaginationBloc.
/// It handles loading, error, and completed states of the BlowePaginationBloc.
class BlowePaginationListView<B extends BlowePaginationBloc<dynamic, P>, T, P,
    G> extends StatelessWidget {
  /// Creates an instance of BlowePaginationListView.
  ///
  /// - [itemBuilder]: The builder function to create list items.
  /// - [paramsProvider]: A function that provides parameters for the
  /// BloweFetch event.
  /// - [emptyWidget]: A widget to display when the list is empty.
  /// - [padding]: Optional padding for the list view.
  /// - [filter]: Optional function to filter items in the list.
  /// - [groupBy]: Optional function to group items in the list.
  /// - [groupHeaderBuilder]: Optional builder function to create group headers.
  const BlowePaginationListView({
    required this.itemBuilder,
    required this.paramsProvider,
    this.emptyWidget,
    this.padding,
    this.filter,
    this.groupBy,
    this.groupHeaderBuilder,
    super.key,
  }) : assert(
          groupBy == null || groupHeaderBuilder != null,
          'groupBy and groupHeaderBuilder must be provided together',
        );

  /// The builder function to create list items.
  final BlowePaginationListViewItemBuilder<T> itemBuilder;

  /// A function that provides parameters for the BloweFetch event.
  final BloweFetchParamsProvider<P> paramsProvider;

  /// A widget to display when the list is empty.
  final Widget? emptyWidget;

  /// Optional padding for the list view.
  final EdgeInsetsGeometry? padding;

  /// Optional function to filter items in the list.
  final BloweItemFilter<T>? filter;

  /// Optional function to group items in the list.
  final BloweItemGrouper<T, G>? groupBy;

  /// Optional builder function to create group headers.
  final BloweGroupHeaderBuilder<T, G>? groupHeaderBuilder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, BloweState>(
      builder: (context, state) {
        if (state is BloweInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is BloweError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.error.toString()),
              ElevatedButton(
                onPressed: () {
                  context.read<B>().add(BloweFetch(paramsProvider()));
                },
                child: const Text('Retry'),
              ),
            ],
          );
        }

        if (state is BloweCompleted<BlowePaginationModel<T>>) {
          final items = filter != null
              ? state.data.items.where(filter!).toList()
              : state.data.items;

          if (items.isEmpty && emptyWidget != null) {
            return _EmptyList<B, P>(
              paramsProvider: paramsProvider,
              padding: padding,
              emptyWidget: emptyWidget!,
            );
          }

          return _BlowePaginationListViewLoaded<B, T, P, G>(
            data: BlowePaginationModel(
              items: items,
              totalCount: state.data.totalCount,
            ),
            isLoadingMore: state.isLoadingMore,
            itemBuilder: itemBuilder,
            padding: padding,
            paramsProvider: paramsProvider,
            groupBy: groupBy,
            groupHeaderBuilder: groupHeaderBuilder,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _BlowePaginationListViewLoaded<B extends BlowePaginationBloc<dynamic, P>,
    T, P, G> extends StatefulWidget {
  /// Creates an instance of _BlowePaginationListViewLoaded.
  ///
  /// - [data]: The data for the list view.
  /// - [isLoadingMore]: Indicates if more data is being loaded.
  /// - [itemBuilder]: The builder function to create list items.
  /// - [padding]: Optional padding for the list view.
  /// - [paramsProvider]: A function that provides parameters for the
  /// BloweFetch event.
  /// - [groupBy]: Optional function to group items in the list.
  /// - [groupHeaderBuilder]: Optional builder function to create group headers.
  const _BlowePaginationListViewLoaded({
    required this.data,
    required this.isLoadingMore,
    required this.itemBuilder,
    required this.paramsProvider,
    super.key,
    this.padding,
    this.groupBy,
    this.groupHeaderBuilder,
  });

  /// The data for the list view.
  final BlowePaginationModel<T> data;

  /// Indicates if more data is being loaded.
  final bool isLoadingMore;

  /// The builder function to create list items.
  final BlowePaginationListViewItemBuilder<T> itemBuilder;

  /// Optional padding for the list view.
  final EdgeInsetsGeometry? padding;

  /// A function that provides parameters for the BloweFetch event.
  final BloweFetchParamsProvider<P> paramsProvider;

  /// Optional function to group items in the list.
  final BloweItemGrouper<T, G>? groupBy;

  /// Optional builder function to create group headers.
  final BloweGroupHeaderBuilder<T, G>? groupHeaderBuilder;

  @override
  State<_BlowePaginationListViewLoaded<B, T, P, G>> createState() =>
      __BlowePaginationListViewStateLoaded<B, T, P, G>();
}

class __BlowePaginationListViewStateLoaded<
    B extends BlowePaginationBloc<dynamic, P>,
    T,
    P,
    G> extends State<_BlowePaginationListViewLoaded<B, T, P, G>> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(
        () {
          if (widget.isLoadingMore ||
              widget.data.totalCount == widget.data.items.length) {
            return;
          }

          if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200) {
            context.read<B>().add(
                  BloweFetchMore(widget.paramsProvider()),
                );
          }
        },
      );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<B>().add(BloweFetch(widget.paramsProvider()));
      },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: widget.padding,
        controller: _scrollController,
        itemCount: _getItemCount(),
        itemBuilder: (context, index) {
          if (index == _getItemCount() - 1 && widget.isLoadingMore) {
            return const LinearProgressIndicator(minHeight: 2);
          }
          final item = _getItemAt(index);
          if (item is _GroupHeader) {
            return item.header;
          }
          return widget.itemBuilder(context, item as T);
        },
      ),
    );
  }

  int _getItemCount() {
    if (widget.groupBy == null) {
      return widget.data.items.length + (widget.isLoadingMore ? 1 : 0);
    }
    final groupedItems = _groupItems();
    var count = groupedItems.keys.length;
    groupedItems.forEach((key, value) {
      count += value.length;
    });
    if (widget.isLoadingMore) {
      count++;
    }
    return count;
  }

  dynamic _getItemAt(int index) {
    if (widget.groupBy == null) {
      return widget.data.items[index];
    }
    final groupedItems = _groupItems();
    var currentIndex = 0;
    for (final group in groupedItems.entries) {
      if (currentIndex == index) {
        return _GroupHeader(
          header: widget.groupHeaderBuilder!(
            context,
            group.key,
            group.value,
          ),
        );
      }
      currentIndex++;
      if (index < currentIndex + group.value.length) {
        return group.value[index - currentIndex];
      }
      currentIndex += group.value.length;
    }
    return null;
  }

  Map<G, List<T>> _groupItems() {
    final groupedItems = <G, List<T>>{};
    for (final item in widget.data.items) {
      final group = widget.groupBy!(item);
      if (!groupedItems.containsKey(group)) {
        groupedItems[group] = [];
      }
      groupedItems[group]!.add(item);
    }
    return groupedItems;
  }
}

class _EmptyList<B extends BlowePaginationBloc<dynamic, P>, P>
    extends StatelessWidget {
  const _EmptyList({
    required this.paramsProvider,
    required this.emptyWidget,
    this.padding,
    super.key,
  });

  /// Optional padding for the list view.
  final EdgeInsetsGeometry? padding;

  /// A function that provides parameters for the BloweFetch event.
  final BloweFetchParamsProvider<P> paramsProvider;

  /// A widget to display when the list is empty.
  final Widget emptyWidget;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<B>().add(BloweFetch(paramsProvider()));
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: padding,
        children: [emptyWidget],
      ),
    );
  }
}

class _GroupHeader {
  const _GroupHeader({required this.header});

  final Widget header;
}
