import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/data/models/message/message_model.dart';
import '../../data/models/poster/poster_model.dart';
import '../../data/repository/repository.dart';

class MessagesDetailedController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Repository repository;
  MessagesDetailedController({required this.repository});

  @override
  onInit() async {
    super.onInit();
    posterId.value = Get.parameters["posterId"];
    chatId.value = Get.parameters["chatId"];
    userId.value = repository.getUserId();

    if (checkNullability()) {
      return;
    }

    await getPoster();
    await getMessages();
  }

  // Controllers
  var tabController = Rxn<TabController>();
  TextEditingController messageController = TextEditingController();

  // **********************************

  // Variables
  var posterId = Rxn<String>();
  var chatId = Rxn<String>();
  var userId = Rxn<String>();
  var isLoaded = false.obs;
  var poster = Rxn<PosterModel>();

  var messages = <String>[
    "Hi",
    "Hello",
    "How are you?",
    "I am fine",
    "How is work going?",
    "It is going well you know, just the usual",
    "That is good to hear",
    "Yes, it is",
    "I heard something about you that I did not like",
    "What did you hear?",
    "I heard that you are a bad person. Is that true? I hope not. If it is, I will have to block you and report you to the authorities",
  ].obs;

  var messageList = <MessageModel>[].obs;

  // **********************************

  // Functions
  getPoster() async {
    isLoaded.value = false;
    try {
      var response = await repository.getData(
        collection: "products",
        documentId: posterId.value!,
      );

      if (response.isEmpty) {
        repository.errorHandler(
          title: "Could not get poster",
          message: "Poster not found",
        );
      } else {
        poster.value = PosterModel.fromJson(response[0]);

        tabController.value = TabController(
          length: poster.value!.images.length,
          vsync: this,
        );
      }

      isLoaded.value = true;
    } catch (e) {
      isLoaded.value = true;

      repository.errorHandler(
        title: "Could not get poster",
        message: e.toString(),
      );
    }
  }

  getMessages() async {
    await repository.liveFetchData(
      collection: "messages",
      documentId: chatId.value,
      sortByField: "timestamp",
      onUpdate: (List<Map<String, dynamic>> ducuments) {
        var updatedMessages = ducuments.map((element) {
          return MessageModel.fromJson(element);
        }).toList();

        var newMessageList = <MessageModel>[];

        // Check for new messages and only append those that aren't already in the list
        for (var message in updatedMessages) {
          // If the message doesn't exist in the current list, append it
          if (!messageList
              .any((existingMessage) => existingMessage.id == message.id)) {
            newMessageList.add(message);
          }
        }

        // Add the new messages at the end of the list
        if (newMessageList.isNotEmpty) {
          messageList.addAll(newMessageList);
        }
      },
    );
  }

  sendMessage() async {
    var textMessage = messageController.text;
    messageController.clear();

    if (checkNullability()) {
      return;
    }

    var messageDocId = await repository.postData(
      collection: "messages",
      documentId: chatId.value,
      innerCollection: "list",
      data: MessageModel(
        id: "",
        senderId: userId.value!,
        timestamp: Timestamp.now(),
        text: textMessage,
        read: false,
      ).toJson(),
    );

    if (messageDocId == null) {
      repository.errorHandler(
        title: "Message error",
        message: "Couldn't send your resquest!",
      );
    }
  }

  bool checkNullability() {
    if (posterId.value == null ||
        chatId.value == null ||
        userId.value == null) {
      repository.errorHandler(
        title: "Error",
        message: "Something went wrong!",
      );
      return true;
    }

    return false;
  }

  // ********************************************
}
