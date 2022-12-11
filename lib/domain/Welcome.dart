import 'Category.dart';

class Welcome {
  List<Welcome> welcomes = [];

  Welcome({
    required this.category,
    required this.name,
    required this.details,
    required this.size,
    required this.colour,
    required this.price,
    required this.mainImage,
    required this.id,
  });

  Category category;
  String name;
  String details;
  String size;
  String colour;
  int price;
  String mainImage;
  int id;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    category: Category.fromJson(json["category"]),
    name: json["name"],
    details: json["details"],
    size: json["size"],
    colour: json["colour"],
    price: json["price"],
    mainImage: json["main_image"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "category": category.toJson(),
    "name": name,
    "details": details,
    "size": size,
    "colour": colour,
    "price": price,
    "main_image": mainImage,
    "id": id,
  };
}

class Welcomes {
  List<Welcome> welcomes = [];

  Welcomes({required this.welcomes});

  Welcomes.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      welcomes = <Welcome>[];
      json['results'].forEach((v) {
        welcomes.add(Welcome.fromJson(v));
      });
    }
  }
}