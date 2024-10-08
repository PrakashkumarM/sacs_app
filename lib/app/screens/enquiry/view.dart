import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/common/widgets/bottom_sheet.dart';
import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/data/models/enquiry_model.dart';
import 'package:sacs_app/app/screens/enquiry/controller.dart';
import 'package:sacs_app/app/screens/enquiry_form/view.dart';
import 'package:sacs_app/app/screens/make_sale/view.dart';
import 'package:sacs_app/app/common/widgets/grouped_date_list.dart';

class EnquiryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EnquiryController controller = Get.put(EnquiryController());

    return MainLayout(
      title: TextString.enquiry,
      showBackButton: false,
      isFilterAvailable: true,
      isSearchAvailable: true,
      showFloatingActionButton: true,
      openBuilderCallBack: () {
        return EnquiryForm();
      },
      onFabTap: () {
        // NavigationHelper.navigateToScreen(EnquiryForm());
      },
      body: Obx(() {
        final groupedEnquiries = _groupEnquiriesByDate(controller.enquiries);
        final groupTitles = groupedEnquiries.keys.toList();

        return GroupedDateList(
          itemCount: groupedEnquiries.entries.length, // Number of date groups
          groupTitles: groupTitles, // List of date group titles
          fetchData: controller.fetchEnquiries, // Fetch more data on scroll
          pageLoading: controller.isLoading, // Handle pagination loading
          itemBuilder: (context, dateIndex) {
            final entry = groupedEnquiries.entries.elementAt(dateIndex);
            final enquiriesForDate = entry.value;

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: enquiriesForDate.length,
              itemBuilder: (context, enquiryIndex) {
                final enquiry = enquiriesForDate[enquiryIndex];
                final cardKey =
                    (dateIndex * 100 + enquiryIndex); // Unique card ID

                return Obx(() {
                  return GestureDetector(
                    onTap: () {
                      controller.toggleCardExpansion(cardKey);
                    },
                    child: Card(
                      elevation: 4.0,
                      color: CustomColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    enquiry.productName ?? 'Product Name',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color: enquiry.enquiryStatus == 'Enquired'
                                        ? CustomColors.greenBadge
                                        : CustomColors.redBadge,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Text(
                                    enquiry.enquiryStatus ?? 'Status',
                                    style: TextStyle(
                                      color: enquiry.enquiryStatus == 'Enquired'
                                          ? CustomColors.successDarktext
                                          : CustomColors.darkRedText,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(CustomIcons.user,
                                    color: CustomColors.grey),
                                const SizedBox(width: 4.0),
                                Text(
                                  enquiry.customerName ?? 'N/A',
                                  style: TextStyle(
                                    color: CustomColors.darkGrey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Spacer(),
                                Icon(CustomIcons.call,
                                    color: CustomColors.grey),
                                const SizedBox(width: 4.0),
                                Text(
                                  enquiry.mobile ?? 'N/A',
                                  style: TextStyle(
                                    color: CustomColors.darkGrey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            // Expanded section with animation
                            SizeTransition(
                              sizeFactor: controller.expandAnimation,
                              axisAlignment: 1.0,
                              child:
                                  controller.expandedCardIndex.value == cardKey
                                      ? _buildExpandedSection(context)
                                      : SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
              },
            );
          },
        );
      }),
    );
  }

  Widget _buildExpandedSection(BuildContext context) {
    final EnquiryController controller = Get.put(EnquiryController());
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(CustomIcons.tablerMessage, TextString.comments,
              () => {_showBottomSheet(context, TextString.comments)}),
          _buildActionButton(CustomIcons.editPencil, TextString.edit,
              () => {NavigationHelper.navigateToScreen(EnquiryForm())}),
          _buildActionButton(Icons.shopping_cart, TextString.sale,
              () => {NavigationHelper.navigateToScreen(MakeSalesPage())}),
          _buildActionButton(Icons.remove_red_eye, TextString.details,
              () => {_showBottomSheet(context, TextString.details)}),
          _buildActionButton(CustomIcons.close, TextString.close,
              () => {controller.showCloseEnquiryDialog(context)},
              iconColor: CustomColors.selectionColor),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, onIconTap,
      {Color iconColor = CustomColors.grey}) {
    final EnquiryController controller = Get.put(EnquiryController());

    return Column(
      children: [
        GestureDetector(
          onTap: onIconTap,
          child: Container(
            decoration: BoxDecoration(
              color: iconColor == CustomColors.selectionColor
                  ? CustomColors.lightRed
                  : CustomColors.lightGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: iconColor,
              size: 15.0,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  void _showBottomSheet(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CustomBottomSheet(
          title: title,
          content: Text(
            'Here is the content for $title.',
            style: TextStyle(fontSize: 16),
          ),
        );
      },
    );
  }

  Map<String, List<Enquiry>> _groupEnquiriesByDate(List<Enquiry> enquiries) {
    final Map<String, List<Enquiry>> groupedEnquiries = {};

    for (var enquiry in enquiries) {
      final date = enquiry.enquiryDate ?? 'Unknown Date';
      if (!groupedEnquiries.containsKey(date)) {
        groupedEnquiries[date] = [];
      }
      groupedEnquiries[date]!.add(enquiry);
    }

    return groupedEnquiries;
  }
}
