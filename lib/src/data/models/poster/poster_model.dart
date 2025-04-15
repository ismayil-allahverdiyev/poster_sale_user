import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

PosterModel posterModelFromJson(String str) =>
    PosterModel.fromJson(json.decode(str));

String posterModelToJson(PosterModel data) => json.encode(data.toJson());

class PosterModel {
  String id;
  String title;
  String description;
  double price;
  DateTime startDate;
  DateTime endDate;
  DateTime createdAt;
  int color;
  String categoryId;
  List<String> images;

  PosterModel({
    required this.id,
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

  factory PosterModel.fromJson(Map<String, dynamic> json) {
    return PosterModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      price: json["price"]?.toDouble(),
      startDate: DateTime.fromMillisecondsSinceEpoch(
          (json["start_date"] as Timestamp).millisecondsSinceEpoch),
      endDate: DateTime.fromMillisecondsSinceEpoch(
          (json["end_date"] as Timestamp).millisecondsSinceEpoch),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          (json["created_at"] as Timestamp).millisecondsSinceEpoch),
      color: json["color"],
      categoryId: json["category_id"],
      images: List<String>.from(json["images"].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
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
