/// Class representing a pagination model.
/// This class is used to handle paginated data.
class BlowePaginationModel<T> {
  /// Creates an instance of BlowePaginationModel.
  ///
  /// - [items]: The list of items of type T.
  /// - [totalCount]: The total count of items.
  const BlowePaginationModel({
    required this.items,
    required this.totalCount,
  });

  /// The list of items of type T.
  final List<T> items;

  /// The total count of items.
  final int totalCount;
}
