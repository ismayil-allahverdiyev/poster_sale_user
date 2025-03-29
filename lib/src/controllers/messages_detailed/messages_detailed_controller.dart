import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repository/repository.dart';

class MessagesDetailedController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Repository repository;
  MessagesDetailedController({required this.repository});

  @override
  onInit() {
    super.onInit();
    tabController = TabController(length: tabLength, vsync: this);
  }
  // Controllers and variables

  TabController? tabController;
  TextEditingController messageController = TextEditingController();
  var tabLength = 4;

  var messages = <String>[
    "Hi",
    "Hello",
    "How are you?",
    "I am fine",
    "How is work going?",
    "It is going well you know, just the usual",
    "That is good to hear",
    "Yes, it is",
    "I heard something about you that I did not like",
    "What did you hear?",
    "I heard that you are a bad person. Is that true? I hope not. If it is, I will have to block you and report you to the authorities",
  ].obs;

  // **********************************
}
