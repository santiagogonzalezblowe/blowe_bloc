## 0.3.0

### New Features

- **BloweSearchBloc**: A new bloc for handling paginated data along with managing a search history.
- **BloweSearchEvent**: Events specific to the BloweSearchBloc including adding, removing, and clearing search history.
- **BloweSearchDelegate**: A new delegate for searching with automatic history management and debounce support.
- **BloweSerializableItem**: A base class requiring implementing classes to have a `toJson` method for serialization.
- **BloweSearchParams**: A base class for search parameters that includes a `query` field.

### Improvements

- **BlowePaginationListView**:
  - Now only triggers `loadMore` when scrolling down.
  - Added the `shrinkWrap` property to optionally wrap the list view's contents.

### Example Application

- **Example Application Update**: Added a new example in the `example` app demonstrating the usage of `BloweSearchBloc` and `BloweSearchDelegate`.
  - The example includes setup for `BookSearchBloc` and integration with `BloweSearchDelegate` to showcase search functionality with history management and debounce.

## 0.2.6

### New Features

- **Error Widget**: Added custom error widget support in `BlowePaginationListView` using `errorBuilder`.
- **On Refresh Enable**: Added the `onRefreshEnabled` parameter to `BlowePaginationListView` to control the visibility of the refresh indicator.

## 0.2.5

### Bug Fixes

- **BlowePaginationListView**: Fixed an issue where the ScrollController was not updating on Android devices by implementing `BouncingScrollPhysics` with `AlwaysScrollableScrollPhysics` as the parent. This change ensures consistent scroll behavior and accurate pagination across both Android and iOS platforms.

## 0.2.4

### Bug Fixes

- **BlowePaginationListView**:

  - Fixed an issue where applying filters to the paginated list caused incorrect pagination behavior. The problem was due to the filtered item count not matching the total item count, leading to unnecessary fetches for more pages.
  - Added a `filteredData` parameter to `_BlowePaginationListViewLoaded` to handle filtered items separately.
  - Adjusted pagination control logic to use `filteredData` for determining item count.
  - Updated scroll controller listener to prevent additional fetches when all items are loaded.
  - Improved handling of group headers and empty state in the paginated list.

### Example App

- Fixed issues in the `books_repository` of the example project to ensure proper functionality and to reflect the latest updates in the `BlowePaginationListView`.

## 0.2.3

### New Features

- **README and Documentation Updates**: Enhanced README with detailed descriptions, examples, and structured sections for Blowe Logic, Blowe Widgets, and Blowe Models.
  - Added descriptions and examples for `BloweLoadBloc`, `BloweWatchBloc`, `BlowePaginationBloc`.
  - Added descriptions and examples for `BloweBlocSelector`, `BloweMultiBlocSelector`, `BloweBlocListener`, `BloweBlocButton`, `BlowePaginationListView`, `BloweTextFormField`, `BloweDropdownButtonFormField`, `BloweBoolFormListTile`, `BloweRadiusForm`.
  - Included detailed usage examples and explanations for each widget and model.

### Improvements

- **BloweRadiusForm Documentation**: Updated the internal documentation of `BloweRadiusForm` to reflect changes and provide a clearer example.
- **README Enhancement**: The README now includes a structured and comprehensive description of the package, along with examples for each component.
- **Pagination Logic Fix**: Addressed an issue in `BlowePaginationListView` where backend calls were being made too frequently with large `maxScrollExtent` values. Now, backend calls are triggered when the scroll position is within 200 pixels from the bottom, ensuring consistent behavior regardless of content size.
- **Example Application**: Added a new example application in the `example` folder demonstrating the usage of various components in the `blowe_bloc` package.
  - The example includes setup for `NotesLoadBloc`, `NotesWatchBloc`, and `NotesPaginationBloc`, along with corresponding models and form widgets.

### Bug Fixes

- **Pagination Trigger Issue**: Fixed the issue where backend calls in `BlowePaginationListView` were being made too frequently as the `maxScrollExtent` increased. The new implementation ensures calls are made consistently 200 pixels from the bottom.

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
