import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/common/widgets/alert_dialog.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/data/models/enquiry_model.dart';
import 'package:sacs_app/app/data/services/enquiry_service.dart';
import 'package:sacs_app/app/screens/enquiry/widgets/close_enquiry.dart';
import 'package:url_launcher/url_launcher.dart';

class SalesScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final EnquiryService _enquiryService = EnquiryService();

  final expandedStates = <int, bool>{}.obs;
  final enquiries = <Enquiry>[].obs;
  final currentDateLabel = "".obs;
  final fabVisible = true.obs;
  final expandedCardIndex = (-1).obs;
  final isLoading = false.obs;
  final currentPage = 1.obs;
  final TextEditingController reasonController = TextEditingController();

  late final AnimationController _expandController;
  late final Animation<double> _expandAnimation;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimation();
    fetchEnquiries();
  }

  void _initializeAnimation() {
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
    super.onClose();
  }

  Animation<double> get expandAnimation => _expandAnimation;

  void showFab() => fabVisible.value = true;

  void hideFab() => fabVisible.value = false;

  Future<void> fetchEnquiries() async {
    isLoading(true);
    try {
      var fetchedEnquiries = await _enquiryService.fetchEnquiries();
      enquiries.assignAll(fetchedEnquiries);
    } finally {
      isLoading(false);
    }
  }

  void updateDateLabel(String date) => currentDateLabel.value = date;

  void showConfirmationDialog(
      BuildContext context,
      String title,
      List<TextSpan> message,
      String confirmText,
      String cancelText,
      VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: title,
          message: message,
          confirmText: confirmText,
          cancelText: cancelText,
          onConfirm: (feedback) {
            onConfirm();
            Navigator.of(context).pop();
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void showDeleteConfirmation(BuildContext context) {
    showConfirmationDialog(
      context,
      TextString.areYouSure,
      [
        TextSpan(
          text: TextString.youWontBeAbleToRevertThis,
          style: TextStyle(color: CustomColors.darkGrey),
        ),
      ],
      TextString.yesDelIt,
      TextString.cancel,
      () {
        // Handle the confirm action
      },
    );
  }

  void showDeliveryChargeApproval(BuildContext context, double charge) {
    showConfirmationDialog(
      context,
      TextString.delChrgApprvl,
      [
        TextSpan(
          text: TextString.delChrgWillbe,
          style: TextStyle(color: CustomColors.darkGrey),
        ),
        TextSpan(
          text: 'Rs $charge \n',
          style: TextStyle(
            fontSize: 18,
            color: CustomColors.darkRedText,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: TextString.rusureAprvDelChrg,
          style: TextStyle(color: CustomColors.darkGrey),
        ),
      ],
      TextString.yesApprvd,
      TextString.cancel,
      () {
        // Handle confirmation
      },
    );
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

  void showCloseEnquiryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CloseEnquiryDialog(),
    );
  }
}
