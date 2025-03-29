import 'package:get/get.dart';
import '../../data/repository/repository.dart';

class BasketsOverviewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Repository repository;
  BasketsOverviewController({required this.repository});

  @override
  onInit() {
    super.onInit();
  }
}
