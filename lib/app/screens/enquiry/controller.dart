import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/data/models/enquiry_model.dart';
import 'package:sacs_app/app/data/services/enquiry_service.dart';
import 'package:sacs_app/app/screens/enquiry/widgets/close_enquiry.dart';

class EnquiryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final EnquiryService _enquiryService = EnquiryService();

  var expandedStates = <int, bool>{}.obs;
  var enquiries = <Enquiry>[].obs;
  var currentDateLabel = "".obs;
  var fabVisible = true.obs;
  RxInt expandedCardIndex = (-1).obs;
  RxBool isLoading = false.obs;
  RxInt currentPage = 1.obs;
  final TextEditingController _reasonController = TextEditingController();

  late AnimationController _expandController;
  late Animation<double> _expandAnimation;

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
    fetchEnquiries();
  }

  @override
  void onClose() {
    // _expandController.dispose();
    super.onClose();
  }

  Animation<double> get expandAnimation => _expandAnimation;

  void showFab() {
    fabVisible.value = true;
  }

  void hideFab() {
    fabVisible.value = false;
  }

  void fetchEnquiries() async {
    isLoading(true);
    var fetchedEnquiries = await _enquiryService.fetchEnquiries();
    enquiries.assignAll(fetchedEnquiries);
    isLoading(false);
  }

  void updateDateLabel(String date) {
    currentDateLabel.value = date;
  }

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

  @override
  dispose() {
    _expandController.dispose(); // you need this
    super.dispose();
  }

  void showCloseEnquiryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CloseEnquiryDialog();
      },
    );
  }
}
