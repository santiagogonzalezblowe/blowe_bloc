import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/enums/genre.dart';
import 'package:example/app/extensions/string.dart';
import 'package:flutter/material.dart';

class GenreDropdownButtonFormField extends BloweDropdownButtonFormField<Genre> {
  GenreDropdownButtonFormField({
    super.key,
    required super.onChanged,
    super.enabled,
    super.value,
  }) : super(
          items: Genre.values,
          labelText: (context) => 'Favorite genre',
          validator: (context, value) {
            if (value == null) {
              return 'You must select a genre';
            }
            return null;
          },
          itemBuilder: (context, item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item.name.capitalize()),
            );
          },
        );
}
