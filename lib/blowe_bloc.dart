/// The `blowe_bloc` library provides a collection of
/// BLoC (Business Logic Component) classes, models, and widgets
/// to manage state and business logic in Flutter applications.
///
/// This library is built on top of the `flutter_bloc` package
/// and extends its functionality by providing additional BLoC
/// classes for loading, pagination, and watching data streams.
/// It also includes models for handling pagination and a variety
/// of widgets to easily integrate with the BLoC architecture.
///
/// ## Dependencies
///
/// The library depends on the `flutter_bloc` package for BLoC functionality.
///
/// ## Blowe Bloc
///
/// The core classes for managing state and business logic are located in the `src/logic`
/// directory. These include base classes for BLoC, events, and states,
/// as well as specialized BLoC classes for loading, pagination,
/// and watching data streams.
///
/// ## Models
///
/// The `src/model` directory contains models used by the BLoC classes, such as `BloweNoParams`
/// for representing no parameters and `BlowePaginationModel` for handling
/// paginated data.
///
/// ## Widgets
///
/// The `src/widget` directory includes various widgets that work with the BLoC classes to
/// provide UI components that react to state changes. These widgets include
/// buttons, listeners, dropdowns, list views, and text form fields.
/// Additionally, the `selector` subdirectory contains widgets for
/// selecting and managing multiple BLoC instances.
library blowe_bloc;

// Dependencies
export 'package:flutter_bloc/flutter_bloc.dart';

// Blowe Bloc
export './src/logic/base/blowe_bloc.dart';
export './src/logic/base/blowe_event.dart';
export './src/logic/base/blowe_state.dart';
export './src/logic/blowe_load_bloc.dart';
export './src/logic/blowe_pagination_bloc.dart';
export './src/logic/blowe_watch_bloc.dart';
// Models
export './src/model/blowe_no_params.dart';
export './src/model/blowe_pagination_model.dart';
// Widgets
export './src/widget/blowe_bloc_button.dart';
export './src/widget/blowe_bloc_listener.dart';
export './src/widget/blowe_dropdown_button_form_field.dart';
export './src/widget/blowe_pagination_list_view.dart';
export './src/widget/form/blowe_text_form_field.dart';
export './src/widget/form/form_error_text.dart';
export './src/widget/form/switch/blowe_switch_form_list_tile.dart';
export './src/widget/selector/blowe_bloc_selector.dart';
export './src/widget/selector/blowe_multi_bloc_selector.dart';
