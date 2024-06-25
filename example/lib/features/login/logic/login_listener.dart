import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/features/load_book/ui/page/load_book_page.dart';
import 'package:example/features/login/logic/login_bloc.dart';
import 'package:flutter/material.dart';

class LoginListener extends StatelessWidget {
  const LoginListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BloweBlocListener<LoginBloc, void>(
      onCompleted: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign in successful!'),
          ),
        );
        LoadBookPage.go(context);
      },
      onError: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error.toString()),
          ),
        );
      },
      child: child,
    );
  }
}
