import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardExpansionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController expandController;
  RxInt expandedCardIndex = (-1).obs; // Default: No card is expanded
  late Animation<double> expandAnimation;

  @override
  void onInit() {
    super.onInit();
    expandController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    expandAnimation = CurvedAnimation(
      parent: expandController,
      curve: Curves.easeInOut,
    );
  }

  void toggleCardExpansion(int cardKey) async {
    if (expandedCardIndex.value == cardKey) {
      await expandController.reverse();
      expandedCardIndex.value = -1;
    } else {
      await expandController.reverse();
      expandedCardIndex.value = cardKey;
      await expandController.forward();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }
}
