import 'package:equatable/equatable.dart';

/// Base class for search parameters that includes a `query` field.
///
/// This class provides a basic structure for search parameters in the
/// application, allowing any specific search parameter to extend this base
/// class.
/// The class is immutable and extends [Equatable] for easy comparisons and
/// testing.
abstract class BloweSearchParams extends Equatable {
  /// Creates an instance of [BloweSearchParams].
  ///
  /// - [query]: The search term.
  const BloweSearchParams(this.query);

  /// The search term.
  final String query;

  @override
  List<Object> get props => [query];
}
