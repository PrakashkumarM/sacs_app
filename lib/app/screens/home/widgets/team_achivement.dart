import 'package:flutter/material.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';

class TeamAchievementCard extends StatelessWidget {
  final String companyName;
  final String logoUrl;
  final int currentAchievement;
  final int targetAchievement;
  final int pendingTarget;
  final int totalTarget;

  const TeamAchievementCard({
    Key? key,
    required this.companyName,
    required this.logoUrl,
    required this.currentAchievement,
    required this.targetAchievement,
    required this.pendingTarget,
    required this.totalTarget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = currentAchievement / targetAchievement;

    return Card(
      color: CustomColors.greenBadge,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: CustomColors.darkGreenColor,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12),
                  bottom: Radius.circular(12)), // Round corners
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(12), // Round image corners
                          child: Image.network(
                            logoUrl,
                            width: 40,
                            height: 40,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          companyName,
                          style: TextStyle(
                            fontSize: 17,
                            color: CustomColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '$currentAchievement / $targetAchievement',
                          style: TextStyle(
                            color: CustomColors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          TextString.yourTarget,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: CustomColors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(TextString.target,
                        style: TextStyle(
                            fontSize: 15,
                            color: CustomColors.white,
                            fontWeight: FontWeight.w500)),
                    Text('$pendingTarget / $totalTarget',
                        style: TextStyle(
                            fontSize: 15,
                            color: CustomColors.white,
                            fontWeight: FontWeight.w500)),
                  ],
                ), // Update text color as needed
                SizedBox(height: 4), // Space between the text and progress bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(
                        8), // Round corners for progress bar
                  ),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
                SizedBox(height: 3),
              ],
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$pendingTarget',
                        style: TextStyle(color: CustomColors.black)),
                    Text(TextString.pendingTarget,
                        style: TextStyle(color: CustomColors.black)),
                  ],
                ), // Update text color as needed
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$totalTarget',
                        style: TextStyle(color: CustomColors.black)),
                    Text(TextString.totalProduct,
                        style: TextStyle(color: CustomColors.black)),
                  ],
                ), // Update text color as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
