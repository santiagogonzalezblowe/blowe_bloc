import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:flutter/material.dart';

/// Typedef for a title builder function used by BloweCheckboxFormListTile.
///
/// - [context]: The BuildContext of the widget.
typedef BloweCheckboxFormListTileTitleBuilder = String Function(
  BuildContext context,
);

/// Typedef for a validator function used by BloweCheckboxFormListTile.
///
/// - [context]: The BuildContext of the widget.
/// - [value]: The current value of the checkbox.
typedef BloweCheckboxFormListTileValidator = String? Function(
  BuildContext context,
  bool value,
);

/// A form field widget that wraps a CheckboxListTile.
///
/// The `BloweCheckboxFormListTile` widget provides a way to use a checkbox
/// within a form, utilizing a `BloweBoolFormController` to manage
/// its state. This widget supports customization of the checkbox's
/// appearance and behavior, including validation, enabling/disabling, and visual styling.
///
/// Example usage:
/// ```dart
/// final _checkboxController = BloweBoolFormController(initialValue: true);
///
/// @override
/// Widget build(BuildContext context) {
///   return Form(
///     child: Column(
///       children: [
///         BloweCheckboxFormListTile(
///           controller: _checkboxController,
///         ),
///       ],
///     ),
///   );
/// }
/// ```
class BloweCheckboxFormListTile extends StatelessWidget {
  /// Creates an instance of `BloweCheckboxFormListTile`.
  ///
  /// - [controller]: The controller for the checkbox, managing its state.
  /// - [title]: A builder function for the title text of the checkbox.
  /// - [validator]: The validator function for the checkbox value.
  /// - [enabled]: Indicates if the checkbox is enabled (default is true).
  /// - [dense]: Indicates if the checkbox tile should be dense.
  /// - [controlAffinity]: The control affinity for the checkbox tile (default
  /// is platform).
  const BloweCheckboxFormListTile({
    required this.controller,
    required this.title,
    this.validator,
    super.key,
    this.enabled = true,
    this.dense,
    this.controlAffinity = ListTileControlAffinity.platform,
  });

  /// The controller for the checkbox.
  ///
  /// The `BloweBoolFormController` manages the state of the checkbox,
  /// including its initial value and any changes to its state.
  final BloweBoolFormController controller;

  /// Indicates if the checkbox is enabled.
  ///
  /// When set to `false`, the checkbox will be disabled and cannot be
  /// interacted with.
  final bool enabled;

  /// The title for the checkbox.
  ///
  /// This function returns the title text to be displayed next to the checkbox.
  final BloweCheckboxFormListTileTitleBuilder title;

  /// Indicates if the checkbox tile should be dense.
  ///
  /// When set to `true`, the checkbox tile will have a denser layout, taking
  /// up less space.
  final bool? dense;

  /// The control affinity for the checkbox tile.
  ///
  /// This determines the placement of the checkbox relative to its text label.
  /// The default is platform-specific.
  final ListTileControlAffinity controlAffinity;

  /// The validator for the checkbox value.
  ///
  /// This function returns a validator function to validate the checkbox's
  /// value.
  final BloweCheckboxFormListTileValidator? validator;

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      initialValue: controller.value,
      enabled: enabled,
      validator: (value) => validator?.call(context, value ?? false),
      builder: (state) {
        final enabled = state.widget.enabled;
        final value = state.value ?? false;
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
            CheckboxListTile(
              value: value,
              onChanged: enabled
                  ? (newValue) {
                      didChange(newValue);
                      controller.value = newValue!;
                    }
                  : null,
              title: Text(title(context)),
              shape: shape,
              dense: dense,
              controlAffinity: controlAffinity,
            ),
            if (hasError && enabled) FormErrorText(state.errorText ?? ''),
          ],
        );
      },
    );
  }
}
