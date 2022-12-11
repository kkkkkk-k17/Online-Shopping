class Category {
  Category({
    required this.name,
    required this.icon,
    required this.id,
  });

  String name;
  String icon;
  int id;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"],
    icon: json["icon"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "icon": icon,
    "id": id,
  };
}