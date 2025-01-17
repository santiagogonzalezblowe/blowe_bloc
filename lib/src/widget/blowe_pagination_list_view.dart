import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

/// Typedef for a widget builder function used to build the error widget.
///
/// - [context]: The BuildContext of the widget.
/// - [error]: The exception that occurred.
typedef BlowePaginationErrorBuilder = Widget Function(
  BuildContext context,
  Exception error,
);

/// A widget that displays a paginated list of items using a
/// BlowePaginationBloc.
/// It handles loading, error, and completed states of the BlowePaginationBloc.
class BlowePaginationListView<
    B extends BlowePaginationBloc<BlowePaginationModel<T>, P>,
    T,
    P,
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
  /// - [errorBuilder]: Optional builder function to create a custom error
  /// widget.
  /// - [onRefreshEnabled]: Indicates if the refresh functionality is enabled.
  /// - [bloc]: The bloc to use for the list view.
  /// - [shrinkWrap]: Indicates if the list view should shrink-wrap its
  /// contents.
  /// - [loadThreshold]: Threshold (in pixels) to determine when to load the
  /// next page. Defaults to 100 pixels from the end of the scroll.
  const BlowePaginationListView({
    required this.itemBuilder,
    required this.paramsProvider,
    this.emptyWidget,
    this.startWidget,
    this.endWidget,
    this.padding,
    this.filter,
    this.groupBy,
    this.groupHeaderBuilder,
    this.errorBuilder,
    this.onRefreshEnabled = true,
    this.bloc,
    this.shrinkWrap = false,
    this.loadThreshold = 100,
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

  /// A widget to display at the start of the list.
  final Widget? startWidget;

  /// A widget to display at the end of the list.
  final Widget? endWidget;

  /// Optional padding for the list view.
  final EdgeInsetsGeometry? padding;

  /// Optional function to filter items in the list.
  final BloweItemFilter<T>? filter;

  /// Optional function to group items in the list.
  final BloweItemGrouper<T, G>? groupBy;

  /// Optional builder function to create group headers.
  final BloweGroupHeaderBuilder<T, G>? groupHeaderBuilder;

  /// Optional builder function to create a custom error widget.
  final BlowePaginationErrorBuilder? errorBuilder;

  /// Indicates if the refresh functionality is enabled.
  final bool onRefreshEnabled;

  /// The bloc to use for the list view.
  final B? bloc;

  /// Indicates if the list view should shrink-wrap its contents.
  final bool shrinkWrap;

  /// Threshold (in pixels) to determine when to load the next page.
  /// Defaults to 100 pixels from the end of the scroll.
  final double loadThreshold;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, BloweState<BlowePaginationModel<T>>>(
      bloc: bloc,
      builder: (context, state) {
        if (state is BloweInProgress<BlowePaginationModel<T>>) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is BloweError<BlowePaginationModel<T>>) {
          if (errorBuilder != null) return errorBuilder!(context, state.error);

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.error.toString()),
              ElevatedButton(
                onPressed: () {
                  if (bloc != null) {
                    bloc!.fetch(paramsProvider());
                  } else {
                    context.read<B>().fetch(paramsProvider());
                  }
                },
                child: const Text('Retry'),
              ),
            ],
          );
        }

        if (state is BloweCompleted<BlowePaginationModel<T>>) {
          final filteredItems = filter != null
              ? state.data.items.where(filter!).toList()
              : state.data.items;

          if (filteredItems.isEmpty && emptyWidget != null) {
            return _EmptyList<B, P>(
              paramsProvider: paramsProvider,
              padding: padding,
              emptyWidget: emptyWidget!,
              onRefreshEnabled: onRefreshEnabled,
              bloc: bloc,
            );
          }

          return _BlowePaginationListViewLoaded<B, T, P, G>(
            filteredData: BlowePaginationModel(
              items: filteredItems,
              totalCount: filteredItems.length,
            ),
            data: state.data,
            isLoadingMore: state.isLoadingMore,
            itemBuilder: itemBuilder,
            padding: padding,
            paramsProvider: paramsProvider,
            startWidget: startWidget,
            endWidget: endWidget,
            groupBy: groupBy,
            groupHeaderBuilder: groupHeaderBuilder,
            onRefreshEnabled: onRefreshEnabled,
            bloc: bloc,
            loadThreshold: loadThreshold,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _BlowePaginationListViewLoaded<
    B extends BlowePaginationBloc<BlowePaginationModel<T>, P>,
    T,
    P,
    G> extends StatefulWidget {
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
    required this.filteredData,
    required this.isLoadingMore,
    required this.itemBuilder,
    required this.paramsProvider,
    this.startWidget,
    this.endWidget,
    super.key,
    this.padding,
    this.groupBy,
    this.groupHeaderBuilder,
    this.onRefreshEnabled = true,
    this.bloc,
    this.shrinkWrap = false,
    this.loadThreshold = 100,
  });

  /// The data for the list view.
  final BlowePaginationModel<T> data;

  /// The filtered data for the list view.
  final BlowePaginationModel<T> filteredData;

  /// Indicates if more data is being loaded.
  final bool isLoadingMore;

  /// The builder function to create list items.
  final BlowePaginationListViewItemBuilder<T> itemBuilder;

  /// Optional padding for the list view.
  final EdgeInsetsGeometry? padding;

  /// A function that provides parameters for the BloweFetch event.
  final BloweFetchParamsProvider<P> paramsProvider;

  /// A widget to display at the start of the list.
  final Widget? startWidget;

  /// A widget to display at the end of the list.
  final Widget? endWidget;

  /// Optional function to group items in the list.
  final BloweItemGrouper<T, G>? groupBy;

  /// Optional builder function to create group headers.
  final BloweGroupHeaderBuilder<T, G>? groupHeaderBuilder;

  /// Indicates if the refresh functionality is enabled.
  final bool onRefreshEnabled;

  /// The bloc to use for the list view.
  final B? bloc;

  /// Indicates if the list view should shrink-wrap its contents.
  final bool shrinkWrap;

  /// Threshold (in pixels) to determine when to load the next page.
  /// Defaults to 100 pixels from the end of the scroll.
  final double loadThreshold;

  @override
  State<_BlowePaginationListViewLoaded<B, T, P, G>> createState() =>
      __BlowePaginationListViewStateLoaded<B, T, P, G>();
}

