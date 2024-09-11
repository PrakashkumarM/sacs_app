import 'package:get/get.dart';

class EnquiryController extends GetxController {
  var fabVisible = true.obs; // Observable for FAB visibility

  // Method to show FAB
  void showFab() {
    fabVisible.value = true;
  }

  // Method to hide FAB
  void hideFab() {
    fabVisible.value = false;
  }
}
