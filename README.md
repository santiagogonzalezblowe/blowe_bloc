# blowe_bloc

`blowe_bloc` is an advanced Flutter package for state management and business logic components, extending `flutter_bloc`.

## Features

- **Advanced BLoC Components**: Specialized BLoCs for handling data loading, pagination, and stream watching.
- **Comprehensive Models**: Models for representing paginated data and handling no parameter scenarios.
- **Reactive Widgets**: A variety of widgets including buttons, listeners, dropdowns, list views, and text form fields that react to state changes.
- **Easy Integration**: Built on top of `flutter_bloc` for seamless integration into your Flutter applications.

## Installation

To use `blowe_bloc`, add it to your `pubspec.yaml`:

```yaml
dependencies:
  blowe_bloc: ^0.1.3
```

Then run \`flutter pub get\` to install the package.

## Usage

### Basic Example

Here is a basic example of how to use `blowe_bloc` in your Flutter application.

```dart
import 'package:blowe_bloc/blowe_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
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

class MyHomePage extends StatelessWidget {
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

class MyBloweBloc extends BloweLoadBloc<String, BloweNoParams> {
  @override
  Future<String> load(BloweNoParams params) => Future<String>.delayed(
        const Duration(seconds: 2),
        () {
          return 'Blowe Bloc Completed!';
        },
      );
}
```

## Documentation

For detailed usage examples and API references, check out the [documentation](https://pub.dev/documentation/blowe_bloc/latest/).

## Issues

If you encounter any issues, please report them on our [issue tracker](https://github.com/santiagogonzalezblowe/blowe_bloc/issues).

## License

This project is licensed under the MIT License. See the [LICENSE](https://github.com/santiagogonzalezblowe/blowe_bloc/blob/master/LICENSE) file for details.

## Author

Developed by [Santiago Gonzalez Fernandez](https://www.linkedin.com/in/santiagogonzalezblowe/).
