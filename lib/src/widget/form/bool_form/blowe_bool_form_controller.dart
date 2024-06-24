import 'package:flutter/foundation.dart';

/// A controller for a form field that uses a boolean value.
class BloweBoolFormController extends ValueNotifier<bool> {
  /// Creates a BloweBoolFormController.
  ///
  /// - [initialValue]: The initial value of the form field (default is false).
  BloweBoolFormController({bool initialValue = false}) : super(initialValue);

  /// Gets the current value of the form field.
  @override
  bool get value => super.value;

  /// Sets the value of the form field.
  @override
  set value(bool newValue) {
    super.value = newValue;
  }
}
