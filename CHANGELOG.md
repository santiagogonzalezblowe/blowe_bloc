## 0.2.2

### New Features

- **BloweRadiusForm**: Introduced a new form field widget that manages a list of radio list tiles within a form, providing an easy way to handle single selection inputs.
- **BloweRadiusFormController**: Added a new controller to manage the state of the selected item in the `BloweRadiusForm`.
- **Toggleable**: Added `toggleable` property to `RadioListTile` within the form to allow deselecting items.
- **Dynamic Shape Handling**: Improved shape handling to dynamically reflect error and disabled states, providing better visual feedback to users.

### Improvements

- Improved documentation and examples to include the new `BloweRadiusForm` widget and its usage.
- Enhanced user experience with better visual feedback through dynamic shape adjustments based on form state.

## 0.2.1

### New Features

- **BloweBoolFormListTile**: Introduced a new form field widget that can be used as either a `SwitchListTile` or a `CheckboxListTile`, providing a unified interface for boolean form controls.
- **BloweBoolFormController**: Added a new controller to manage the state of boolean form controls.
- **BloweBoolListTileType**: Created an enum to specify the type of ListTile (`switchTile` or `checkboxTile`), allowing dynamic rendering of the tile type.
- **Customization**: Added support for dynamic title and validator functions to enhance customization and validation capabilities.

### Improvements

- Improved documentation and code comments for better clarity and maintainability.

## 0.2.0

- Added `hintText` property to `BloweTextFormField` to display a hint when the text field is empty, with access to the widget's context.
- Added `inputFormatters` property to `BloweTextFormField` to allow for custom input formatting.
- Updated the constructor documentation to include the new properties.
- Ensured the new properties are used in the build method of the text form field.

## 0.1.9

- Added `context` parameter to `onTap` callback in `BloweTextFormField` to provide access to the widget's context.
- Added `prefixIcon` property to `BloweTextFormField` to allow for custom prefix icons.
- Updated the constructor documentation to include the new properties.
- Ensured the new properties are used in the build method of the text form field.

## 0.1.8

- Added `onTap` property to `BloweTextFormField` to allow for custom tap handling.
- Updated the constructor documentation to include the new `onTap` property.
- Ensured the new property is used in the build method of the text form field.

## 0.1.7

- Added `initialValue` property to `BloweTextFormField` to set the initial value of the text field.
- Added `readOnly` property to `BloweTextFormField` to indicate if the text field is read-only.
- Updated the constructor documentation to include the new properties.
- Ensured the new properties are used in the build method of the text form field.

## 0.1.6

- Added the ability to group items in BlowePaginationListView using a custom `groupBy` function.
- Introduced `BloweGroupHeaderBuilder` to create custom group headers with access to the list of items in each group.
- Ensured that grouped items are correctly displayed with headers and that the list remains scrollable.
- Added an assert to ensure `groupBy` and `groupHeaderBuilder` are provided together for clearer error messages.
- Updated the README.md to reflect the new version number 0.1.6.

## 0.1.5

- Added the ability to pass a custom filter function to dynamically filter items in BlowePaginationListView.
- Updated the constructor to accept an optional filter parameter.
- Applied the filter to the items before displaying them.
- Ensured that the filtering works seamlessly with the existing onRefresh functionality.
- Made BlowePaginationModel non-abstract to allow instantiation.
- Added the ability to pass an `emptyWidget` to display when the list is empty.
- Wrapped the `emptyWidget` in a `RefreshIndicator` to allow onRefresh functionality even when the list is empty.
- Updated documentation and examples to reflect these changes.

## 0.1.4

- Added the ability to pass dynamic parameters for the `onRefresh` and `Retry` actions in `BlowePaginationListView`.
- Fixed issue with the last item in the list being inside a column, causing visual inconsistencies.
- Ensured the list is always scrollable, even when the items do not fill the screen, to allow for `onRefresh` functionality.

## 0.1.3

- Update `README.md` version

## 0.1.2

- Update `README.md` code example

## 0.1.1

- Added an example demonstrating the usage of `blowe_bloc` in a Flutter application.

## 0.1.0

- Initial release of `blowe_bloc`.
- Added advanced BLoC components including `BloweLoadBloc`, `BlowePaginationBloc`, and `BloweWatchBloc`.
- Included models for handling no parameters (`BloweNoParams`) and pagination (`BlowePaginationModel`).
- Provided a variety of reactive widgets such as `BloweBlocButton`, `BloweBlocListener`, `BloweDropdownButtonFormField`, `BlowePaginationListView`, and `BloweTextFormField`.
- Added selector widgets `BloweBlocSelector` and `BloweMultiBlocSelector` for monitoring BLoC states.
