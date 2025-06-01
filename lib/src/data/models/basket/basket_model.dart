import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poster_sale_user/src/data/models/basket/basket_item_model.dart';

BasketModel basketModelFromJson(String str) =>
    BasketModel.fromJson(json.decode(str));

String basketModelToJson(BasketModel data) => json.encode(data.toJson());

class BasketModel {
  String id;
  Timestamp updated_at;
  BasketState state;
  String userId;
  List<BasketItemModel> items = [];

  BasketModel({
    required this.id,
    required this.updated_at,
    required this.state,
    required this.userId,
    this.items = const [],
  });

  factory BasketModel.fromJson(Map<String, dynamic> json) => BasketModel(
        id: json["id"] ?? "",
        updated_at: json["updated_at"] ?? Timestamp.now(),
        state: BasketState.values[json["state"] ?? 0],
        userId: json["userId"] ?? "",
        items: (json["items"] as List<dynamic>?)
                ?.map((item) => BasketItemModel.fromJson(item))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "updated_at": updated_at,
        "state": state.index,
        "userId": userId,
        "items": items.map((item) => item.toJson()).toList(),
      };

  Map<String, dynamic> toAddJson() => {
        "updated_at": updated_at,
        "state": state.index,
        "userId": userId,
      };
}

enum BasketState {
  active,
  ordered,
  finalized,
  canceled,
}
