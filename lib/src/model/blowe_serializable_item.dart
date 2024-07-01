import 'package:equatable/equatable.dart';

/// A base class that requires implementing classes to have
/// `toJson` and `fromJson` methods for serialization.
abstract class BloweSerializableItem extends Equatable {
  /// Converts the implementing class to a JSON-compatible map.
  Map<String, dynamic> toJson();

  /// Creates an instance of the implementing class from a JSON-compatible map.
  BloweSerializableItem fromJson(Map<String, dynamic> json);

  @override
  List<Object?> get props => [];
}
