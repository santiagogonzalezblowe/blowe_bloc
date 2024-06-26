import 'package:flutter/material.dart';

/// A widget that displays an error message for a form field.
///
/// The `BloweFormErrorText` widget is typically used to display validation
/// errors for form fields. It provides a consistent style and padding for error
/// messages.
class BloweFormErrorText extends StatelessWidget {
  /// Creates an instance of `BloweFormErrorText`.
  ///
  /// - [text]: The error message to display.
  const BloweFormErrorText(this.text, {super.key});

  /// The error message to display.
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8),
      child: Text(
        text,
        style: Theme.of(context).inputDecorationTheme.errorStyle,
      ),
    );
  }
}
