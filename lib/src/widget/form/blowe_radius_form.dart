import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:flutter/material.dart';

/// Typedef for a title builder function used by BloweRadiusFormListTile.
///
/// - [context]: The BuildContext of the widget.
/// - [item]: The item to build the title for.
typedef BloweRadiusFormListTileTitleBuilder<T> = String Function(
  BuildContext context,
  T item,
);

/// Typedef for a validator function used by BloweRadiusForm.
///
/// - [context]: The BuildContext of the widget.
/// - [value]: The current value of the radius form.
typedef BloweRadiusFormValidator<T> = String? Function(
  BuildContext context,
  T? value,
);

/// A form field widget that manages a list of radius list tiles.
///
/// The `BloweRadiusForm` widget provides a way to manage a list of radius list
/// tiles within a form, utilizing a `BloweRadiusFormController` to manage its
/// state.
/// This widget supports customization of the appearance and behavior, including
/// validation, enabling/disabling, and visual styling.
///
/// Example usage:
/// ```dart
/// final _controller = BloweRadiusFormController<int>(initialValue: 1);
///
/// @override
/// Widget build(BuildContext context) {
///   return BloweRadiusForm<int>(
///     controller: _controller,
///     items: [1, 2, 3],
///     titleBuilder: (context, item) => 'Item: $item',
///     validator: (context, value) {
///       if (value == null) {
///         return 'Please select an item.';
///       }
///       return null;
///     },
///   );
/// }
/// ```
class BloweRadiusForm<T> extends StatelessWidget {
  /// Creates an instance of `BloweRadiusForm`.
  ///
  /// - [controller]: The controller for the form, managing its state.
  /// - [items]: The list of items to display as radius list tiles.
  /// - [titleBuilder]: A builder function for the title text of each radius
  /// list tile.
  /// - [validator]: The validator function for the form value.
  /// - [enabled]: Indicates if the form is enabled (default is true).
  /// - [controlAffinity]: The control affinity for the radio list tile
  /// (default is platform).
  /// - [toggleable]: Indicates if the radio list tile is toggleable.
  const BloweRadiusForm({
    required this.controller,
    required this.items,
    required this.titleBuilder,
    this.validator,
    super.key,
    this.enabled = true,
    this.controlAffinity = ListTileControlAffinity.platform,
    this.toggleable = false,
  });

  /// The controller for the form.
  ///
  /// The `BloweRadiusFormController` manages the state of the form,
  /// including its initial value and any changes to its state.
  final BloweRadiusFormController<T> controller;

  /// The list of items to display as radius list tiles.
  final List<T> items;

  /// A builder function for the title text of each radius list tile.
  final BloweRadiusFormListTileTitleBuilder<T> titleBuilder;

  /// The validator for the form value.
  ///
  /// This function returns a validator function to validate the form's value.
  final BloweRadiusFormValidator<T>? validator;

  /// Indicates if the form is enabled.
  ///
  /// When set to `false`, the form will be disabled and cannot be
  /// interacted with.
  final bool enabled;

  /// The control affinity for the radio list tile.
  final ListTileControlAffinity controlAffinity;

  /// Indicates if the radio list tile is toggleable.
  final bool toggleable;

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: controller.value,
      enabled: enabled,
      validator: (value) => validator?.call(context, value),
      builder: (state) {
        final enabled = state.widget.enabled;
        final value = state.value;
        final didChange = state.didChange;
        final hasError = state.hasError;

        final shape = Theme.of(context).inputDecorationTheme.border?.copyWith(
              borderSide: Theme.of(context)
                  .inputDecorationTheme
                  .border
                  ?.borderSide
                  .copyWith(
                    color: enabled
                        ? hasError
                            ? Theme.of(context).colorScheme.error
                            : Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                  ),
            );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              shape: shape,
              child: Column(
                children: items
                    .map(
                      (item) => RadioListTile<T>(
                        title: Text(titleBuilder(context, item)),
                        groupValue: value,
                        value: item,
                        toggleable: toggleable,
                        onChanged: enabled
                            ? (newValue) {
                                didChange(newValue);
                                controller.value = newValue;
                              }
                            : null,
                        controlAffinity: controlAffinity,
                      ),
                    )
                    .toList(),
              ),
            ),
            if (hasError && enabled) BloweFormErrorText(state.errorText ?? ''),
          ],
        );
      },
    );
  }
}

/// A controller for a form field that manages a single selected item.
class BloweRadiusFormController<T> extends ValueNotifier<T?> {
  /// Creates a BloweRadiusFormController.
  ///
  /// - [initialValue]: The initial value of the form field.
  BloweRadiusFormController({T? initialValue}) : super(initialValue);

  /// Gets the current value of the form field.
  @override
  T? get value => super.value;

  /// Sets the value of the form field.
  @override
  set value(T? newValue) {
    super.value = newValue;
  }
}
