import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// The root widget of the example application.
class MyApp extends StatelessWidget {
  /// Creates an instance of MyApp.
  ///
  /// - [key]: An optional key for the widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => MyBloweBloc(),
        child: const MyHomePage(),
      ),
    );
  }
}

/// The main page of the example application.
class MyHomePage extends StatelessWidget {
  /// Creates an instance of MyHomePage.
  ///
  /// - [key]: An optional key for the widget.
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blowe Bloc Example'),
      ),
      floatingActionButton: BloweBlocSelector<MyBloweBloc>(
        builder: (context, enabled) {
          return FloatingActionButton(
            onPressed: enabled
                ? () {
                    context.read<MyBloweBloc>().add(
                          const BloweFetch(BloweNoParams()),
                        );
                  }
                : null,
            child: const Icon(Icons.add),
          );
        },
      ),
      body: Center(
        child: BlocBuilder<MyBloweBloc, BloweState>(
          builder: (context, state) {
            if (state is BloweInProgress) {
              return const CircularProgressIndicator();
            }
            if (state is BloweCompleted<String>) {
              return Text(state.data);
            }
            if (state is BloweError) {
              return const Text('Error: Press the button to load data');
            }
            return const Text('Initial: Press the button to load data');
          },
        ),
      ),
    );
  }
}

/// A BLoC that loads a string after a delay of 2 seconds.
class MyBloweBloc extends BloweLoadBloc<String, BloweNoParams> {
  @override
  Future<String> load(BloweNoParams params) => Future<String>.delayed(
        const Duration(seconds: 2),
        () {
          return 'Blowe Bloc Completed!';
        },
      );
}
