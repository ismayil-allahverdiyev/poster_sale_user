import 'package:get/get.dart';
import 'package:poster_sale_user/src/data/models/basket/basket_item_model.dart';
import '../../constants/local_storage.dart';
import '../../data/repository/repository.dart';
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

  calculateTotalPrice() {
    totalPrice.value = basketItems.fold(
      0.0,
      (sum, item) => sum + item.addedPrice,
    );
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
