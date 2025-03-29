import 'dart:convert';

AddPosterModel addPosterModelFromJson(String str) =>
    AddPosterModel.fromJson(json.decode(str));

String addPosterModelToJson(AddPosterModel data) => json.encode(data.toJson());

class AddPosterModel {
  String title;
  String description;
  double price;
  DateTime startDate;
  DateTime endDate;
  DateTime createdAt;
  int color;
  String categoryId;
  List<String> images;

  AddPosterModel({
    required this.title,
    required this.description,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.color,
    required this.categoryId,
    required this.images,
  });

  factory AddPosterModel.fromJson(Map<String, dynamic> json) => AddPosterModel(
        title: json["title"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        color: json["color"],
        categoryId: json["category_id"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "price": price,
        "start_date": startDate,
        "end_date": endDate,
        "created_at": createdAt,
        "color": color,
        "category_id": categoryId,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