class __BlowePaginationListViewStateLoaded<
    B extends BlowePaginationBloc<BlowePaginationModel<T>, P>,
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
          final currentOffset = _scrollController.position.pixels;
          final scrollDirection =
              _scrollController.position.userScrollDirection;
          final maxScrollExtent = _scrollController.position.maxScrollExtent;

          if (widget.isLoadingMore ||
              widget.data.totalCount == widget.data.items.length) {
            return;
          }

          if (scrollDirection == ScrollDirection.reverse) {
            if (currentOffset >= maxScrollExtent - widget.loadThreshold) {
              if (widget.bloc != null) {
                widget.bloc!.fetchMore(widget.paramsProvider());
              } else {
                context.read<B>().fetchMore(widget.paramsProvider());
              }
            }
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
    final items = _buildItems;

    return _BloweRefreshWrapper(
      onRefreshEnabled: widget.onRefreshEnabled,
      onRefresh: () async {
        if (widget.bloc != null) {
          widget.bloc!.fetch(widget.paramsProvider());
        } else {
          context.read<B>().fetch(widget.paramsProvider());
        }
      },
      child: ListView.builder(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        shrinkWrap: widget.shrinkWrap,
        padding: widget.padding,
        controller: _scrollController,
        itemCount: items.length,
        itemBuilder: (context, index) => items[index],
      ),
    );
  }

  List<Widget> get _buildItems {
    final widgets = <Widget>[];

    if (widget.startWidget != null) widgets.add(widget.startWidget!);

    if (widget.groupBy != null) {
      _groupItems.forEach(
        (key, value) {
          if (widget.groupHeaderBuilder != null) {
            widgets.add(widget.groupHeaderBuilder!(context, key, value));
          }

          widgets.addAll(
            value.map((item) => widget.itemBuilder(context, item)),
          );
        },
      );
    } else {
      widgets.addAll(
        widget.filteredData.items.map(
          (item) => widget.itemBuilder(context, item),
        ),
      );
    }

    if (widget.endWidget != null) widgets.add(widget.endWidget!);

    if (widget.isLoadingMore) {
      widgets.add(const LinearProgressIndicator(minHeight: 2));
    }

    return widgets;
  }

  Map<G, List<T>> get _groupItems {
    final groupedItems = <G, List<T>>{};
    for (final item in widget.filteredData.items) {
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
    this.onRefreshEnabled = true,
    this.bloc,
    this.shrinkWrap = false,
    super.key,
  });

  /// Optional padding for the list view.
  final EdgeInsetsGeometry? padding;

  /// A function that provides parameters for the BloweFetch event.
  final BloweFetchParamsProvider<P> paramsProvider;

  /// A widget to display when the list is empty.
  final Widget emptyWidget;

  /// Indicates if the refresh functionality is enabled.
  final bool onRefreshEnabled;

  /// The bloc to use for the list view.
  final B? bloc;

  /// Indicates if the list view should shrink-wrap its contents.
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return _BloweRefreshWrapper(
      onRefreshEnabled: onRefreshEnabled,
      onRefresh: () async {
        if (bloc != null) {
          bloc!.fetch(paramsProvider());
        } else {
          context.read<B>().fetch(paramsProvider());
        }
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: padding,
        shrinkWrap: shrinkWrap,
        children: [emptyWidget],
      ),
    );
  }
}

/// A widget that wraps a child with a RefreshIndicator if onRefresh is enabled.
class _BloweRefreshWrapper extends StatelessWidget {
  /// Creates an instance of BloweRefreshWrapper.
  ///
  /// - [onRefreshEnabled]: A boolean to enable or disable refresh
  /// functionality.
  /// - [onRefresh]: The callback to invoke when a refresh is triggered.
  /// - [child]: The child widget to wrap.
  const _BloweRefreshWrapper({
    required this.onRefresh,
    required this.child,
    this.onRefreshEnabled = true,
  });

  /// Indicates if the refresh functionality is enabled.
  final bool onRefreshEnabled;

  /// The callback to invoke when a refresh is triggered.
  final Future<void> Function() onRefresh;

  /// The child widget to wrap.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (onRefreshEnabled) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: child,
      );
    } else {
      return child;
    }
  }
}
