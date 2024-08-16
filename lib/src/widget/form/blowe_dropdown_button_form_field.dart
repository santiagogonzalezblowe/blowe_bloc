import 'package:flutter/material.dart';

/// Typedef for a validator function used by BloweDropdownButtonFormField.
///
/// - [context]: The BuildContext of the widget.
/// - [value]: The selected value of the dropdown.
typedef BloweDropdownButtonFormFieldValidator<T> = String? Function(
  BuildContext context,
  T? value,
);

/// Typedef for a dropdown menu item builder function used by
/// BloweDropdownButtonFormField.
///
/// - [context]: The BuildContext of the widget.
/// - [item]: The item to build a dropdown menu item for.
typedef BlowDropdownMenuItemBuilder<T> = DropdownMenuItem<T> Function(
  BuildContext context,
  T item,
);

/// Typedef for an icon builder function used by BloweDropdownButtonFormField.
///
/// - [context]: The BuildContext of the widget.
typedef BloweDropdownButtonFormFieldIconBuilder = Widget? Function(
  BuildContext context,
);

/// Typedef for a suffix icon builder function used by
/// BloweDropdownButtonFormField.
///
/// - [context]: The BuildContext of the widget.
typedef BloweDropdownButtonFormFieldSuffixIconBuilder = Widget? Function(
  BuildContext context,
);

/// Typedef for a label text builder function used by
/// BloweDropdownButtonFormField.
///
/// - [context]: The BuildContext of the widget.
typedef BloweDropdownButtonFormFieldLabelTextBuilder = String Function(
  BuildContext context,
);

/// A dropdown button form field widget that allows customization of the
/// dropdown items, icon, suffix icon, label text, and validator.
abstract class BloweDropdownButtonFormField<T> extends StatelessWidget {
  /// Creates an instance of BloweDropdownButtonFormField.
  ///
  /// - [items]: The list of items of type T.
  /// - [onChanged]: Callback when the selected item changes.
  /// - [itemBuilder]: Builder function to create dropdown menu items.
  /// - [labelText]: Builder function to create the label text.
  /// - [icon]: Optional builder function to create the icon.
  /// - [suffixIcon]: Optional builder function to create the suffix icon.
  /// - [validator]: Optional validator function.
  /// - [enabled]: Indicates if the dropdown is enabled (default is true).
  /// - [value]: The currently selected value.
  const BloweDropdownButtonFormField({
    required this.items,
    required this.onChanged,
    required this.itemBuilder,
    required this.labelText,
    this.icon,
    this.suffixIcon,
    this.validator,
    this.enabled = true,
    this.value,
    super.key,
  });

  /// The list of items of type T.
  final List<T> items;

  /// Callback when the selected item changes.
  final ValueChanged<T?> onChanged;

  /// Builder function to create dropdown menu items.
  final BlowDropdownMenuItemBuilder<T> itemBuilder;

  /// Optional validator function.
  final BloweDropdownButtonFormFieldValidator<T>? validator;

  /// Builder function to create the label text.
  final BloweDropdownButtonFormFieldLabelTextBuilder labelText;

  /// Optional builder function to create the icon.
  final BloweDropdownButtonFormFieldIconBuilder? icon;

  /// Optional builder function to create the suffix icon.
  final BloweDropdownButtonFormFieldSuffixIconBuilder? suffixIcon;

  /// Indicates if the dropdown is enabled.
  final bool enabled;

  /// The currently selected value.
  final T? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      items: items.map((item) => itemBuilder(context, item)).toList(),
      onChanged: enabled ? onChanged : null,
      validator: (value) => validator?.call(context, value),
      decoration: InputDecoration(
        labelText: labelText(context),
        suffixIcon: suffixIcon?.call(context),
      ),
      icon: icon?.call(context),
      value: value,
      isExpanded: true,
    );
  }
}
