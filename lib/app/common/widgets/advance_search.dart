import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/data/controllers/search_controller.dart';

class AdvanceSearch extends StatelessWidget {
  final SearchTextController controller = Get.put(SearchTextController());

  AdvanceSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        top: 30.0, // Keep minimal padding to align with the top.
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
          border: Border.all(
              color:
                  Colors.grey.shade300), // Light border around the search bar
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                autofocus: true,
                onChanged: controller.updateSearchText,
                decoration: InputDecoration(
                  hintText: 'Name or Phone number or Serial number',
                  hintStyle: TextStyle(color: CustomColors.grey, fontSize: 14),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8), // Padding to make the icon smaller
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.search, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
