import 'package:flutter/material.dart';

import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/screens/home/widgets/customer_feedback.dart';

class CustomerFeedback extends StatelessWidget {
  const CustomerFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: TextString.customerFeedback,
      showBackButton: true,
      body: CustomerFeedbackWidget(),
    );
  }
}
