class CategoryEntity {
  final String id;
  final String name;

  CategoryEntity({required this.id, required this.name});

  factory CategoryEntity.fromJson(Map<String, dynamic> json) {
    return CategoryEntity(id: json["id"].toString(), name: json["name"]);
  }
}
