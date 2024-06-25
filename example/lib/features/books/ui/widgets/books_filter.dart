import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/features/books/logic/cubit/books_filter_cubit.dart';
import 'package:flutter/material.dart';

class BooksFilter extends StatelessWidget {
  const BooksFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksFilterCubit, bool>(
      builder: (context, state) {
        final text = state ? 'Available' : 'Not available';
        return SwitchListTile(
          value: state,
          title: Text(text),
          onChanged: (value) {
            context.read<BooksFilterCubit>().toggle();
          },
        );
      },
    );
  }
}
