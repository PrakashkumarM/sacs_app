import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/screens/home/contoller.dart';
import 'package:sacs_app/app/screens/home/widgets/team_achivement.dart';

Widget _teamAchievementsWidget({required HomeController homeController}) {
  if (homeController.teamAchievements.length == 0) {
    return SizedBox.shrink();
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          TextString.teamAchivements,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17.0,
              color: CustomColors.unSelectionColor),
        ),
      ),
      const SizedBox(height: 4),
      Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 8.0), // Adjust the vertical padding
        child: SizedBox(
          height: 200,
          child: Obx(() {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.horizontal,
              itemCount: homeController.teamAchievements.length,
              itemBuilder: (context, index) {
                final teamAchievement = homeController.teamAchievements[index];
                return Container(
                  width: MediaQuery.of(context).size.width *
                      0.85, // Full width for scrolling
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0), // Adjust horizontal margin
                  child: TeamAchievementCard(
                    companyName: teamAchievement.productName,
                    logoUrl: teamAchievement.productLogo,
                    currentAchievement: teamAchievement.completedTarget,
                    targetAchievement: teamAchievement.yourTarget,
                    pendingTarget: teamAchievement.pendingTarget,
                    totalTarget: teamAchievement.totalTarget,
                  ),
                );
              },
            );
          }),
        ),
      ),
    ],
  );
}
