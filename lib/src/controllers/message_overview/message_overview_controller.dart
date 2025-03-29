import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repository/repository.dart';

class MessageOverviewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Repository repository;
  MessageOverviewController({required this.repository});

  @override
  onInit() {
    super.onInit();
  }
}
