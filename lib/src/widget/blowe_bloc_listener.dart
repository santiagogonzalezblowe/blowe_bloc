import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:flutter/widgets.dart';

/// Typedef for a widget listener function used by BloweBlocListener.
///
/// - [context]: The BuildContext of the widget.
/// - [state]: The state of the BloweBloc.
typedef BloweBlocWidgetListener<T, S extends BloweState<T>> = void Function(
  BuildContext context,
  S state,
);

/// A widget that listens to the state changes of a BloweBloc and triggers
/// the corresponding callback functions for each state type.
class BloweBlocListener<B extends BloweBloc<T, dynamic>, T>
    extends BlocListenerBase<B, BloweState<T>> {
  /// Creates an instance of BloweBlocListener.
  ///
  /// - [key]: Optional key for the widget.
  /// - [child]: Optional child widget.
  /// - [onCompleted]: Callback for BloweCompleted state.
  /// - [onError]: Callback for BloweError state.
  /// - [onLoading]: Callback for BloweInProgress state.
  /// - [onInitial]: Callback for BloweInitial state.
  BloweBlocListener({
    super.key,
    super.child,
    BloweBlocWidgetListener<T, BloweCompleted<T>>? onCompleted,
    BloweBlocWidgetListener<T, BloweError<T>>? onError,
    BloweBlocWidgetListener<T, BloweInProgress<T>>? onLoading,
    BloweBlocWidgetListener<T, BloweInitial<T>>? onInitial,
  }) : super(
          listener: (context, state) {
            if (state is BloweCompleted<T>) onCompleted?.call(context, state);
            if (state is BloweError<T>) onError?.call(context, state);
            if (state is BloweInProgress<T>) onLoading?.call(context, state);
            if (state is BloweInitial<T>) onInitial?.call(context, state);
          },
        );
}
