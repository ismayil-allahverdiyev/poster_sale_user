import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/data/models/basket/basket_item_model.dart';
import 'package:poster_sale_user/src/data/models/chat/chat_model.dart';
import 'package:poster_sale_user/src/data/models/message/message_model.dart';
import 'package:poster_sale_user/src/routes/app_routes.dart';
import '../../constants/local_storage.dart';
import '../../data/models/poster/poster_model.dart';
import '../../data/repository/repository.dart';
import '../basket_overview/basket_overview_controller.dart';
import '../local_storage/local_storage_controller.dart';

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
  var chatStatus = ChatStatus.normal.obs;
  var customerId = Rxn<String>();
  var isInBasket = false.obs;
  String basketId = "";

  var poster = Rxn<PosterModel>();
  // ***********************************************

  // initalization
  @override
  onInit() async {
    super.onInit();

    getUserId();
    await checkIfInBasket();
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

  checkIfInBasket() async {
    try {
      var localStorageController = Get.find<LocalStorageController>();
      basketId = localStorageController.getStringFromLocal(
        LocalStorageConst.basketId,
      );

      checkBasics();

      var basketItems = (await repository.getData(
        collection: "baskets",
        documentId: basketId,
        innerCollection: "list",
      ))
          .map((e) => BasketItemModel.fromJson(e))
          .toList();

      if (basketItems.isEmpty) {
        repository.errorHandler(
          title: "Basket not found",
          message: "Something went wrong! Please try again later.",
        );
        return;
      } else {
        isInBasket.value = basketItems.any((item) => item.productId == id);
      }
    } catch (e) {
      repository.errorHandler(
        title: "Could not check basket",
        message: e.toString(),
      );
    }
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

    if (basketId == "") {
      repository.errorHandler(
        title: "Basket not found",
        message: "Something went wrong! Please try again later.",
      );
      return;
    }
  }

  getChatId() async {
    try {
      checkBasics();

      var chatData = await repository.getData(
        collection: "chats",
        searchCriteria: {
          "customerId": customerId.value!,
          "productId true": poster.value!.id,
        },
      );

      if (chatData.isNotEmpty) {
        chatId.value = chatData[0]["id"];
        chatStatus.value = ChatStatus.values[chatData[0]["chatStatus"] as int];
        hasMessaged.value = true;
      }
    } catch (e) {
      repository.errorHandler(
        title: "Could not get chat",
        message: e.toString(),
      );
    }
  }

  onSendFirstMessage() async {
    try {
      var newDocumentId = await repository.postData(
        collection: "chats",
        data: ChatModel(
          id: "",
          customerId: customerId.value!,
          timestamp: Timestamp.now(),
          lastMessage: messageController.text,
          productId: poster.value!.id,
          productImage: poster.value!.images[0],
          productTitle: poster.value!.title,
          chatStatus: ChatStatus.normal,
          read: true,
          readByAdmin: false,
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
          id: "",
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

        return;
      }

      openMessagesPage();
    } catch (e) {
      repository.errorHandler(
        title: "Message error",
        message: e.toString(),
      );
    }
  }

  addToBasket() async {
    try {
      if (isLoaded.value == false) return;
      checkBasics();

      var localStorageController = Get.find<LocalStorageController>();
      var basketId = localStorageController.getStringFromLocal(
        LocalStorageConst.basketId,
      );

      if (basketId == "") {
        repository.errorHandler(
          title: "Basket not found",
          message: "Something went wrong! Please try again later.",
        );
        return;
      }

      if (isInBasket.value) {
        await removeFromBasket();
        return;
      }

      var res = await repository.postData(
        collection: "baskets",
        documentId: basketId,
        innerCollection: "list",
        innerDocumentId: id,
        data: BasketItemModel.fromPoster(poster: poster.value!).toJson(),
      );

      if (res == null) {
        repository.errorHandler(
          title: "Could not add to basket",
          message: "Please try again later.",
        );
        return;
      } else {
        isInBasket.value = true;

        await updateBasketPage();
      }
    } catch (e) {
      repository.errorHandler(
        title: "Could not add to basket",
        message: e.toString(),
      );
    }
  }

  removeFromBasket() async {
    try {
      if (isLoaded.value == false) return;
      checkBasics();

      var localStorageController = Get.find<LocalStorageController>();
      var basketId = localStorageController.getStringFromLocal(
        LocalStorageConst.basketId,
      );

      if (basketId == "") {
        repository.errorHandler(
          title: "Basket not found",
          message: "Something went wrong! Please try again later.",
        );
        return;
      }

      if (!isInBasket.value) {
        await addToBasket();
        return;
      }

      var res = await repository.deleteData(
        collection: "baskets",
        documentId: basketId,
        innerCollection: "list",
        innerDocumentId: id,
      );

      if (res == null) {
        repository.errorHandler(
          title: "Could not remove from basket",
          message: "Please try again later.",
        );
        return;
      } else {
        isInBasket.value = false;

        await updateBasketPage();
      }
    } catch (e) {
      repository.errorHandler(
        title: "Could not remove from basket",
        message: e.toString(),
      );
    }
  }

  updateBasketPage() async {
    var basketOverviewController = Get.find<BasketOverviewController>();

    if (!basketOverviewController.isClosed) {
      await basketOverviewController.getBasketItems();
    }
  }

  openMessagesPage() async {
    Get.toNamed(
      Routes.MESSAGESDETAILED,
      parameters: {
        "posterId": poster.value!.id,
        "chatId": chatId.value!,
        "chatStatus": chatStatus.value.index.toString(),
      },
    );
  }
  // ***********************************************

  // Dispose
  @override
  void onClose() {
    tabController?.dispose();
    messageController.dispose();
    super.onClose();
  }

  // ***********************************************
}
