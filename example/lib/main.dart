import 'package:example/app/app.dart';
import 'package:example/app/repositories/app_repositories_provider.dart';
import 'package:example/app/services/app_services_provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const AppServicesProvider(
      child: AppRepositoriesProvider(child: MyApp()),
    ),
  );
}
