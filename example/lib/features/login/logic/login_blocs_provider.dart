import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:example/features/login/logic/login_bloc.dart';
import 'package:flutter/material.dart';

class LoginBlocsProvider extends StatelessWidget {
  const LoginBlocsProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: child,
    );
  }
}
