import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:flutter/material.dart';

class PasswordTextFormField extends BloweTextFormField {
  PasswordTextFormField({
    super.key,
    super.controller,
    super.enabled,
    super.onEditingComplete,
    super.textInputAction,
  }) : super(
          validator: (context, value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          suffixIcon: (context, obscureText, toggleObscureText) {
            return IconButton(
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: toggleObscureText,
            );
          },
          labelText: (context) => 'Password',
        );
}
