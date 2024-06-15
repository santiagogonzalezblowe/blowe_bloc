import 'package:flutter/material.dart';

/// Typedef for a validator function used by BloweTextFormField.
///
/// - [context]: The BuildContext of the widget.
/// - [value]: The current value of the text field.
typedef BloweTextFormFieldValidator<T> = String? Function(
  BuildContext context,
  T? value,
);

/// Typedef for a suffix icon builder function used by BloweTextFormField.
///
/// - [context]: The BuildContext of the widget.
/// - [obscureText]: Indicates if the text is obscured.
/// - [toggleObscureText]: Callback to toggle text obscuring.
typedef BloweTextFormFieldSuffixIconBuilder = Widget Function(
  BuildContext context,
  bool obscureText,
  VoidCallback toggleObscureText,
);

/// Typedef for a label text builder function used by BloweTextFormField.
///
/// - [context]: The BuildContext of the widget.
typedef BloweTextFormFieldLabelTextBuilder = String Function(
  BuildContext context,
);

/// A text form field widget that supports optional obscuring of text,
/// custom validation, and custom suffix icons.
abstract class BloweTextFormField extends StatefulWidget {
  /// Creates an instance of BloweTextFormField.
  ///
  /// - [obscureText]: Indicates if the text should be obscured
  /// (default is false).
  /// - [controller]: Optional TextEditingController.
  /// - [validator]: Optional validator function.
  /// - [enabled]: Indicates if the text field is enabled.
  /// - [onEditingComplete]: Optional callback when editing is complete.
  /// - [keyboardType]: Optional keyboard type.
  /// - [textInputAction]: Optional text input action.
  /// - [suffixIcon]: Optional builder function for suffix icon.
  /// - [labelText]: Builder function for the label text.
  const BloweTextFormField({
    required this.labelText,
    super.key,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.enabled,
    this.onEditingComplete,
    this.keyboardType,
    this.textInputAction,
    this.suffixIcon,
  });

  /// Indicates if the text should be obscured.
  final bool obscureText;

  /// Optional TextEditingController.
  final TextEditingController? controller;

  /// Optional validator function.
  final BloweTextFormFieldValidator<String>? validator;

  /// Indicates if the text field is enabled.
  final bool? enabled;

  /// Optional callback when editing is complete.
  final VoidCallback? onEditingComplete;

  /// Optional keyboard type.
  final TextInputType? keyboardType;

  /// Optional text input action.
  final TextInputAction? textInputAction;

  /// Optional builder function for suffix icon.
  final BloweTextFormFieldSuffixIconBuilder? suffixIcon;

  /// Builder function for the label text.
  final BloweTextFormFieldLabelTextBuilder labelText;

  @override
  State<BloweTextFormField> createState() => _BloweTextFormFieldState();
}

class _BloweTextFormFieldState extends State<BloweTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText(context),
        suffixIcon: widget.suffixIcon?.call(
          context,
          _obscureText,
          toggleObscureText,
        ),
      ),
      obscureText: _obscureText,
      validator: (value) => widget.validator?.call(context, value),
      enabled: widget.enabled,
      onEditingComplete: widget.onEditingComplete,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
    );
  }

  void toggleObscureText() {
    setState(() => _obscureText = !_obscureText);
  }
}
