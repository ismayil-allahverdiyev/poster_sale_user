import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/data/models/basket/basket_item_model.dart';
import 'package:poster_sale_user/src/data/models/basket/basket_model.dart';
import '../../constants/local_storage.dart';
import '../../data/repository/repository.dart';
import '../../ui/basket_overview/widgets/basket_success_dialog_widget.dart';
import '../local_storage/local_storage_controller.dart';

class BasketOverviewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Repository repository;
  BasketOverviewController({required this.repository});

  @override
  onInit() async {
    super.onInit();
    getUserInfo();
    await getBasketItems();
  }

  // Variables
  var isLoading = false.obs;
  var basketItems = <BasketItemModel>[].obs;
  var totalPrice = 0.0.obs;
  var basketId = "";
  String? userId;

  // ***********************************************

  // Functions
  getUserInfo() {
    userId = repository.getUserId();

    var localStorageController = Get.find<LocalStorageController>();
    basketId =
        localStorageController.getStringFromLocal(LocalStorageConst.basketId);
  }

  getBasketItems() async {
    isLoading.value = true;
    try {
      var response = (await repository.getData(
        collection: "baskets",
        documentId: basketId,
        innerCollection: "list",
      ))
          .map((item) => BasketItemModel.fromJson(item))
          .toList();
      basketItems.value = response;
      calculateTotalPrice();
    } catch (e) {
      repository.errorHandler(
        title: "Error fetching basket items",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  removeItemFromBasket(String itemId) async {
    try {
      await repository.deleteData(
        collection: "baskets",
        documentId: basketId,
        innerCollection: "list",
        innerDocumentId: itemId,
      );
      basketItems.removeWhere((item) => item.id == itemId);
      calculateTotalPrice();
    } catch (e) {
      repository.errorHandler(
        title: "Error removing item",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  calculateTotalPrice() {
    totalPrice.value = basketItems.fold(
      0.0,
      (sum, item) => sum + item.addedPrice,
    );
  }

  checkoutBasket() async {
    if (!checkNullability()) return;

    if (basketItems.isEmpty) {
      repository.errorHandler(
        title: "Basket is empty",
        message: "Please add items to your basket before checking out.",
      );
      return;
    }

    try {
      var res = await repository.postData(
        collection: "baskets",
        documentId: basketId,
        isUpdate: true,
        data: {
          "state": BasketState.ordered.index,
          "updated_at": Timestamp.now(),
        },
      );

      if (res == null) {
        repository.errorHandler(
          title: "Could not checkout",
          message: "Please try again later.",
        );
      } else {
        Get.dialog(
          const BasketSuccessDialogWidget(),
        );
        await createBasket();
      }
    } catch (e) {
      repository.errorHandler(
        title: "Error during checkout",
        message: e.toString(),
      );
    }
  }

  createBasket() async {
    try {
      if (!checkNullability()) return;

      var res = await repository.postData(
        collection: "baskets",
        data: BasketModel(
          id: "",
          updated_at: Timestamp.now(),
          state: BasketState.active,
          userId: repository.getUserId()!,
        ).toAddJson(),
      );

      if (res == null) {
        repository.errorHandler(
          title: "Could not create basket",
          message: "Please try again later.",
        );
      } else {
        var localStorageController = Get.find<LocalStorageController>();
        localStorageController.saveStringToLocal(
            LocalStorageConst.basketId, res);
        basketId = res;

        basketItems.clear();
        totalPrice.value = 0.0;
      }
    } catch (e) {
      repository.errorHandler(
        title: "Could not create basket",
        message: e.toString(),
      );
    }
  }

  checkNullability() {
    if (userId == null || userId!.isEmpty) {
      repository.errorHandler(
        title: "User not found",
        message: "Please log in to view your basket.",
      );
      return false;
    }

    if (basketId.isEmpty) {
      repository.errorHandler(
        title: "Basket not found",
        message: "Please add items to your basket.",
      );
      return false;
    }
    return true;
  }

  // ************************************************
}
