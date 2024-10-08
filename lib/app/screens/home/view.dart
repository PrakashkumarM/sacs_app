import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/common/widgets/rounded_image.dart';
import 'package:sacs_app/app/common/widgets/text_button_with_icon.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/screens/customer_feedback/view.dart';
import 'package:sacs_app/app/screens/followup/view.dart';
import 'package:sacs_app/app/screens/home/contoller.dart';
import 'package:sacs_app/app/screens/home/widgets/customer_feedback.dart';
import 'package:sacs_app/app/screens/home/widgets/followup_card.dart';
import 'package:sacs_app/app/screens/home/widgets/team_achivement.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      onProfileTap: homeController.profileTap,
      onLogoutTap: homeController.logout,
      isDashboard: true,
      body: Column(
        children: [
          // Search bar (non-scrollable)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: TextString.enterPhoneNumber,
                hintStyle: TextStyle(fontSize: 16, color: CustomColors.grey),
                prefixIcon: Icon(
                  CustomIcons.search,
                  size: 16,
                  color: CustomColors.darkGrey,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColors.borderGrey),
                  borderRadius: BorderRadius.circular(30.0), // Rounded border
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColors.borderGrey),
                  borderRadius: BorderRadius.circular(30.0), // Rounded border
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColors.borderGrey),
                  borderRadius: BorderRadius.circular(30.0), // Rounded border
                ),
              ),
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGreetingSection(),
                  SizedBox(height: 24),
                  _buildStatisticsSection(context),
                  SizedBox(height: 24),

                  // Team Achievements section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TextString.teamAchivements,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0,
                            color: CustomColors.unSelectionColor),
                      ),
                      SizedBox(height: 4),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeController.topPerformers.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8.0),
                              child: TeamAchievementCard(
                                companyName: 'Samsung',
                                logoUrl: 'https://picsum.photos/200',
                                currentAchievement: 10,
                                targetAchievement: 25,
                                pendingTarget: 25,
                                totalTarget: 50,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),

                  // Followup Reminder section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            TextString.followUpRem,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17.0,
                                color: CustomColors.black),
                          ),
                          InkWell(
                            onTap: () {
                              NavigationHelper.navigateToScreen(FollowUp());
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                color: CustomColors.selectionColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    TextString.viewall,
                                    style: TextStyle(color: CustomColors.white),
                                  ),
                                  SizedBox(width: 3.0),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    color: CustomColors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      FollowUpReminderList(),
                    ],
                  ),
                  SizedBox(height: 24),

                  _buildTopPerformersSection(), // Scrollable part
                  SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Waiting For Customer\n Feedback',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0,
                            color: CustomColors.black),
                      ),
                      InkWell(
                        onTap: () {
                          NavigationHelper.navigateToScreen(CustomerFeedback());
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            color: CustomColors.selectionColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                TextString.viewall,
                                style: TextStyle(color: CustomColors.white),
                              ),
                              SizedBox(width: 3.0),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: CustomColors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),

                  // Add a fixed height or use Flexible to prevent unbounded height issues
                  CustomerFeedbackWidget(),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreetingSection() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(
            'Monday 26 July',
            style: TextStyle(
                color: CustomColors.darkGrey,
                fontSize: 15.0,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Hello, ',
                  style: TextStyle(
                    color: CustomColors.unSelectionColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 20.0,
                  ),
                ),
                TextSpan(
                  text: 'Salesman 1',
                  style: TextStyle(
                    color: CustomColors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width

    return Column(
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Add spacing between cards
          children: [
            _buildStatCard(TextString.customers, "96", CustomColors.lightRed,
                CustomColors.darkRedText, TextString.customerIcon, screenWidth),
            _buildStatCard(
                TextString.enquiries,
                "690",
                CustomColors.sandalColor,
                CustomColors.darkSandalColor,
                TextString.enquiryIcon,
                screenWidth),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Add spacing between cards
          children: [
            _buildStatCard(
                TextString.salesIconText,
                "356",
                CustomColors.whiteCard,
                CustomColors.unSelectionColor,
                TextString.salesIcon,
                screenWidth),
            _buildStatCard(
                TextString.payments,
                "96K",
                CustomColors.greenColor,
                CustomColors.darkGreenColor,
                TextString.paymentsIcon,
                screenWidth),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color color,
      Color textColor, String iconName, double screenWidth) {
    // Calculate card width based on screen size
    double cardWidth =
        (screenWidth / 2) - 25; // Subtract padding to prevent overflow

    return Container(
      width: cardWidth, // Set dynamic width
      height: 90,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  color: textColor),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                      color: textColor),
                ),
                Icon(
                  CustomIcons.getIconData(iconName),
                  color: textColor,
                  size: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopPerformersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${TextString.topPerformers} Jul - 2024',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17.0,
                        color: CustomColors.unSelectionColor),
                  ),
                  SizedBox(height: 2),
                  Text(
                    TextString.bestEmployees,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                      color: CustomColors.darkGrey,
                    ),
                  ),
                ],
              ),
            ),
            CustomTextButtonWithIcon(
              onTap: () {
                homeController.isExpanded.toggle();
              },
              text: [
                'Expand All',
                'Collapse All'
              ], // Provide texts for expanded and collapsed states
              icon: [
                Icons.keyboard_arrow_right,
                Icons.keyboard_arrow_down
              ], // Provide icons for both states
              isDynamic: true, // Enable dynamic behavior
              isExpanded:
                  homeController.isExpanded, // Pass the RxBool from the parent
            ),
          ],
        ),
        SizedBox(height: 12),
        Obx(() {
          if (homeController.isExpanded.value) {
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: homeController.topPerformers.length,
              itemBuilder: (context, index) {
                final performer = homeController.topPerformers[index];
                return Container(
                  height: 182, // Adjust height as needed

                  margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: _buildPerformerCard(performer),
                );
              },
            );
          } else {
            return SizedBox(
              height: 200, // Adjust height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: homeController.topPerformers.length,
                itemBuilder: (context, index) {
                  final performer = homeController.topPerformers[index];
                  return Container(
                    width: 250, // Adjust width for horizontal list
                    margin:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: _buildPerformerCard(performer),
                  );
                },
              ),
            );
          }
        }),
      ],
    );
  }

  Widget _buildPerformerCard(Performer performer) {
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: CustomColors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundedImage(
                  radius: 25.0, backgroundImageUrl: TextString.profilePath),
              SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    performer.name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    TextString.salesStaff,
                    style: TextStyle(
                      color: CustomColors.unSelectionColor,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Container(
            decoration: BoxDecoration(
              color: CustomColors
                  .lightBlueBackground, // Light background for stats
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatColumn(
                    TextString.enquiries, performer.enquiries.toString()),
                _buildStatColumn(
                    TextString.salesIconText, performer.sales.toString()),
                _buildStatColumn(TextString.payments, '${performer.payments}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          value,
          style: TextStyle(
            color: CustomColors.unSelectionColor,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
