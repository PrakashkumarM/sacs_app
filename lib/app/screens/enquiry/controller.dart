import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/data/controllers/filter_controller.dart';
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
  RxString startDate = ''.obs; // Final value
  RxString endDate = ''.obs; // Final value
  RxString status = ''.obs; // Final value

  RxString tempStartDate = ''.obs; // Final value
  RxString tempEndDate = ''.obs; // Final value
  RxString tempStatus = ''.obs; // Final value

  final TextEditingController _reasonController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    fetchEnquiries();
  }

  void updateValue(RxString key, String value) {
    key.value = value;
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

    var fetchedEnquiries = await _enquiryService.fetchEnquiries(
      startDate: startDate.value,
      endDate: endDate.value,
      status: status.value,
    );

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

  applyFilters() {
    startDate.value = tempStartDate.value;
    endDate.value = tempEndDate.value;
    status.value = tempStatus.value;
    fetchEnquiries();
  }

  void resetFilters() {
    tempStartDate.value = '';
    tempEndDate.value = '';
    tempStatus.value = '';
    applyFilters();
  }
}
