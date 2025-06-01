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
  bool readByAdmin;
  ChatStatus chatStatus;
  ChatType chatType = ChatType.general; // Default value, can be changed later

  ChatModel({
    required this.id,
    required this.customerId,
    required this.productId,
    required this.productImage,
    required this.productTitle,
    required this.lastMessage,
    required this.timestamp,
    required this.read,
    required this.readByAdmin,
    required this.chatStatus,
    this.chatType = ChatType.general,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json["id"] ?? "",
        customerId: json["customerId"],
        productId: json["productId"],
        productImage: json["productImage"],
        productTitle: json["productTitle"],
        lastMessage: json["lastMessage"],
        timestamp: json["timestamp"],
        read: json["read"] ?? false,
        readByAdmin: json["readByAdmin"] ?? false,
        chatStatus: ChatStatus.values[0 - json["chatStatus"] as int],
        chatType: ChatType.values[json["chatType"] ?? 0],
      );

  Map<String, dynamic> toJson() => {
        "customerId": customerId,
        "productId": productId,
        "productImage": productImage,
        "productTitle": productTitle,
        "lastMessage": lastMessage,
        "timestamp": timestamp,
        "read": read,
        "readByAdmin": readByAdmin,
        "chatStatus": chatStatus.index,
        "chatType": chatType.index,
      };
}

enum ChatStatus {
  normal,
  timeout,
  blocked,
}

enum ChatType {
  general,
  basket,
}
