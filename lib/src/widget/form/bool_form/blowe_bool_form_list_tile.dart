import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:flutter/material.dart';

/// Enum for specifying the type of ListTile to be used.
///
/// This enum is used in the `BloweBoolFormListTile` widget to determine
/// whether a `SwitchListTile` or a `CheckboxListTile` should be rendered.
enum BloweBoolListTileType {
  /// Represents a `SwitchListTile`.
  switchTile,

  /// Represents a `CheckboxListTile`.
  checkboxTile,
}

/// Typedef for a title builder function used by BloweBoolFormListTile.
///
/// - [context]: The BuildContext of the widget.
typedef BloweBoolFormListTileTitleBuilder = String Function(
  BuildContext context,
);

/// Typedef for a validator function used by BloweBoolFormListTile.
///
/// - [context]: The BuildContext of the widget.
/// - [value]: The current value of the switch or checkbox.
typedef BloweBoolFormListTileValidator = String? Function(
  BuildContext context,
  bool value,
);

/// A form field widget that wraps a SwitchListTile or CheckboxListTile.
///
/// The `BloweBoolFormListTile` widget provides a way to use a switch or
/// checkbox within a form, utilizing a `BloweBoolFormController` to manage
/// its state.
/// This widget supports customization of the switch's or checkbox's appearance
/// and behavior, including validation, enabling/disabling, and visual styling.
///
/// Example usage:
/// ```dart
/// final _controller = BloweBoolFormController(initialValue: true);
///
/// @override
/// Widget build(BuildContext context) {
///   return Form(
///     child: Column(
///       children: [
///         BloweBoolFormListTile(
///           controller: _controller,
///           title: (context) => 'Enable notifications',
///           type: BloweBoolListTileType.switchTile,
///         ),
///       ],
///     ),
///   );
/// }
/// ```
class BloweBoolFormListTile extends StatelessWidget {
  /// Creates an instance of `BloweBoolFormListTile`.
  ///
  /// - [controller]: The controller for the switch or checkbox, managing
  /// its state.
  /// - [title]: A builder function for the title text of the switch or
  /// checkbox.
  /// - [validator]: The validator function for the switch or checkbox value.
  /// - [enabled]: Indicates if the switch or checkbox is enabled
  /// (default is true).
  /// - [dense]: Indicates if the switch or checkbox tile should be dense.
  /// - [controlAffinity]: The control affinity for the switch or checkbox tile
  /// (default is platform).
  /// - [type]: Specifies the type of tile to use, either switch or checkbox.
  const BloweBoolFormListTile({
    required this.controller,
    required this.title,
    this.type = BloweBoolListTileType.switchTile,
    this.validator,
    super.key,
    this.enabled = true,
    this.dense,
    this.controlAffinity = ListTileControlAffinity.platform,
  });

  /// The controller for the switch or checkbox.
  ///
  /// The `BloweBoolFormController` manages the state of the switch or checkbox,
  /// including its initial value and any changes to its state.
  final BloweBoolFormController controller;

  /// Indicates if the switch or checkbox is enabled.
  ///
  /// When set to `false`, the switch or checkbox will be disabled and cannot
  /// be interacted with.
  final bool enabled;

  /// The title for the switch or checkbox.
  ///
  /// This function returns the title text to be displayed next to the switch
  /// or checkbox.
  final BloweBoolFormListTileTitleBuilder title;

  /// Indicates if the switch or checkbox tile should be dense.
  ///
  /// When set to `true`, the switch or checkbox tile will have a denser layout,
  /// taking up less space.
  final bool? dense;

  /// The control affinity for the switch or checkbox tile.
  ///
  /// This determines the placement of the switch or checkbox relative to its
  /// text label.
  /// The default is platform-specific.
  final ListTileControlAffinity controlAffinity;

  /// The validator for the switch or checkbox value.
  ///
  /// This function returns a validator function to validate the switch's or
  /// checkbox's value.
  final BloweBoolFormListTileValidator? validator;

  /// Specifies the type of tile to use, either switch or checkbox.
  final BloweBoolListTileType type;

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
            if (type == BloweBoolListTileType.switchTile)
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
            if (type == BloweBoolListTileType.checkboxTile)
              CheckboxListTile(
                value: value,
                onChanged: enabled
                    ? (newValue) {
                        if (newValue == null) return;

                        didChange(newValue);
                        controller.value = newValue;
                      }
                    : null,
                title: Text(title(context)),
                shape: shape,
                dense: dense,
                controlAffinity: controlAffinity,
              ),
            if (hasError && enabled)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Text(
                  state.errorText ?? '',
                  style: Theme.of(context).inputDecorationTheme.errorStyle,
                ),
              ),
          ],
        );
      },
    );
  }
}
