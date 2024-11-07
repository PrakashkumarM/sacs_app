import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/common/widgets/alert_dialog.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/data/models/enquiry_model.dart';
import 'package:sacs_app/app/data/services/enquiry_service.dart';
import 'package:sacs_app/app/screens/sale_form/widgets/add_product_form.dart';

class CreateSalesFormController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Observable properties
  var currentStep = 0.obs;
  var enquiries = <Enquiry>[].obs;
  var fabVisible = true.obs;
  var expandedCardIndex = (-1).obs;
  var isLoading = false.obs;
  var imagePath = ''.obs;

  final TextEditingController invoiceNumberController = TextEditingController();
  final EnquiryService _enquiryService = EnquiryService();

  // Animation-related properties
  late final AnimationController _expandController;
  late final Animation<double> _expandAnimation;

  // Form steps
  final List<String> formSteps = [
    TextString.product,
    TextString.customer,
    TextString.invoice,
  ];

  @override
  void onInit() {
    super.onInit();
    _initAnimation();
    fetchEnquiries();
  }

  @override
  void onClose() {
    _expandController.dispose();
    invoiceNumberController.dispose(); // Dispose of controller
    super.onClose();
  }

  void _initAnimation() {
    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    );
  }

  // Fetch enquiries
  Future<void> fetchEnquiries() async {
    isLoading(true);
    final fetchedEnquiries = await _enquiryService.fetchEnquiries();
    enquiries.assignAll(fetchedEnquiries);
    isLoading(false);
  }

  // Handle step transitions
  void goBackOrNext(bool isBack) {
    if (isBack && currentStep.value > 0) {
      currentStep.value--;
    } else if (!isBack && currentStep.value < formSteps.length - 1) {
      currentStep.value++;
    }
  }

  // Submit form and navigate
  void submitForm() {
    NavigationHelper.navigateAndClearStack(
      TextString.dashboard,
      arguments: {'tabIndex': 2},
    );
  }

  // Show the product addition form in a full-screen bottom sheet
  void showFullScreenBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      builder: (_) => AddProductForm(false),
    );
  }

  // Image update
  void updateImage(String imgPath) => imagePath.value = imgPath;

  // Toggle floating action button visibility
  void toggleFab(bool visible) => fabVisible.value = visible;

  // Toggle card expansion/collapse
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

  // Delete confirmation dialog
  void showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(
        title: TextString.areYouSure,
        message: [
          TextSpan(
            text: TextString.youWontBeAbleToRevertThis,
            style: TextStyle(color: CustomColors.darkGrey),
          ),
        ],
        confirmText: TextString.yesDelIt,
        cancelText: TextString.cancel,
        onConfirm: (feedback) => Navigator.of(context).pop(),
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }

  // Getter for animation
  Animation<double> get expandAnimation => _expandAnimation;
}
