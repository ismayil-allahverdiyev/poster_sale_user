import 'package:get/get.dart';
import 'package:poster_sale_user/src/data/models/basket/basket_model.dart';
import 'package:poster_sale_user/src/data/models/user/user_model.dart';
import '../../data/models/basket/basket_item_model.dart';
import '../../data/repository/repository.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Repository repository;
  ProfileController({required this.repository});

  // Variables
  var user = Rxn<UserModel>();
  var isLoaded = false.obs;
  var previousOrders = <BasketModel>[].obs;

  // ***********************************************

  // initalization
  @override
  onInit() async {
    super.onInit();
    await getUserInfo();
    await getPreviousOrders();
  }

  // ***********************************************

  // Functions
  getUserInfo() async {
    try {
      var customerId = repository.getUserId();
      if (customerId == null) {
        repository.errorHandler(
          title: "Something went wrong!",
          message: "Could not retrieve user info.",
        );
        return;
      }

      isLoaded.value = false;
      var res = await repository.getData(
        collection: "users",
        searchCriteria: {
          "id": customerId,
        },
      );

      if (res.isEmpty) {
        repository.errorHandler(
          title: "Error",
          message: "We could not get your user information!",
        );
      } else {
        user.value = UserModel.fromJson(res[0]);
        user.value!.id = customerId; // Ensure user ID is set
      }
    } catch (e) {
      repository.errorHandler(
        title: "Error",
        message: e.toString(),
      );
    } finally {
      isLoaded.value = true;
    }
  }

  getPreviousOrders() async {
    try {
      if (!checkNullability()) return;
      isLoaded.value = false;
      var res = await repository.getData(
        collection: "baskets",
        searchCriteria: {
          "userId": user.value!.id,
        },
        orderField: "state",
      );

      if (res.isEmpty) {
        repository.errorHandler(
          title: "Error",
          message: "We could not get your previous orders!",
        );
      } else {
        var orders = res
            .map((e) => BasketModel.fromJson(e))
            .where((element) => element.state != BasketState.active)
            .toList();

        for (var basket in orders) {
          basket = await getBasketItems(basket);
        }

        previousOrders.value = orders;
      }

      isLoaded.value = true;
    } catch (e) {
      repository.errorHandler(
        title: "Error",
        message: e.toString(),
      );
    } finally {
      isLoaded.value = true;
    }
  }

  Future<BasketModel> getBasketItems(BasketModel basket) async {
    try {
      var res = await repository.getData(
        collection: "baskets",
        documentId: basket.id,
        innerCollection: "list",
      );

      if (res.isEmpty) {
        repository.errorHandler(
          title: "Error",
          message: "We could not get your basket items!",
        );
      } else {
        basket.items = res.map((e) => BasketItemModel.fromJson(e)).toList();
      }

      isLoaded.value = true;
    } catch (e) {
      repository.errorHandler(
        title: "Error",
        message: e.toString(),
      );
    }

    return basket;
  }

  checkNullability() {
    if (user.value == null) {
      repository.errorHandler(
        title: "Something went wrong!",
        message: "Could not get user information.",
      );
      return false;
    }
    return true;
  }
  // ************************************************
}
