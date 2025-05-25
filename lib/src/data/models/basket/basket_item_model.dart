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
  String productId;
  String title;

  BasketItemModel({
    this.id = "",
    required this.addedPrice,
    required this.description,
    required this.image,
    required this.productId,
    required this.title,
  });

  factory BasketItemModel.fromPoster({required PosterModel poster}) =>
      BasketItemModel(
        id: poster.id,
        addedPrice: poster.price,
        description: poster.description,
        image: poster.images[0],
        productId: poster.id,
        title: poster.title,
      );

  factory BasketItemModel.fromJson(Map<String, dynamic> json) =>
      BasketItemModel(
        id: json["id"] ?? "",
        addedPrice: (json["added_price"] ?? 0).toDouble(),
        description: json["description"] ?? "",
        image: json["image"] ?? "",
        productId: json["productid"] ?? "",
        title: json["title"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "added_price": addedPrice,
        "description": description,
        "image": image,
        "productid": productId,
        "title": title,
      };
}
