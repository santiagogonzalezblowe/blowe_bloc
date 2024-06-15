import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:flutter/widgets.dart';

/// Typedef for a widget listener function used by BloweBlocListener.
///
/// - [context]: The BuildContext of the widget.
/// - [state]: The state of the BloweBloc.
typedef BloweBlocWidgetListener<S extends BloweState> = void Function(
  BuildContext context,
  S state,
);

/// A widget that listens to the state changes of a BloweBloc and triggers
/// the corresponding callback functions for each state type.
class BloweBlocListener<B extends BloweBloc<T, dynamic>, T>
    extends BlocListenerBase<B, BloweState> {
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
    BloweBlocWidgetListener<BloweCompleted<T>>? onCompleted,
    BloweBlocWidgetListener<BloweError>? onError,
    BloweBlocWidgetListener<BloweInProgress>? onLoading,
    BloweBlocWidgetListener<BloweInitial>? onInitial,
  }) : super(
          listener: (context, state) {
            if (state is BloweCompleted<T>) onCompleted?.call(context, state);
            if (state is BloweError) onError?.call(context, state);
            if (state is BloweInProgress) onLoading?.call(context, state);
            if (state is BloweInitial) onInitial?.call(context, state);
          },
        );
}
