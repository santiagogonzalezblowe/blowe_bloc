import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:flutter/material.dart';

/// Typedef for a title builder function used by BloweRadiusFormListTile.
///
/// - [context]: The BuildContext of the widget.
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
  List<T> value,
);

/// A form field widget that manages a list of radius list tiles.
///
/// The `BloweRadiusForm` widget provides a way to manage a list of radius list tiles within a form, utilizing a `BloweRadiusFormController` to manage its state. This widget supports customization of the appearance and behavior, including validation, enabling/disabling, and visual styling.
///
/// Example usage:
/// ```dart
/// final _controller = BloweRadiusFormController<Radius>(initialValue:
/// [Radius.circular(8)]);
///
/// @override
/// Widget build(BuildContext context) {
///   return Form(
///     child: BloweRadiusForm<Radius>(
///       controller: _controller,
///       items: [Radius.circular(8), Radius.circular(16), Radius.circular(24)],
///       titleBuilder: (context, item) => 'Radius: ${item.x}',
///       validator: (context, value) {
///         if (value.isEmpty) {
///           return 'Please select at least one radius.';
///         }
///         return null;
///       },
///     ),
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
  const BloweRadiusForm({
    required this.controller,
    required this.items,
    required this.titleBuilder,
    this.validator,
    super.key,
    this.enabled = true,
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

  @override
  Widget build(BuildContext context) {
    return FormField<List<T>>(
      initialValue: controller.value,
      enabled: enabled,
      validator: (value) => validator?.call(context, value ?? []),
      builder: (state) {
        final enabled = state.widget.enabled;
        final value = state.value ?? [];
        final didChange = state.didChange;
        final hasError = state.hasError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...items.map(
              (item) => RadioListTile<T>(
                title: Text(titleBuilder(context, item)),
                groupValue: value.contains(item) ? item : null,
                value: item,
                onChanged: enabled
                    ? (newValue) {
                        if (newValue == null) return;

                        final newValueList = [...value];
                        if (newValueList.contains(newValue)) {
                          newValueList.remove(newValue);
                        } else {
                          newValueList.add(newValue);
                        }
                        didChange(newValueList);
                        controller.value = newValueList;
                      }
                    : null,
              ),
            ),
            if (hasError && enabled) FormErrorText(state.errorText ?? ''),
          ],
        );
      },
    );
  }
}
