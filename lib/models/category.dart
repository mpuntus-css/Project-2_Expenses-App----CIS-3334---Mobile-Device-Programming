class Category {
  final String name;
  final String icon;

  Category({
    required this.name,
    required this.icon,
  });

  // For future use: Convert Category to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon,
    };
  }

  // For future use: Create Category from a map
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'],
      icon: map['icon'],
    );
  }
}
