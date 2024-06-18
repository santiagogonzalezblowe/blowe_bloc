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

/// A widget that displays a paginated list of items using a
/// BlowePaginationBloc.
/// It handles loading, error, and completed states of the BlowePaginationBloc.
class BlowePaginationListView<B extends BlowePaginationBloc<dynamic, P>, T, P>
    extends StatelessWidget {
  /// Creates an instance of BlowePaginationListView.
  ///
  /// - [itemBuilder]: The builder function to create list items.
  /// - [paramsProvider]: A function that provides parameters for the
  /// BloweFetch event.
  /// - [emptyWidget]: A widget to display when the list is empty.
  /// - [padding]: Optional padding for the list view.
  const BlowePaginationListView({
    required this.itemBuilder,
    required this.paramsProvider,
    this.emptyWidget,
    this.padding,
    super.key,
  });

  /// The builder function to create list items.
  final BlowePaginationListViewItemBuilder<T> itemBuilder;

  /// A function that provides parameters for the BloweFetch event.
  final BloweFetchParamsProvider<P> paramsProvider;

  /// A widget to display when the list is empty.
  final Widget? emptyWidget;

  /// Optional padding for the list view.
  final EdgeInsetsGeometry? padding;

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
          if (state.data.items.isEmpty && emptyWidget != null) {
            return _EmptyList<B, P>(
              paramsProvider: paramsProvider,
              padding: padding,
              emptyWidget: emptyWidget!,
            );
          }
          return _BlowePaginationListViewLoaded<B, T, P>(
            data: state.data,
            isLoadingMore: state.isLoadingMore,
            itemBuilder: itemBuilder,
            padding: padding,
            paramsProvider: paramsProvider,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _BlowePaginationListViewLoaded<B extends BlowePaginationBloc<dynamic, P>,
    T, P> extends StatefulWidget {
  /// Creates an instance of _BlowePaginationListViewLoaded.
  ///
  /// - [data]: The data for the list view.
  /// - [isLoadingMore]: Indicates if more data is being loaded.
  /// - [itemBuilder]: The builder function to create list items.
  /// - [padding]: Optional padding for the list view.
  /// - [paramsProvider]: A function that provides parameters for the
  /// BloweFetch event.
  const _BlowePaginationListViewLoaded({
    required this.data,
    required this.isLoadingMore,
    required this.itemBuilder,
    required this.paramsProvider,
    super.key,
    this.padding,
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

  @override
  State<_BlowePaginationListViewLoaded<B, T, P>> createState() =>
      __BlowePaginationListViewStateLoaded<B, T, P>();
}

class __BlowePaginationListViewStateLoaded<
    B extends BlowePaginationBloc<dynamic, P>,
    T,
    P> extends State<_BlowePaginationListViewLoaded<B, T, P>> {
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
              _scrollController.position.maxScrollExtent * 0.8) {
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
        itemCount: widget.data.items.length + (widget.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == widget.data.items.length) {
            return const LinearProgressIndicator(minHeight: 2);
          }
          final item = widget.data.items[index];
          return widget.itemBuilder(context, item);
        },
      ),
    );
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
