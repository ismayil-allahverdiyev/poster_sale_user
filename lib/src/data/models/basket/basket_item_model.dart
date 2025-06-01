import 'dart:convert';

import '../poster/poster_model.dart';

BasketItemModel basketItemModelFromJson(String str) =>
    BasketItemModel.fromJson(json.decode(str));

String basketItemModelToJson(BasketItemModel data) =>
    json.encode(data.toJson());

class BasketItemModel {
  String id;
  double addedPrice;
  String description;
  String image;
  String title;

  BasketItemModel({
    this.id = "",
    required this.addedPrice,
    required this.description,
    required this.image,
    required this.title,
  });

  factory BasketItemModel.fromPoster({required PosterModel poster}) =>
      BasketItemModel(
        id: poster.id,
        addedPrice: poster.price,
        description: poster.description,
        image: poster.images[0],
        title: poster.title,
      );

  factory BasketItemModel.fromJson(Map<String, dynamic> json) =>
      BasketItemModel(
        id: json["id"] ?? "",
        addedPrice: (json["added_price"] ?? 0).toDouble(),
        description: json["description"] ?? "",
        image: json["image"] ?? "",
        title: json["title"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "added_price": addedPrice,
        "description": description,
        "image": image,
        "title": title,
      };
}
