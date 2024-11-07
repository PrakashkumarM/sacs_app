import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/common/widgets/date_header.dart';
import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/common/widgets/rounded_image.dart';
import 'package:sacs_app/app/common/widgets/text_button_with_icon.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/data/controllers/user_controller.dart';
import 'package:sacs_app/app/data/models/dashboard_model.dart';
import 'package:sacs_app/app/screens/customer_feedback/view.dart';
import 'package:sacs_app/app/screens/dashboard/controller.dart';
import 'package:sacs_app/app/screens/followup/view.dart';
import 'package:sacs_app/app/screens/home/contoller.dart';
import 'package:sacs_app/app/screens/home/widgets/customer_feedback_widget.dart';
import 'package:sacs_app/app/screens/home/widgets/followup_card.dart';
import 'package:sacs_app/app/screens/home/widgets/search_widget.dart';
import 'package:sacs_app/app/screens/home/widgets/team_achivement.dart';
import 'package:sacs_app/app/screens/sales_list/view.dart';
import 'package:sacs_app/app/screens/sales_list/widgets/invoice_detail.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController homeController = Get.put(HomeController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      onProfileTap: homeController.profileTap,
      onLogoutTap: homeController.logout,
      isDashboard: true,
      stepperAvailable: false,
      body: Column(
        children: [
          // Search bar (non-scrollable)
          Obx(() {
            if (userController.isSalesRole.value) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: SearchWidget(),
              );
            } else {
              return SizedBox
                  .shrink(); // Or any other widget for non-sales roles
            }
          }),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGreetingSection(),
                  const SizedBox(height: 12),
                  _buildStatisticsSection(context),
                  const SizedBox(height: 24),
                  Obx(() {
                    if (userController.isSalesRole.value) {
                      return Column(
                        children: [
                          // Team Achievements section
                          _teamAchievementsWidget(
                              homeController: homeController),
                          const SizedBox(height: 24),

                          // Followup Reminder section
                          _followUpWidget(homeController: homeController),
                          const SizedBox(height: 24),

                          _buildTopPerformersSection(), // Scrollable part
                          const SizedBox(height: 24),

                          if (homeController.customerFeedback.isNotEmpty) ...[
                            // Customer Feedback
                            _customerFeedbackTitle(),
                            const SizedBox(height: 6),
                            // Add a fixed height or use Flexible to prevent unbounded height issues
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: CustomerFeedbackWidget(
                                controller: homeController,
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ],
                      );
                    } else {
                      return salesListWidget(homeController: homeController);
                    }
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreetingSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              'Monday 26 July',
              style: TextStyle(
                  color: CustomColors.darkGrey,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 4),
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
                  const TextSpan(
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
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsSection(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final dashboardData = homeController.dashboardWidgets;
    final UserController userController =
        Get.find<UserController>(); // Get user data

    // Define card data based on roles
    List<Map<String, dynamic>> salesCards = [
      {
        'title': TextString.target,
        'value': '${dashboardData.value.target}',
        'color': CustomColors.greenColor,
        'textColor': CustomColors.darkGreenColor,
        'icon': TextString.customerIcon
      },
      {
        'title': TextString.achievement,
        'value': '${dashboardData.value.achievement}',
        'color': CustomColors.sandalColor,
        'textColor': CustomColors.darkSandalColor,
        'icon': TextString.medal
      },
      {
        'title': TextString.followUpReminder,
        'value': '${dashboardData.value.followUpReminder}',
        'color': CustomColors.whiteCard,
        'textColor': CustomColors.unSelectionColor,
        'icon': TextString.notification
      },
      {
        'title': TextString.enquiries,
        'value': '${dashboardData.value.achievement}',
        'color': CustomColors.lightRed,
        'textColor': CustomColors.darkRedText,
        'icon': TextString.enquiryIcon
      },
    ];

    List<Map<String, dynamic>> warehouseCards = [
      {
        'title': TextString.delivered,
        'value': '${dashboardData.value.delivered}',
        'color': CustomColors.greenColor,
        'textColor': CustomColors.darkGreenColor,
        'icon': TextString.truckDelivery
      },
      {
        'title': TextString.readyForDelivery,
        'value': '${dashboardData.value.readyForDelivery}',
        'color': CustomColors.sandalColor,
        'textColor': CustomColors.darkSandalColor,
        'icon': TextString.paymentsIcon
      }
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Obx(() {
            List<Map<String, dynamic>> selectedCards;

            // Check user role and select appropriate cards
            if (userController.isSalesRole.value) {
              selectedCards = salesCards;
            } else {
              selectedCards = warehouseCards;
            }

            return GridView.builder(
              shrinkWrap: true,
              itemCount: selectedCards.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.8,
              ),
              physics:
                  NeverScrollableScrollPhysics(), // Disable scrolling inside grid
              itemBuilder: (context, index) {
                var card = selectedCards[index];
                return _buildStatCard(
                  card['title'],
                  card['value'],
                  card['color'],
                  card['textColor'],
                  card['icon'],
                  screenWidth,
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color,
      Color textColor, String iconName, double screenWidth) {
    return SizedBox(
      height: 120, // Set a fixed height for the card
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcons.getIconData(iconName),
                    color: textColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(), // Optional for dynamic spacing
              Text(
                value,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopPerformersSection() {
    if (homeController.topPerformers.length == 0) {
      return SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
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
                    const SizedBox(height: 2),
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
                isExpanded: homeController
                    .isExpanded, // Pass the RxBool from the parent
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Obx(() {
          if (homeController.isExpanded.value) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: homeController.topPerformers.length,
              itemBuilder: (context, index) {
                final performer = homeController.topPerformers[index];
                return Container(
                  height: 182, // Adjust height as needed
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: _buildPerformerCard(performer),
                );
              },
            );
          } else {
            return SizedBox(
              height: 200, // Adjust height as needed
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                scrollDirection: Axis.horizontal,
                itemCount: homeController.topPerformers.length,
                itemBuilder: (context, index) {
                  final performer = homeController.topPerformers[index];
                  return Container(
                    width: 250, // Adjust width for horizontal list
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
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

  Widget _buildPerformerCard(performer) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: CustomColors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2), // Shadow position
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
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    performer.employeeName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  const SizedBox(height: 4.0),
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
          const SizedBox(height: 16.0),
          Container(
            decoration: BoxDecoration(
              color: CustomColors
                  .lightBlueBackground, // Light background for stats
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 4.0),
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

// ignore: camel_case_types
class _customerFeedbackTitle extends StatelessWidget {
  const _customerFeedbackTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Waiting For Customer\nFeedback',
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: CustomColors.selectionColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
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
    );
  }
}

class _followUpWidget extends StatelessWidget {
  const _followUpWidget({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    if (homeController.followUpReminderList.length == 0) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: CustomColors.selectionColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
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
          const SizedBox(height: 6),
          Obx(() {
            return Card(
              color: CustomColors.white,
              elevation: 2,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
                        homeController.followUpReminderList.length - 1 == index,
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

class salesListWidget extends StatelessWidget {
  const salesListWidget({
    super.key,
    required this.homeController,
  });

  final homeController;

  @override
  Widget build(BuildContext context) {
    final DashboardController dashboardController =
        Get.find<DashboardController>();

    return Obx(() {
      if (homeController.salesList.isEmpty) {
        return SizedBox.shrink();
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  TextString.rfdList,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                      color: CustomColors.black),
                ),
                InkWell(
                  onTap: () {
                    dashboardController.changeTabIndex(1);
                    // NavigationHelper.navigateTo(TextString.dashboard,
                    //     arguments: {'tabIndex': 1});
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: CustomColors.selectionColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
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
            const SizedBox(height: 6),
            Obx(() {
              return GroupedListView<ReadyForDelivery, String>(
                shrinkWrap: true,
                elements: homeController.salesList.toList(),
                groupBy: (ReadyForDelivery element) => element.date,
                groupSeparatorBuilder: (String groupByValue) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: DateHeader(
                      groupByValue: groupByValue,
                    ),
                  ),
                ),
                itemBuilder: (context, ReadyForDelivery element) => Column(
                  children: [
                    InvoiceDetailsWidget(
                      invoiceNumber: element.invoiceNo,
                      deliveryType: element.deliveryType,
                      deliveryCharge: element.deliveryCharge,
                      totalProduct: element.totalProduct,
                      onDownloadInvoice: () {
                        print("Download Invoice clicked");
                      },
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
                itemComparator:
                    (ReadyForDelivery item1, ReadyForDelivery item2) =>
                        item1.invoiceNo.compareTo(item2.invoiceNo),
                useStickyGroupSeparators: true,
                floatingHeader: true,
                order: GroupedListOrder.ASC,
              );
            }),
          ],
        ),
      );
    });
  }
}

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
