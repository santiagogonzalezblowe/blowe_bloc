import 'dart:async';

import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:flutter/material.dart';

/// Typedef for a widget builder function used by BloweMultiBlocSelector.
///
/// - [context]: The BuildContext of the widget.
/// - [enabled]: Indicates if the widget should be enabled.
typedef BloweMultiBlocWidgetSelectorBuilder = Widget Function(
  BuildContext context, {
  bool enabled,
});

/// A widget that monitors multiple BloweBlocs and determines if the widget
/// should be enabled based on the state of all provided BloweBlocs.
class BloweMultiBlocSelector extends StatefulWidget {
  /// Creates an instance of BloweMultiBlocSelector.
  ///
  /// - [builder]: The builder function to create the widget.
  /// - [blocs]: The list of BloweBlocs to monitor.
  const BloweMultiBlocSelector({
    required this.builder,
    required this.blocs,
    super.key,
  });

  /// The builder function to create the widget.
  final BloweMultiBlocWidgetSelectorBuilder builder;

  /// The list of BloweBlocs to monitor.
  final List<BloweBloc<dynamic, dynamic>> blocs;

  @override
  BloweMultiBlocSelectorState createState() => BloweMultiBlocSelectorState();
}

/// State class for BloweMultiBlocSelector.
///
/// This class is responsible for managing the state of the
/// BloweMultiBlocSelector widget, including setting up and
/// disposing of the StreamController, and listening
/// to state changes in the provided BloweBlocs.
class BloweMultiBlocSelectorState extends State<BloweMultiBlocSelector> {
  // A StreamController that broadcasts a boolean value indicating whether
  /// all BloweBlocs are not in the BloweInProgress state.
  final StreamController<bool> _streamController = StreamController<bool>();

  @override
  void initState() {
    super.initState();
    for (final bloc in widget.blocs) {
      bloc.stream.listen((state) {
        _streamController.add(
          widget.blocs.every(
            (bloc) => bloc.state is! BloweInProgress,
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        final enabled = snapshot.hasData && snapshot.data!;
        return widget.builder(context, enabled: enabled);
      },
    );
  }
}
