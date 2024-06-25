<p align="center">
<img src="https://raw.githubusercontent.com/santiagogonzalezblowe/blowe_bloc/master/assets/blowe_logo.png" height="100" alt="Blowe Bloc Package" />
</p>

---

`blowe_bloc` is an advanced Flutter package for state management and business logic components, extending `flutter_bloc`. It provides a comprehensive set of tools to streamline the development of complex applications with clear separation of concerns, efficient state management, and enhanced UI components. By leveraging the powerful BLoC pattern, `blowe_bloc` ensures your app's logic is both scalable and maintainable.

---

## Features

- **Advanced BLoC Components**: Includes specialized BLoCs for handling data loading, pagination, and data watching. Each BLoC is designed to emit specific states (`BloweInProgress`, `BloweCompleted`, `BloweError`) for better state management.
- **Comprehensive Models**: Models such as `BloweNoParams` for operations requiring no parameters and `BlowePaginationModel` for managing paginated data. These models integrate seamlessly with the BLoCs to handle various data scenarios.

- **Reactive Widgets**: A variety of widgets including `BloweBlocButton`, `BloweBlocListener`, `BloweBlocSelector`, `BloweMultiBlocSelector`, `BlowePaginationListView`, and form fields like `BloweTextFormField`, `BloweDropdownButtonFormField`, `BloweBoolFormListTile`, and `BloweRadiusForm`. These widgets are designed to react to state changes efficiently.

- **Form Field Widgets**: Specialized form field widgets that offer enhanced functionality, validation, and customizability. These include `BloweTextFormField` for text input, `BloweDropdownButtonFormField` for dropdowns, `BloweBoolFormListTile` for switch and checkbox tiles, and `BloweRadiusForm` for radio list tiles.

- **Seamless Integration**: Built on top of `flutter_bloc` for easy integration into your existing Flutter projects. The package ensures minimal boilerplate while offering maximum functionality and flexibility.

- **Error Handling**: Enhanced error handling across all BLoCs and widgets, providing robust feedback mechanisms and state recovery options.

## Blowe Logic

### BloweLoadBloc

**BloweLoadBloc** is an abstract class that extends `BloweBloc` and provides a structure for loading data using a provided load method. This class is designed to handle data fetching operations, emitting different states such as `BloweInProgress`, `BloweCompleted<T>`, and `BloweError` based on the result of the data loading process.

#### Example

```dart
class MyBloweLoadBloc extends BloweLoadBloc<String, BloweNoParams> {
  @override
  Future<String> load(BloweNoParams params) => Future<String>.delayed(
        const Duration(seconds: 2),
        () => 'Blowe Load Bloc Completed!',
      );
}
```

### BloweWatchBloc

**BloweWatchBloc** is an abstract class that extends `BloweBloc` and provides a structure for watching data changes using a provided watch method. This class is designed to handle real-time data updates by subscribing to a stream and emitting different states such as `BloweInProgress`, `BloweCompleted<T>`, and `BloweError` based on the data changes.

#### Example

```dart
class MyBloweWatchBloc extends BloweWatchBloc<String, BloweNoParams> {
  @override
  Stream<String> watch(BloweNoParams params) => Stream<String>.periodic(
        const Duration(seconds: 2),
        (count) => 'Blowe Watch Bloc Update $count',
      );
}
```

### BlowePaginationBloc

**BlowePaginationBloc** is an abstract class that extends `BloweBloc` and provides a structure for handling paginated data using a provided load method. This class is designed to handle data fetching operations in a paginated manner, emitting different states such as `BloweInProgress`, `BloweCompleted<T>`, and `BloweError` based on the result of the data loading process.

#### Example

```dart
class MyBlowePaginationBloc
    extends BlowePaginationBloc<MyPaginationModel, BloweNoParams> {
  @override
  Future<MyPaginationModel> load(BloweNoParams params, int page) =>
      Future<MyPaginationModel>.delayed(
        const Duration(seconds: 2),
        () => MyPaginationModel(data: List.generate(10, (index) => 'Item $index')),
      );
}

class MyPaginationModel extends BlowePaginationModel<String> {
  MyPaginationModel({required List<String> data}) : super(data: data);
}
```

## Blowe Logic Widgets

### BloweBlocSelector

**BloweBlocSelector** is a widget that uses a `BlocSelector` to determine if the widget should be enabled. It rebuilds based on the state of the specified `BloweBloc`.

#### Example

```dart
BloweBlocSelector<MyBloweBloc>(
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
)
```

### BloweMultiBlocSelector

**BloweMultiBlocSelector** is a widget that monitors multiple `BloweBlocs` and determines if the widget should be enabled based on the state of all provided `BloweBlocs`.

#### Example

```dart
BloweMultiBlocSelector(
  blocs: [
    MyBloweBloc1(),
    MyBloweBloc2(),
  ];,
  builder: (context, enabled) {
    return FloatingActionButton(
      onPressed: enabled
          ? () {
              // Your action here
            }
          : null,
      child: const Icon(Icons.add),
    );
  },
)
```

### BloweBlocListener

**BloweBlocListener** is a widget that listens to the state changes of a `BloweBloc` and triggers the corresponding callback functions for each state type.

#### Example

```dart
BloweBlocListener<MyBloweBloc, String>(
  onCompleted: (context, state) {
    // Handle completed state
  },
  onError: (context, state) {
    // Handle error state
  },
  onLoading: (context, state) {
    // Handle loading state
  },
  onInitial: (context, state) {
    // Handle initial state
  },
  child: const MyChildWidget(),
)
```

### BloweBlocButton

**BloweBlocButton** is a button widget that uses a `BloweBloc` to determine if the button should be enabled. It rebuilds based on the state of the specified `BloweBloc`.

