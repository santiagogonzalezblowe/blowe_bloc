import 'package:equatable/equatable.dart';

/// A base class that requires implementing classes to have
/// a `toJson` method for serialization.
abstract class BloweSerializableItem extends Equatable {
  /// Converts the implementing class to a JSON-compatible map.
  Map<String, dynamic> toJson();

  @override
  List<Object?> get props => [];
}
