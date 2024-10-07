import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakeSalesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var selectedDate = Rxn<DateTime>();
  var chargeController = TextEditingController(text: '1100');

  late AnimationController _expandController;
  late Animation<double> _expandAnimation;

  var fabVisible = true.obs;
  RxInt expandedCardIndex = (-1).obs;

  Animation<double> get expandAnimation => _expandAnimation;

  @override
  void onInit() {
    super.onInit();

    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    _expandController.dispose();
    chargeController.dispose(); // Dispose the controller when not in use
    super.onClose();
  }

  void toggleCardExpansion(int cardKey) {
    if (!_expandController.isAnimating) {
      if (expandedCardIndex.value == cardKey) {
        _expandController.reverse().whenComplete(() {
          expandedCardIndex.value = -1;
        });
      } else {
        expandedCardIndex.value = cardKey;
        _expandController.forward();
      }
    }
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
  }
}
