import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

/// Typedef for a prefix icon builder function used by BloweTextFormField.
///
/// - [context]: The BuildContext of the widget.
typedef BloweTextFormFieldPrefixIconBuilder = Widget Function(
  BuildContext context,
);

/// Typedef for a label text builder function used by BloweTextFormField.
///
/// - [context]: The BuildContext of the widget.
typedef BloweTextFormFieldLabelTextBuilder = String Function(
  BuildContext context,
);

/// Typedef for a hint text builder function used by BloweTextFormField.
///
/// - [context]: The BuildContext of the widget.
typedef BloweTextFormFieldHintTextBuilder = String Function(
  BuildContext context,
);

/// Typedef for an onTap callback used by BloweTextFormField.
///
/// - [context]: The BuildContext of the widget.
typedef BloweTextFormFieldOnTap = void Function(
  BuildContext context,
);

/// A text form field widget that supports optional obscuring of text,
/// custom validation, custom icons, and multiline input.
abstract class BloweTextFormField extends StatefulWidget {
  /// Creates an instance of BloweTextFormField.
  ///
  /// - [labelText]: Builder function for the label text.
  /// - [hintText]: Optional builder function for the hint text.
  /// - [obscureText]: Indicates if the text should be obscured
  /// (default is false).
  /// - [controller]: Optional TextEditingController.
  /// - [validator]: Optional validator function.
  /// - [enabled]: Indicates if the text field is enabled.
  /// - [onEditingComplete]: Optional callback when editing is complete.
  /// - [keyboardType]: Optional keyboard type.
  /// - [textInputAction]: Optional text input action.
  /// - [suffixIcon]: Optional builder function for suffix icon.
  /// - [prefixIcon]: Optional builder function for prefix icon.
  /// - [initialValue]: The initial value of the text field.
  /// - [readOnly]: Indicates if the text field is read-only (default is false).
  /// - [onTap]: Optional callback when the text field is tapped.
  /// - [inputFormatters]: Optional list of input formatters.
  /// - [maxLines]: The maximum number of lines to display (default is 1).
  /// - [autofillHints]: Optional autofill hints for the text field.
  /// - [textCapitalization]: Optional text capitalization.
  const BloweTextFormField({
    required this.labelText,
    this.hintText,
    super.key,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.enabled,
    this.onEditingComplete,
    this.keyboardType,
    this.textInputAction,
    this.suffixIcon,
    this.prefixIcon,
    this.initialValue,
    this.readOnly = false,
    this.onTap,
    this.inputFormatters,
    this.maxLines = 1,
    this.autofillHints,
    this.textCapitalization = TextCapitalization.none,
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

  /// Optional builder function for prefix icon.
  final BloweTextFormFieldPrefixIconBuilder? prefixIcon;

  /// Builder function for the label text.
  final BloweTextFormFieldLabelTextBuilder labelText;

  /// Builder function for the hint text.
  final BloweTextFormFieldHintTextBuilder? hintText;

  /// The initial value of the text field.
  final String? initialValue;

  /// Indicates if the text field is read-only.
  final bool readOnly;

  /// Optional callback when the text field is tapped.
  final BloweTextFormFieldOnTap? onTap;

  /// Optional list of input formatters.
  final List<TextInputFormatter>? inputFormatters;

  /// The maximum number of lines for the text field.
  /// If greater than 1, the field can handle multi-line input.
  final int? maxLines;

  /// Optional autofill hints for the text field.
  ///
  /// This property provides hints to the autofill service about the type of
  /// information expected in the text field. It can be used to improve the
  /// accuracy and relevance of autofill suggestions.
  ///
  /// Example values include:
  /// - [AutofillHints.email]: For email addresses.
  /// - [AutofillHints.password]: For passwords.
  /// - [AutofillHints.username]: For usernames.
  ///
  /// If null, no autofill hints will be provided.
  final Iterable<String>? autofillHints;

  /// This property allows you to specify how the text should be capitalized
  /// when the user is typing. This can be useful for fields like
  /// names or addresses where you might want to capitalize the first letter
  /// of each word.
  final TextCapitalization textCapitalization;

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
        hintText: widget.hintText?.call(context),
        suffixIcon: widget.suffixIcon?.call(
          context,
          _obscureText,
          toggleObscureText,
        ),
        prefixIcon: widget.prefixIcon?.call(context),
      ),
      obscureText: _obscureText,
      validator: (value) => widget.validator?.call(context, value),
      enabled: widget.enabled,
      onEditingComplete: widget.onEditingComplete,
      keyboardType: _keyboardType,
      textInputAction: widget.textInputAction,
      initialValue: widget.initialValue,
      readOnly: widget.readOnly,
      onTap: () => widget.onTap?.call(context),
      inputFormatters: widget.inputFormatters,
      maxLines: widget.maxLines,
      autofillHints: widget.autofillHints,
      textCapitalization: widget.textCapitalization,
    );
  }

  void toggleObscureText() {
    setState(() => _obscureText = !_obscureText);
  }

  TextInputType get _keyboardType {
    if (widget.keyboardType != null) return widget.keyboardType!;

    if (widget.maxLines == 1) return TextInputType.text;

    return TextInputType.multiline;
  }
}
