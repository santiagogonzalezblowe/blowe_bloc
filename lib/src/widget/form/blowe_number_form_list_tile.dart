import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:flutter/material.dart';

/// A typedef for the title builder function used by BloweNumberFormListTile.
typedef BloweNumberFormListTileTitleBuilder = String Function(
  BuildContext context,
);

/// A typedef for the validator function used by BloweNumberFormListTile.
typedef BloweNumberFormListTileValidator = String? Function(
  BuildContext context,
  int value,
);

/// A form field widget that provides a number selector with increment
/// and decrement buttons.
class BloweNumberFormListTile extends StatefulWidget {
  /// Creates an instance of `BloweNumberFormListTile`.
  ///
  /// - [controller]: The controller for the number input field, managing
  /// its state.
  /// - [title]: A builder function for the title text of the number field.
  /// - [validator]: The validator function for the number value.
  /// - [enabled]: Indicates if the field is enabled (default is true).
  /// - [minValue]: The minimum value allowed (default is 0).
  /// - [maxValue]: The maximum value allowed (optional).
  /// - [numberStyle]: The style for the number text.
  const BloweNumberFormListTile({
    required this.controller,
    required this.title,
    this.validator,
    super.key,
    this.enabled = true,
    this.minValue = 0,
    this.maxValue,
    this.numberStyle,
  });

  /// The controller for the number input field.
  final BloweNumberFormController controller;

  /// Indicates if the number input field is enabled.
  final bool enabled;

  /// The title for the number input field.
  final BloweNumberFormListTileTitleBuilder title;

  /// The validator for the number input field.
  final BloweNumberFormListTileValidator? validator;

  /// The minimum value allowed for the number input.
  final int minValue;

  /// The maximum value allowed for the number input (optional).
  final int? maxValue;

  /// The style for the number text.
  final TextStyle? numberStyle;

  @override
  State<BloweNumberFormListTile> createState() =>
      _BloweNumberFormListTileState();
}

class _BloweNumberFormListTileState extends State<BloweNumberFormListTile> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.controller.value;
    widget.controller.addListener(_handleControllerChange);
  }

  @override
  void didUpdateWidget(covariant BloweNumberFormListTile oldWidget) {
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

  void _incrementValue() {
    if (widget.enabled &&
        (widget.maxValue == null || _currentValue < widget.maxValue!)) {
      setState(() => _currentValue++);
      widget.controller.value = _currentValue;
    }
  }

  void _decrementValue() {
    if (widget.enabled && _currentValue > widget.minValue) {
      setState(() => _currentValue--);
      widget.controller.value = _currentValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<int>(
      initialValue: _currentValue,
      enabled: widget.enabled,
      validator: (value) => widget.validator?.call(
        context,
        value ?? widget.minValue,
      ),
      builder: (state) {
        final hasError = state.hasError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(widget.title(context)),
              shape: _getShape(hasError),
              enabled: widget.enabled,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: widget.enabled ? _decrementValue : null,
                    icon: const Icon(Icons.remove),
                  ),
                  Text('$_currentValue', style: _numberStyle),
                  IconButton(
                    onPressed: widget.enabled ? _incrementValue : null,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            if (hasError && widget.enabled)
              BloweFormErrorText(state.errorText ?? ''),
          ],
        );
      },
    );
  }

  InputBorder? _getShape(bool hasError) {
    return Theme.of(context).inputDecorationTheme.border?.copyWith(
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
  }

  TextStyle? get _numberStyle {
    final customText = widget.numberStyle;
    if (customText != null) {
      return customText.copyWith(
        color: widget.enabled ? null : Theme.of(context).disabledColor,
      );
    } else {
      return Theme.of(context).textTheme.labelLarge?.copyWith(
            color: widget.enabled ? null : Theme.of(context).disabledColor,
          );
    }
  }
}

/// A controller for the number input field.
class BloweNumberFormController extends ValueNotifier<int> {
  /// Creates a BloweNumberFormController.
  ///
  /// - [initialValue]: The initial value of the form field (default is 0).
  BloweNumberFormController({int initialValue = 0}) : super(initialValue);

  /// Gets the current value of the form field.
  @override
  int get value => super.value;

  /// Sets the value of the form field.
  @override
  set value(int newValue) {
    super.value = newValue;
  }
}
