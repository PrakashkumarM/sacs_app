import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/screens/home/contoller.dart';
import 'package:sacs_app/app/screens/home/widgets/customer_feedback_widget.dart';

class CustomerFeedback extends StatelessWidget {
  const CustomerFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return MainLayout(
        title: TextString.feedback,
        showBackButton: true,
        body: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align children to the start
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              'Waiting For Customer Feedback',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17.0,
                color: CustomColors.black,
              ),
            ),
            CustomerFeedbackWidget(
              controller: homeController,
            ),
          ],
        ));
  }
}
