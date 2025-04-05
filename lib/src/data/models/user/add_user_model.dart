import 'dart:convert';

AddUserModel addUserModelFromJson(String str) =>
    AddUserModel.fromJson(json.decode(str));

String addUserModelToJson(AddUserModel data) => json.encode(data.toJson());

class AddUserModel {
  String id;
  String email;
  String name;
  DateTime timestamp;

  AddUserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.timestamp,
  });

  factory AddUserModel.fromJson(Map<String, dynamic> json) => AddUserModel(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "timestamp": timestamp,
      };
}
