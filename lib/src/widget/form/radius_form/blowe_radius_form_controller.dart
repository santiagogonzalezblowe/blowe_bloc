import 'package:flutter/foundation.dart';

/// A controller for a form field that manages a list of radius items.
class BloweRadiusFormController<T> extends ValueNotifier<List<T>> {
  /// Creates a BloweRadiusFormController.
  ///
  /// - [initialValue]: The initial value of the form field
  /// (default is an empty list).
  BloweRadiusFormController({List<T> initialValue = const []})
      : super(initialValue);

  /// Gets the current value of the form field.
  @override
  List<T> get value => super.value;

  /// Sets the value of the form field.
  @override
  set value(List<T> newValue) {
    super.value = newValue;
  }
}
