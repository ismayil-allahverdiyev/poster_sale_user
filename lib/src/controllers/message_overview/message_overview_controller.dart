import 'package:get/get.dart';
import 'package:poster_sale_user/src/data/models/chat/chat_model.dart';
import '../../data/repository/repository.dart';

class MessageOverviewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Repository repository;
  MessageOverviewController({required this.repository});

  @override
  onInit() async {
    super.onInit();
    userId.value = repository.getUserId();

    if (checkNullability()) {
      return;
    }

    await getChatList();
  }

  // Variables
  var isLoaded = false.obs;
  var userId = Rxn<String>();
  var chatList = <ChatModel>[].obs;

  // ***********************************************

  // Functions
  getChatList() async {
    isLoaded.value = false;
    try {
      // Fetch the chat list from the repository
      await repository.liveFetchData(
        collection: "chats",
        isDescending: true,
        sortByField: "timestamp",
        onUpdate: (response) {
          // Handle the response
          if (response.isEmpty) {
            repository.errorHandler(
              title: "Could not get chat list",
              message: "No chats found",
            );
          } else {
            // Map the response to a list of ChatModel
            chatList.value = List<ChatModel>.from(
                response.map((x) => ChatModel.fromJson(x)).toList());
          }
        },
      );
    } catch (e) {
      repository.errorHandler(
        title: "Could not get chat list",
        message: e.toString(),
      );
    } finally {
      isLoaded.value = true;
    }
  }

  bool checkNullability() {
    if (userId.value == null) {
      repository.errorHandler(
        title: "Error",
        message: "Something went wrong!",
      );
      return true;
    }

    return false;
  }

  // ***********************************************
}
