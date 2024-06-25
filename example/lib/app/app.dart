import 'package:example/app/constants/theme.dart';
import 'package:example/app/router/router.dart';
import 'package:flutter/material.dart';

final routerConfig = goRouter;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routerConfig,
      title: 'Blowe Bloc Example',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