#### Example

```dart
BloweBlocButton<MyBloweLoadBloc, ElevatedButton>(
  text: 'Load Data',
  onPressed: () {
    context.read<MyBloweLoadBloc>().add(
          const BloweFetch(BloweNoParams()),
        );
  },
)
```

### BlowePaginationListView

**BlowePaginationListView** is a widget that displays a paginated list of items using a `BlowePaginationBloc`. It handles loading, error, and completed states of the `BlowePaginationBloc`, providing a seamless pagination experience. This widget supports filtering, grouping, and pull-to-refresh functionality.

#### Example

```dart
BlowePaginationListView<MyBlowePaginationBloc, MyItem, MyParams, MyGroup>(
  itemBuilder: (context, item) => ListTile(
    title: Text(item.name),
  ),
  paramsProvider: () => MyParams(),
  emptyWidget: Center(child: Text('No items found')),
  padding: EdgeInsets.all(8.0),
  filter: (item) => item.isVisible,
  groupBy: (item) => item.category,
  groupHeaderBuilder: (context, group, items) => Padding(
    padding: EdgeInsets.all(8.0),
    child: Text('Category: $group', style: TextStyle(fontSize: 18)),
  ),
)
```

## Blowe Form Widgets

### BloweTextFormField

A text form field widget that supports optional obscuring of text, custom validation, and custom icons. This widget is designed to be extended for creating specialized text form fields with unique properties, allowing for dynamic customization and validation within a form.

#### Example

```dart
class EmailTextFormField extends BloweTextFormField {
  EmailTextFormField({
    super.key,
    super.controller,
    super.enabled,
    super.onEditingComplete,
    super.textInputAction,
  }) : super(
          validator: (context, value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
          keyboardType: TextInputType.emailAddress,
          labelText: (context) => 'Email',
        );
}

// Usage example in a form
final _emailController = TextEditingController();

EmailTextFormField(
  controller: _emailController,
  enabled: true,
  onEditingComplete: () {
    // Handle the editing complete action
  },
  textInputAction: TextInputAction.next,
)
```

### BloweDropdownButtonFormField

A dropdown button form field widget that allows customization of the dropdown items, icon, suffix icon, label text, and validator. This widget is designed to be extended for creating specialized dropdown form fields with unique properties, enabling dynamic customization and validation within a form.

#### Example

```dart
class CountryDropdownButtonFormField extends BloweDropdownButtonFormField<String> {
  CountryDropdownButtonFormField({
    super.key,
    required List<String> countries,
    required ValueChanged<String?> onChanged,
    String? initialValue,
  }) : super(
          items: countries,
          onChanged: onChanged,
          itemBuilder: (context, country) => DropdownMenuItem(
            value: country,
            child: Text(country),
          ),
          labelText: (context) => 'Country',
          value: initialValue,
        );
}

// Usage example in a form
final _selectedCountry = 'Argentina';

CountryDropdownButtonFormField(
  countries: ['USA', 'Canada', 'Mexico', 'Argentina'],
  onChanged: (value) {
    setState(() =>_selectedCountry = value);
  },
  initialValue: _selectedCountry,
)
```

### BloweBoolFormListTile

A form field widget that wraps a `SwitchListTile` or `CheckboxListTile`. The `BloweBoolFormListTile` widget provides a way to use a switch or checkbox within a form, utilizing a `BloweBoolFormController` to manage its state. This widget supports customization of the switch's or checkbox's appearance and behavior, including validation, enabling/disabling, and visual styling.

#### Example

```dart
final _controller = BloweBoolFormController(initialValue: true);

BloweBoolFormListTile(
  controller: _controller,
  title: (context) => 'Enable notifications',
  type: BloweBoolListTileType.switchTile,
);
```

### BloweRadiusForm

A form field widget that manages a list of radius list tiles. The `BloweRadiusForm` widget provides a way to manage a list of radius list tiles within a form, utilizing a `BloweRadiusFormController` to manage its state. This widget supports customization of the appearance and behavior, including validation, enabling/disabling, and visual styling.

#### Example

```dart
final _controller = BloweRadiusFormController<int>(initialValue: 1);

BloweRadiusForm<int>(
  controller: _controller,
  items: [1, 2, 3],
  titleBuilder: (context, item) => 'Item: $item',
  validator: (context, value) {
    if (value == null) {
      return 'Please select an item.';
    }
    return null;
  },
);
```

## Blowe Models

### BloweNoParams

**BloweNoParams** is a simple class that represents a scenario where no parameters are required. This can be used in situations where an operation or function does not need any input parameters.

#### Example

```dart
const params = BloweNoParams();

// Use BloweNoParams in an operation that doesn't require parameters.
myBloc.add(BloweFetch(params));
```

### BlowePaginationModel

**BlowePaginationModel** is a class designed to handle paginated data. It provides a structure to manage items of type `T` along with the total count of items. This model is typically used in conjunction with `BlowePaginationBloc` to manage pagination logic in your application.

#### Example

```dart
class NoteModel {
  // Define your NoteModel properties and methods here.
  NoteModel.fromJson(Map<String, dynamic> json) {
    // Parse the JSON to initialize NoteModel properties.
  }
}

class NotesPaginationModel extends BlowePaginationModel<NoteModel> {
  const NotesPaginationModel({
    required super.totalCount,
    required super.items,
  });

  factory NotesPaginationModel.fromJson(List<Map<String, dynamic>> json) {
    final items = json.map(NoteModel.fromJson).toList();

    return NotesPaginationModel(
      totalCount: items.length,
      items: items,
    );
  }
}
```

## Author

Developed by [Santiago Gonzalez Fernandez](https://www.linkedin.com/in/santiagogonzalezblowe/).
