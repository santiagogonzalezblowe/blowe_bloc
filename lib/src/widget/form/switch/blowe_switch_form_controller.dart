import 'package:flutter/foundation.dart';

/// A controller for a BloweSwitchFormListTile.
class BloweSwitchFormController extends ValueNotifier<bool> {
  /// Creates a BloweSwitchFormController.
  ///
  /// - [initialValue]: The initial value of the switch (default is false).
  BloweSwitchFormController({bool initialValue = false}) : super(initialValue);

  /// Gets the current value of the switch.
  @override
  bool get value => super.value;

  /// Sets the value of the switch.
  @override
  set value(bool newValue) {
    super.value = newValue;
  }
}
