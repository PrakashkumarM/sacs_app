import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/data/models/enquiry_model.dart';
import 'package:sacs_app/app/data/services/enquiry_service.dart';
import 'package:sacs_app/app/screens/enquiry/widgets/close_enquiry.dart';

class EnquiryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final EnquiryService _enquiryService = EnquiryService();

  var enquiries = <Enquiry>[].obs;
  var currentDateLabel = "".obs;
  var fabVisible = true.obs;
  RxBool isLoading = false.obs;
  RxInt currentPage = 1.obs;
  final TextEditingController _reasonController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    fetchEnquiries();
  }

  @override
  void onClose() {
    // _expandController.dispose();
    super.onClose();
  }

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

  void showCloseEnquiryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CloseEnquiryDialog();
      },
    );
  }
}
