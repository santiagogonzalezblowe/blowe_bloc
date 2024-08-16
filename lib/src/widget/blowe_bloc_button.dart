import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:flutter/material.dart';

/// A button widget that uses a BloweBloc to determine if the
/// button should be enabled.
/// It rebuilds based on the state of the specified BloweBloc.
class BloweBlocButton<B extends BloweBloc<T, dynamic>,
    N extends ButtonStyleButton, T> extends StatelessWidget {
  /// Creates an instance of BloweBlocButton.
  ///
  /// - [text]: The text to display on the button.
  /// - [onPressed]: The callback to invoke when the button is pressed.
  const BloweBlocButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  /// The text to display on the button.
  final String text;

  /// The callback to invoke when the button is pressed.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return BloweBlocSelector<B, T>(builder: _createButton);
  }

  /// Creates the button widget based on the type of ButtonStyleButton
  /// (ElevatedButton, TextButton, OutlinedButton).
  ///
  /// - [context]: The BuildContext of the widget.
  /// - [enabled]: Indicates if the button should be enabled.
  ButtonStyleButton _createButton(BuildContext context, bool enabled) {
    switch (N) {
      case const (ElevatedButton):
        return ElevatedButton(
          onPressed: enabled ? onPressed : null,
          child: Text(text),
        );
      case const (TextButton):
        return TextButton(
          onPressed: enabled ? onPressed : null,
          child: Text(text),
        );
      case const (OutlinedButton):
        return OutlinedButton(
          onPressed: enabled ? onPressed : null,
          child: Text(text),
        );
    }
    throw Exception('Unknown button type');
  }
}
