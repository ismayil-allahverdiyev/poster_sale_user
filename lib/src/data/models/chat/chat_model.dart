import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  String id;
  String customerId;
  String productId;
  String productImage;
  String productTitle;
  String lastMessage;
  Timestamp timestamp;
  bool read;
  ChatStatus chatStatus;

  ChatModel({
    required this.id,
    required this.customerId,
    required this.productId,
    required this.productImage,
    required this.productTitle,
    required this.lastMessage,
    required this.timestamp,
    required this.read,
    required this.chatStatus,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json["id"] ?? "",
        customerId: json["customerId"],
        productId: json["productId"],
        productImage: json["productImage"],
        productTitle: json["productTitle"],
        lastMessage: json["lastMessage"],
        timestamp: json["timestamp"],
        read: json["read"],
        chatStatus: ChatStatus.values[json["chatStatus"]],
      );

  Map<String, dynamic> toJson() => {
        "customerId": customerId,
        "productId": productId,
        "productImage": productImage,
        "productTitle": productTitle,
        "lastMessage": lastMessage,
        "timestamp": timestamp,
        "read": read,
        "chatStatus": chatStatus.index,
      };
}

enum ChatStatus {
  normal,
  timeout,
  blocked,
}
