import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

BasketModel basketModelFromJson(String str) =>
    BasketModel.fromJson(json.decode(str));

String basketModelToJson(BasketModel data) => json.encode(data.toJson());

class BasketModel {
  String id;
  Timestamp created;
  BasketState state;
  String userId;

  BasketModel({
    required this.id,
    required this.created,
    required this.state,
    required this.userId,
  });

  factory BasketModel.fromJson(Map<String, dynamic> json) => BasketModel(
        id: json["id"] ?? "",
        created: json["created"] ?? Timestamp.now(),
        state: BasketState.values[json["state"] ?? 0],
        userId: json["userId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created": created,
        "state": state.index,
        "userId": userId,
      };

  Map<String, dynamic> toAddJson() => {
        "created": created,
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
