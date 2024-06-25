import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:flutter/material.dart';

class EmailTextFormField extends BloweTextFormField {
  EmailTextFormField({
    super.key,
    super.controller,
    super.enabled,
    super.onEditingComplete,
    super.textInputAction,
  }) : super(
          validator: (context, value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
          keyboardType: TextInputType.emailAddress,
          labelText: (context) => 'Email',
        );
}
