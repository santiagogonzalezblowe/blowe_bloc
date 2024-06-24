import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:flutter/material.dart';

/// Typedef for a title builder function used by BloweSwitchFormListTile.
///
/// - [context]: The BuildContext of the widget.
typedef BloweSwitchFormListTileTitleBuilder = String Function(
  BuildContext context,
);

/// Typedef for a validator function used by BloweSwitchFormListTile.
///
/// - [context]: The BuildContext of the widget.
/// - [value]: The current value of the switch.
typedef BloweSwitchFormListTileValidator = String? Function(
  BuildContext context,
  bool value,
);

/// A form field widget that wraps a SwitchListTile.
///
/// The `BloweSwitchFormListTile` widget provides a way to use a switch
/// within a form, utilizing a `BloweBoolFormController` to manage
/// its state. This widget supports customization of the switch's
/// appearance and behavior, including validation, enabling/disabling, and visual styling.
///
/// Example usage:
/// ```dart
/// final _switchController = BloweBoolFormController(initialValue: true);
///
/// @override
/// Widget build(BuildContext context) {
///   return Form(
///     child: Column(
///       children: [
///         BloweSwitchFormListTile(
///           controller: _switchController,
///         ),
///       ],
///     ),
///   );
/// }
/// ```
class BloweSwitchFormListTile extends StatelessWidget {
  /// Creates an instance of `BloweSwitchFormListTile`.
  ///
  /// - [controller]: The controller for the switch, managing its state.
  /// - [title]: A builder function for the title text of the switch.
  /// - [validator]: The validator function for the switch value.
  /// - [enabled]: Indicates if the switch is enabled (default is true).
  /// - [dense]: Indicates if the switch tile should be dense.
  /// - [controlAffinity]: The control affinity for the switch tile (default
  /// is platform).
  const BloweSwitchFormListTile({
    required this.controller,
    required this.title,
    this.validator,
    super.key,
    this.enabled = true,
    this.dense,
    this.controlAffinity = ListTileControlAffinity.platform,
  });

  /// The controller for the switch.
  ///
  /// The `BloweBoolFormController` manages the state of the switch,
  /// including its initial value and any changes to its state.
  final BloweBoolFormController controller;

  /// Indicates if the switch is enabled.
  ///
  /// When set to `false`, the switch will be disabled and cannot be interacted
  /// with.
  final bool enabled;

  /// The title for the switch.
  ///
  /// This function returns the title text to be displayed next to the switch.
  final BloweSwitchFormListTileTitleBuilder title;

  /// Indicates if the switch tile should be dense.
  ///
  /// When set to `true`, the switch tile will have a denser layout, taking
  /// up less space.
  final bool? dense;

  /// The control affinity for the switch tile.
  ///
  /// This determines the placement of the switch relative to its text label.
  /// The default is platform-specific.
  final ListTileControlAffinity controlAffinity;

  /// The validator for the switch value.
  ///
  /// This function returns a validator function to validate the switch's value.
  final BloweSwitchFormListTileValidator? validator;

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
            SwitchListTile(
              value: value,
              onChanged: enabled
                  ? (newValue) {
                      didChange(newValue);
                      controller.value = newValue;
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
