## 0.4.7

### Improvements

- **BlowePaginationListView**:
  - Added a new `threshold` property to give users control over when the next page should start loading.
  - This property allows specifying the scroll offset (in pixels) before the end of the list to trigger the loading of the next page, providing greater flexibility for pagination behavior.

### Bug Fixes

- **Documentation**:
  - Resolved a warning from `pub.dev` related to the use of angle brackets (`< >`) in comments.

### Dependency Update

- **Flutter Bloc**:
  - Upgraded the `flutter_bloc` dependency to **9.0.0** to maintain compatibility with the latest updates in the Flutter ecosystem and ensure continued support for new features and improvements.

## 0.4.6

### Improvements

- **BloweTextFormField**:
  - Added a new `textCapitalization` property to `BloweTextFormField`, allowing control over how text input is capitalized (e.g., sentences, words, or all characters).
  - This enhancement provides greater flexibility when handling user text input, aligning with common form requirements.

### Flutter Update

- **Flutter Version**:
  - Updated the Flutter SDK dependency from **3.24.0** to **3.27.0**.
  - This update ensures compatibility with the latest Flutter features, performance improvements, and bug fixes introduced in version 3.27.0.

## 0.4.5

### Improvements

- **BloweDropdownButtonFormField**:
  - Added a new `selectedItemBuilder` property to allow custom display of a selected item.
  - This property enables the customization of how the selected item is displayed, providing more flexibility for use cases where the default dropdown appearance doesn't suffice.

### Bug Fixes

- **BloweBoolFormListTile**:
  - Fixed an issue with `CheckBoxListTile` and `SwitchListTile` validation where the value passed to the validator did not reflect the actual current state.
  - Now, the validator correctly uses the latest value of the boolean form field, ensuring proper validation for form submissions.

## 0.4.4

### Improvements

- **BlowePaginationListView**:
  - Refactored internal logic to simplify the creation and management of items in the list.
  - Introduced a unified `_buildItems` method to generate the complete list of widgets, streamlining the process and improving readability.
  - Removed the `_GroupHeader` class, integrating group headers directly into the list generation.
  - Improved performance and code maintainability by reducing complexity in item retrieval and rendering.

## 0.4.3

### Improvements

- **BloweTextFormField**:

  - Added support for the `autofillHints` property, allowing for better integration with autofill services. This makes it easier for users to autofill text fields such as emails, usernames, and passwords.

- **BloweNumberFormListTile**:
  - Introduced the `numberStyle` property, allowing users to customize the text style of the displayed number. This includes options to change the font, size, and color of the number text.
  - When the widget is disabled, the number text now properly reflects the disabled state, ensuring that it matches the rest of the component visually.

### Bug Fixes

- **BloweMultiBlocSelector**:
  - Fixed an issue where the initial state of the widget did not enable correctly. This was due to the lack of an initial value being emitted. The widget now emits the correct state upon initialization, ensuring that the widget's enabled state is accurate from the beginning.

## 0.4.2

### New Features

- **BlowePaginationListView**:

  - Added `startWidget` and `endWidget` support:
    - `startWidget`: This optional widget is displayed at the beginning of the list (index 0).
    - `endWidget`: This optional widget is displayed at the end of the list, before the `LinearProgressIndicator` when pagination is in progress.
  - These widgets allow for greater flexibility in adding custom elements to the beginning or end of the paginated list, improving the ability to customize the user interface.

## 0.4.1

### Improvements

- **BloweBloc**:

  - Introduced convenience methods for executing key events (`fetch`, `fetchMore`, `updateData`, `reset`) directly on the bloc. This enhances usability by allowing users to call these actions without manually emitting events.

- **BloweSearchBloc**:

  - Added methods for simplified search history management:
    - `addSearchHistory`: Adds an item to the search history.
    - `removeSearchHistory`: Removes an item from the search history.
    - `clearSearchHistory`: Clears the entire search history.
    - `loadSearchHistory`: Loads search history from persistent storage.
  - These methods streamline event handling for search history without manually emitting events.

- **BloweNumberFormListTile**:
  - Improved styling: The title now properly reflects the disabled state, ensuring visual consistency when the widget is disabled.

### BloweWidgets Update

- Several `BloweWidgets` have been updated to integrate the new event-handling improvements from `BloweBlocs`. These changes improve ease of use and maintain consistency across widgets.

## 0.4.0

### New Features

- **BloweNumberFormListTile**: Added a new form field widget featuring a number selector with increment (+) and decrement (-) buttons on the right side.

  - Supports custom validation and state management with `BloweNumberFormController`.
  - Follows the same structure and customizable properties as other `BloweFormListTile` widgets.

- **BloweBoolFormListTile**:

  - Added support for adaptive behavior (`SwitchListTile.adaptive` and `CheckboxListTile.adaptive`), making the widget compatible with both iOS and Android platforms.
  - Improved controller-based state handling to ensure consistency between the UI and the internal state.

- **BloweTextFormField**:
  - Added support for multi-line input.
  - The widget now allows customization of the keyboard type and input actions to support text input across multiple lines, providing more flexibility in forms.

### Improvements

- **BloweBoolFormListTile**:
  - Enhanced the appearance and functionality of the `BloweBoolFormListTile`, allowing it to work with adaptive controls for both iOS and Android.
  - Improved state management for better control over the widget’s state during form interactions.

## 0.3.1

### Bug Fixes

- **Dropdown Overflow**: Fixed an issue in the `BloweDropdownButtonFormField` where long text in dropdown items could cause overflow. Added `isExpanded: true` to ensure proper text handling and prevent layout issues.

### Dependency Updates

- **Shared Preferences**: Updated `shared_preferences` from `^2.2.3` to `^2.3.2`.
- **SDK Version**: Updated the Dart SDK constraint from `">=2.17.0 <4.0.0"` to `">=3.4.0 <4.0.0"`.

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
