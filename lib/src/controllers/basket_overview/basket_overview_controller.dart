import 'package:get/get.dart';
import '../../data/repository/repository.dart';

class BasketOverviewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Repository repository;
  BasketOverviewController({required this.repository});

  @override
  onInit() {
    super.onInit();
  }
}
