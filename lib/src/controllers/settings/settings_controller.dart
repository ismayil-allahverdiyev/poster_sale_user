import 'package:get/get.dart';
import '../../data/repository/repository.dart';

class SettingsController extends GetxController
    with GetTickerProviderStateMixin {
  final Repository repository;
  SettingsController({required this.repository});

  // Controller and Variables
  var isLoading = false.obs;

  // ***************************************************************
}
