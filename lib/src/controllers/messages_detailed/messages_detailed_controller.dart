import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/data/models/message/message_model.dart';
import '../../data/models/chat/chat_model.dart';
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
    chatStatus.value =
        ChatStatus.values[int.parse(Get.parameters["chatStatus"] ?? "0")];
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
  final ScrollController scrollController = ScrollController();

  // **********************************

  // Variables
  var posterId = Rxn<String>();
  var chatId = Rxn<String>();
  var chatStatus = ChatStatus.normal.obs;
  var userId = Rxn<String>();
  var isLoaded = false.obs;
  var poster = Rxn<PosterModel>();

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
    } catch (e) {
      repository.errorHandler(
        title: "Could not get poster",
        message: e.toString(),
      );
    } finally {
      isLoaded.value = true;
    }
  }

  getMessages() async {
    try {
      await setChatRead();

      // Fetch the messages from the repository
      await repository.liveFetchData(
        collection: "messages",
        documentId: chatId.value,
        sortByField: "timestamp",
        onUpdate: (List<Map<String, dynamic>> ducuments) async {
          // Handle the response
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

            if (newMessageList.last.senderId != userId.value) {
              // If the last message is not from the user, set the chat as read
              await setChatRead();
            }

            await Future.delayed(const Duration(milliseconds: 100));
            scrollToBottom();
          }
        },
      );
    } catch (e) {
      repository.errorHandler(
        title: "Could not get messages",
        message: e.toString(),
      );
    }
  }

  sendMessage() async {
    try {
      var textMessage = messageController.text.trimLeft();
      messageController.clear();

      if (checkNullability() || textMessage.isEmpty) {
        return;
      }

      // Send message to the user (Leave message Id empty if it is a new message)
      var newMessage = MessageModel(
        id: "",
        senderId: userId.value!,
        timestamp: Timestamp.now(),
        text: textMessage,
        read: false,
      );

      var messageDocId = await repository.postData(
        collection: "messages",
        documentId: chatId.value,
        innerCollection: "list",
        data: newMessage.toJson(),
      );

      if (messageDocId == null) {
        repository.errorHandler(
          title: "Message error",
          message: "Couldn't send your resquest!",
        );
      } else {
        newMessage.id = messageDocId;
        updateLastMessage(message: newMessage);
      }
    } catch (e) {
      repository.errorHandler(
        title: "Message error",
        message: e.toString(),
      );
    }
  }

  setChatRead() async {
    try {
      if (checkNullability()) {
        return;
      }

      var requestId = await repository.postData(
        collection: "chats",
        documentId: chatId.value!,
        data: {
          "read": true,
        },
      );

      if (requestId == null) {
        repository.errorHandler(
          title: "Message error",
          message: "Couldn't send your resquest!",
        );
      }
    } catch (e) {
      repository.errorHandler(
        title: "Message error",
        message: e.toString(),
      );
    }
  }

  updateLastMessage({required MessageModel message}) async {
    try {
      if (checkNullability()) {
        return;
      }

      var requestId = await repository.postData(
        collection: "chats",
        documentId: chatId.value!,
        isUpdate: true,
        data: {
          "lastMessage": message.text,
          "lastMessageId": message.id,
          "readByAdmin": false,
          "read": true,
          "timestamp": message.timestamp,
        },
      );

      if (requestId == null) {
        repository.errorHandler(
          title: "Message error",
          message: "Couldn't send your resquest!",
        );

        return;
      }
    } catch (e) {
      repository.errorHandler(
        title: "Message error",
        message: e.toString(),
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

  // UI related functions

  void scrollToBottom() {
    try {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    } catch (e) {
      print("Error scrolling to bottom: $e");
    }
  }
  // ********************************************

  // Dispose
  @override
  void onClose() {
    tabController.value?.dispose();
    scrollController.dispose();
    messageController.dispose();
    super.onClose();
  }
  // ********************************************
}
