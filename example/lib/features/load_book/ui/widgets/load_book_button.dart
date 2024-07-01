import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/app/services/book/models/book_model.dart';
import 'package:example/features/load_book/logic/load_book_bloc.dart';
import 'package:flutter/material.dart';

class LoadBookButton extends StatelessWidget {
  const LoadBookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BloweBlocSelector<LoadBookBloc, BookModel>(
      builder: (context, enable) {
        return FloatingActionButton(
          onPressed: enable
              ? () => context
                  .read<LoadBookBloc>()
                  .add(const BloweFetch(BloweNoParams()))
              : null,
          child: const Icon(Icons.replay_outlined),
        );
      },
    );
  }
}
