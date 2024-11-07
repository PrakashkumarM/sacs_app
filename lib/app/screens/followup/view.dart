import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/screens/home/contoller.dart';
import 'package:sacs_app/app/screens/home/widgets/followup_card.dart';

class FollowUp extends StatelessWidget {
  const FollowUp({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return MainLayout(
      title: TextString.followUpRem,
      showBackButton: true,
      body: Column(
        children: [
          SizedBox(
            height: 24,
          ),
          Obx(() {
            return Expanded(
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: homeController.followUpReminderList.length,
                itemBuilder: (context, index) {
                  final teamAchievement =
                      homeController.followUpReminderList[index];
                  return FollowUpCard(
                      name: teamAchievement.customerName,
                      date: teamAchievement.nextVisitDate,
                      mobile: '${teamAchievement.mobile}',
                      index: index,
                      controller: homeController,
                      isLastIndex:
                          homeController.followUpReminderList.length - 1 ==
                              index);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
