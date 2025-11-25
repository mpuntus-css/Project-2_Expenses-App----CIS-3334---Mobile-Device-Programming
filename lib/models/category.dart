/// Represents a category for expenses.
class Category {
  /// The name of the category.
  final String name;

  /// The icon representing the category.
  final String icon;

  /// Constructs a [Category] with the given [name] and [icon].
  Category({
    required this.name,
    required this.icon,
  });

  /// Converts the [Category] to a map for serialization.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon,
    };
  }

  /// Creates a [Category] instance from a map.
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'],
      icon: map['icon'],
    );
  }
}
