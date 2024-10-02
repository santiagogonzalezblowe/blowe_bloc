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
class BloweBoolFormListTile extends StatefulWidget {
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
    this.adaptive = false,
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

  /// Indicates if the switch or checkbox tile should be adaptive.
  final bool adaptive;

  @override
  State<BloweBoolFormListTile> createState() => _BloweBoolFormListTileState();
}

class _BloweBoolFormListTileState extends State<BloweBoolFormListTile> {
  late bool _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.controller.value;
    widget.controller.addListener(_handleControllerChange);
  }

  @override
  void didUpdateWidget(covariant BloweBoolFormListTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_handleControllerChange);
      widget.controller.addListener(_handleControllerChange);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerChange);
    super.dispose();
  }

  void _handleControllerChange() {
    if (_currentValue != widget.controller.value) {
      setState(() => _currentValue = widget.controller.value);
    }
  }

  void _handleValueChanged(bool? newValue) {
    if (newValue == null) return;

    if (widget.enabled) {
      setState(() => _currentValue = newValue);
      widget.controller.value = newValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      initialValue: _currentValue,
      enabled: widget.enabled,
      validator: (value) => widget.validator?.call(
        context,
        widget.controller.value,
      ),
      builder: (state) {
        final hasError = state.hasError;

        final shape = Theme.of(context).inputDecorationTheme.border?.copyWith(
              borderSide: Theme.of(context)
                  .inputDecorationTheme
                  .border
                  ?.borderSide
                  .copyWith(
                    color: widget.enabled
                        ? hasError
                            ? Theme.of(context).colorScheme.error
                            : Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                  ),
            );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildListTile(shape),
            if (hasError && widget.enabled)
              BloweFormErrorText(state.errorText ?? ''),
          ],
        );
      },
    );
  }

  Widget _buildListTile(ShapeBorder? shape) {
    final type = widget.type;

    if (type == BloweBoolListTileType.switchTile) {
      if (widget.adaptive) {
        return SwitchListTile.adaptive(
          value: _currentValue,
          onChanged: widget.enabled ? _handleValueChanged : null,
          title: Text(widget.title(context)),
          shape: shape,
          dense: widget.dense,
          controlAffinity: widget.controlAffinity,
        );
      } else {
        return SwitchListTile(
          value: _currentValue,
          onChanged: widget.enabled ? _handleValueChanged : null,
          title: Text(widget.title(context)),
          shape: shape,
          dense: widget.dense,
          controlAffinity: widget.controlAffinity,
        );
      }
    } else {
      if (widget.adaptive) {
        return CheckboxListTile.adaptive(
          value: _currentValue,
          onChanged: widget.enabled ? _handleValueChanged : null,
          title: Text(widget.title(context)),
          shape: shape,
          dense: widget.dense,
          controlAffinity: widget.controlAffinity,
        );
      } else {
        return CheckboxListTile(
          value: _currentValue,
          onChanged: widget.enabled ? _handleValueChanged : null,
          title: Text(widget.title(context)),
          shape: shape,
          dense: widget.dense,
          controlAffinity: widget.controlAffinity,
        );
      }
    }
  }
}

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
