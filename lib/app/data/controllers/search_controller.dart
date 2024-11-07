import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/common/widgets/advance_search.dart';
import 'package:sacs_app/app/screens/home/widgets/search_widget.dart';

class SearchTextController extends GetxController {
  // Observable to hold the search text
  var searchText = ''.obs;

  // Observable to manage the visibility of the search bar
  var isVisible = false.obs;

  // Method to toggle the visibility of the search bar
  void toggleSearchBar() {
    isVisible.value = !isVisible.value;
  }

  // Method to update the search text
  void updateSearchText(String text) {
    searchText.value = text;
  }

  void showSearchBar() {
    showGeneralDialog(
      context: Get.context!,
      barrierLabel: "Search",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5), // Background dimming color
      transitionDuration: Duration(milliseconds: 300), // Animation duration
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.topCenter,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16.0),
                ),
              ),
              child: AdvanceSearch(), // Your Search Widget
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: Offset(0, -1), // Start from above the screen
            end: Offset(0, 0), // Slide to top of the screen
          ).animate(anim1),
          child: child,
        );
      },
    );
  }
}
