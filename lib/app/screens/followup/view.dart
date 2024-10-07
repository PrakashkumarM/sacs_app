import 'package:flutter/material.dart';

import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/screens/home/widgets/followup_card.dart';

class FollowUp extends StatelessWidget {
  const FollowUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: TextString.followUpRem,
      showBackButton: true,
      body: FollowUpReminderList(),
    );
  }
}
