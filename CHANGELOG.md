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
