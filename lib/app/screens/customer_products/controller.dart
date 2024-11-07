import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/common/widgets/alert_dialog.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';

class CustomerProductsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var expandedStates = <int, bool>{}.obs;
  RxInt expandedCardIndex = (-1).obs;

  late AnimationController _expandController;
  late Animation<double> _expandAnimation;
  final List<Map<String, dynamic>> products = [
    {
      "name": "Television | Samsung | TV | 42\"",
      "price": "₹ 69000",
      "type": "Product",
      "serialNumber": "78521874850",
      "status": "Warehouse",
    },
    {
      "name": "Washing Machine | Haier | 9Kg",
      "price": "₹ 69000",
      "type": "Product",
      "serialNumber": "78521874100",
      "status": "Warehouse",
    },
    // More products...
  ];
  @override
  void onInit() {
    super.onInit();

    _expandController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    // _expandController.dispose();
    super.onClose();
  }

  Animation<double> get expandAnimation => _expandAnimation;

  void toggleCardExpansion(int cardKey) {
    if (!_expandController.isAnimating) {
      // Check if the controller is still active
      if (expandedCardIndex.value == cardKey) {
        // Reverse animation
        _expandController.reverse().whenComplete(() {
          expandedCardIndex.value = -1;
        });
      } else {
        // Update index first to match animation duration
        expandedCardIndex.value = cardKey;
        _expandController.forward();
      }
    }
  }

  void showDeliveryApproval(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(
        title: TextString.deliveryApproval,
        message: [
          TextSpan(
            text: TextString.productDelivered,
            style: TextStyle(color: CustomColors.darkGrey),
          ),
        ],
        confirmText: TextString.yes,
        cancelText: TextString.cancel,
        onConfirm: (feedback) => Navigator.of(context).pop(),
        onCancel: () => Navigator.of(context).pop(),
        showField: false, // Show the TextFormField
      ),
    );
  }

  @override
  dispose() {
    _expandController.dispose(); // you need this
    super.dispose();
  }
}
