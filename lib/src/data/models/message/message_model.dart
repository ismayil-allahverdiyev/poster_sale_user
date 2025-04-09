// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  String senderId;
  String text;
  Timestamp timestamp;
  bool read;

  MessageModel({
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.read,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        senderId: json["senderId"],
        text: json["text"],
        timestamp: json["timestamp"],
        read: json["read"],
      );

  Map<String, dynamic> toJson() => {
        "senderId": senderId,
        "text": text,
        "timestamp": timestamp,
        "read": read,
      };
}
