import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:flutter/material.dart';

/// Typedef for a widget builder function used by BloweBlocSelector.
///
/// - [context]: The BuildContext of the widget.
/// - [enabled]: Indicates if the widget should be enabled.
typedef BloweBlocWidgetSelectorBuilder = Widget Function(
  BuildContext context,
  bool enabled,
);

/// A widget that uses a BlocSelector to determine if the widget
/// should be enabled.
/// It rebuilds based on the state of the specified BloweBloc.
class BloweBlocSelector<B extends BloweBloc<T, dynamic>, T>
    extends StatelessWidget {
  /// Creates an instance of BloweBlocSelector.
  ///
  /// - [builder]: The builder function to create the widget.
  const BloweBlocSelector({
    required this.builder,
    super.key,
  });

  /// The builder function to create the widget.
  final BloweBlocWidgetSelectorBuilder builder;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<B, BloweState<T>, bool>(
      selector: (state) => state is! BloweInProgress,
      builder: builder,
    );
  }
}
