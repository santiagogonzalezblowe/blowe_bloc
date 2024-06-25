import 'package:example/features/login/logic/login_blocs_provider.dart';
import 'package:example/features/login/logic/login_listener.dart';
import 'package:example/features/login/ui/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static String get routePath => '/login';
  static String get routeName => 'login';

  static void go(BuildContext context) => context.goNamed(routeName);

  @override
  Widget build(BuildContext context) {
    return const LoginBlocsProvider(
      child: LoginListener(
        child: Scaffold(
          body: SafeArea(
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}
