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
  blowe_bloc: ^0.1.0
```

Then run \`flutter pub get\` to install the package.

## Usage

### Basic Example

Here is a basic example of how to use `blowe_bloc` in your Flutter application.

```dart
import 'package:flutter/material.dart';
import 'package:blowe_bloc/blowe_bloc.dart';

void main() {
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: BlocProvider(
                create: (context) => MyBloweBloc(),
                child: MyHomePage(),
            ),
        );
    }
}

class MyHomePage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Blowe Bloc Example'),
            ),
            body: Center(
                child: BloweBlocButton<MyBloweBloc, ElevatedButton>(
                    text: 'Fetch Data',
                    onPressed: () {
                        context.read<MyBloweBloc>().add(BloweFetch(BloweNoParams()));
                    },
                ),
            ),
        );
    }
}

class MyBloweBloc extends BloweBloc<void, BloweNoParams> {
    @override
    Future<void> onFetch(
        BloweFetch<BloweNoParams> event,
        Emitter<BloweBlocState> emit,
    ) async {
        // Your fetch logic here
    }
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
