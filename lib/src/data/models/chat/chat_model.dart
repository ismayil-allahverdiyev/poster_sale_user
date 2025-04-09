import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  String customerId;
  String productId;
  String lastMessage;
  Timestamp timestamp;
  bool read;

  ChatModel({
    required this.customerId,
    required this.productId,
    required this.lastMessage,
    required this.timestamp,
    required this.read,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        customerId: json["customerId"],
        productId: json["productId"],
        lastMessage: json["lastMessage"],
        timestamp: json["timestamp"],
        read: json["read"],
      );

  Map<String, dynamic> toJson() => {
        "customerId": customerId,
        "productId": productId,
        "lastMessage": lastMessage,
        "timestamp": timestamp,
        "read": read,
      };
}
