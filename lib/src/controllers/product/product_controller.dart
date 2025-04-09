import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/data/models/chat/chat_model.dart';
import 'package:poster_sale_user/src/data/models/message/message_model.dart';
import 'package:poster_sale_user/src/routes/app_routes.dart';
import '../../data/models/poster/poster_model.dart';
import '../../data/repository/repository.dart';

class ProductController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Repository repository;
  ProductController({required this.repository});

  // Controller Variables
  TabController? tabController;
  TextEditingController messageController = TextEditingController();
  // ***********************************************

  // Variables
  var selectedIndex = 0.obs;
  String id = Get.parameters['id']!;

  var isLoaded = false.obs;
  var hasMessaged = false.obs;
  var chatId = Rxn<String>();
  var customerId = Rxn<String>();

  var poster = Rxn<PosterModel>();
  // ***********************************************

  // initalization
  @override
  onInit() async {
    super.onInit();

    getUserId();
    await getPoster();
    await getChatId();
  }
  // ***********************************************

  // Functions
  getPoster() async {
    isLoaded.value = false;
    try {
      var response =
          await repository.getData(collection: "products", documentId: id);

      if (response.isEmpty) {
        repository.errorHandler(
          title: "Could not get poster",
          message: "Poster not found",
        );
      } else {
        poster.value = PosterModel.fromJson(response[0]);

        tabController =
            TabController(length: poster.value!.images.length, vsync: this);
        tabController!.addListener(() {
          selectedIndex.value = tabController!.index;
        });
      }

      isLoaded.value = true;
      checkBasics();
    } catch (e) {
      repository.errorHandler(
        title: "Could not get poster",
        message: e.toString(),
      );
    }
  }

  getUserId() async {
    customerId.value = repository.getUserId();
  }

  checkBasics() {
    if (customerId.value == null) {
      repository.errorHandler(
        title: "Something went wrong!",
        message: "Could not get user information.",
      );

      return;
    }

    if (poster.value == null) {
      repository.errorHandler(
        title: "Something went wrong!",
        message: "Poster not available.",
      );
      return;
    }
  }

  getChatId() async {
    checkBasics();

    var chatData = await repository.getData(
      collection: "chats",
      searchCriteria: {
        "customerId": customerId.value!,
        "productId": poster.value!.id,
      },
    );

    if (chatData.isNotEmpty) {
      chatId.value = chatData[0]["id"];
      hasMessaged.value = true;
    }
  }

  onSendFirstMessage() async {
    var newDocumentId = await repository.postData(
      collection: "chats",
      data: ChatModel(
        customerId: customerId.value!,
        timestamp: Timestamp.now(),
        lastMessage: messageController.text,
        productId: poster.value!.id,
        read: false,
      ).toJson(),
    );

    if (newDocumentId == null) {
      repository.errorHandler(
        title: "Message error",
        message: "Couldn't send your resquest!",
      );
      return;
    }

    hasMessaged.value = true;
    chatId.value = newDocumentId;

    var messageDocId = await repository.postData(
      collection: "messages",
      documentId: newDocumentId,
      innerCollection: "list",
      data: MessageModel(
        senderId: customerId.value!,
        timestamp: Timestamp.now(),
        text: messageController.text,
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

  openMessagesPage() async {
    Get.toNamed(
      Routes.MESSAGESDETAILED,
      parameters: {
        "posterId": poster.value!.id,
        "chatId": chatId.value!,
      },
    );
  }

  // **********************************
}
