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

/// A widget that displays a paginated list of items using a
/// BlowePaginationBloc.
/// It handles loading, error, and completed states of the BlowePaginationBloc.
class BlowePaginationListView<B extends BlowePaginationBloc<dynamic, dynamic>,
    T> extends StatelessWidget {
  /// Creates an instance of BlowePaginationListView.
  ///
  /// - [itemBuilder]: The builder function to create list items.
  /// - [padding]: Optional padding for the list view.
  const BlowePaginationListView({
    required this.itemBuilder,
    super.key,
    this.padding,
  });

  /// The builder function to create list items.
  final BlowePaginationListViewItemBuilder<T> itemBuilder;

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
                  context.read<B>().add(const BloweFetch(BloweNoParams()));
                },
                child: const Text('Retry'),
              ),
            ],
          );
        }

        if (state is BloweCompleted<BlowePaginationModel<T>>) {
          return _BlowePaginationListViewLoaded<B, T>(
            data: state.data,
            isLoadingMore: state.isLoadingMore,
            itemBuilder: itemBuilder,
            padding: padding,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _BlowePaginationListViewLoaded<
    B extends BlowePaginationBloc<dynamic, dynamic>, T> extends StatefulWidget {
  /// Creates an instance of _BlowePaginationListViewLoaded.
  ///
  /// - [data]: The data for the list view.
  /// - [isLoadingMore]: Indicates if more data is being loaded.
  /// - [itemBuilder]: The builder function to create list items.
  /// - [padding]: Optional padding for the list view.
  const _BlowePaginationListViewLoaded({
    required this.data,
    required this.isLoadingMore,
    required this.itemBuilder,
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

  @override
  State<_BlowePaginationListViewLoaded<B, T>> createState() =>
      __BlowePaginationListViewStateLoaded<B, T>();
}

class __BlowePaginationListViewStateLoaded<
    B extends BlowePaginationBloc<dynamic, dynamic>,
    T> extends State<_BlowePaginationListViewLoaded<B, T>> {
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
                  const BloweFetchMore(BloweNoParams()),
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
        context.read<B>().add(const BloweFetch(BloweNoParams()));
      },
      child: ListView.builder(
        padding: widget.padding,
        controller: _scrollController,
        itemCount: widget.data.items.length,
        itemBuilder: (context, index) {
          final items = widget.data.items;
          final item = items[index];

          if (index == items.length - 1) {
            return Column(
              children: [
                widget.itemBuilder(context, item),
                if (widget.isLoadingMore)
                  const LinearProgressIndicator(minHeight: 2),
              ],
            );
          }

          return widget.itemBuilder(context, item);
        },
      ),
    );
  }
}
