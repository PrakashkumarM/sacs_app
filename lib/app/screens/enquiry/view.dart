import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/common/widgets/bottom_sheet.dart';
import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/core/utils/global_helper.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/data/controllers/card_expansion_controller.dart';
import 'package:sacs_app/app/data/models/enquiry_model.dart';
import 'package:sacs_app/app/screens/enquiry/controller.dart';
import 'package:sacs_app/app/screens/enquiry_form/view.dart';
import 'package:sacs_app/app/screens/make_sale/view.dart';
import 'package:sacs_app/app/common/widgets/grouped_date_list.dart';

class EnquiryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EnquiryController enquiryController = Get.put(EnquiryController());

    final CardExpansionController cardController =
        Get.put(CardExpansionController());

    return Obx(() {
      // This will rebuild the MainLayout whenever observable variables change
      final groupedEnquiries =
          _groupEnquiriesByDate(enquiryController.enquiries);
      final groupTitles = groupedEnquiries.keys.toList();

      return MainLayout(
        title: TextString.enquiry,
        showBackButton: false,
        isFilterAvailable: true,
        isSearchAvailable: true,
        showFloatingActionButton: true,
        mainFiltercontroller: enquiryController,
        openBuilderCallBack: () {
          return EnquiryForm();
        },
        onFabTap: () {},
        body: Obx(() {
          final groupedEnquiries =
              _groupEnquiriesByDate(enquiryController.enquiries);
          final groupTitles = groupedEnquiries.keys.toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Content above the list
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                  child: Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (enquiryController.startDate.value.isNotEmpty ||
                            enquiryController.endDate.value.isNotEmpty ||
                            enquiryController.status.value.isNotEmpty)
                          Text(
                            "Filtered by",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        Row(
                          children: [
                            // Example for displaying filter tags or text
                            // Date Range Chip
                            Obx(() {
                              String dateLabel = '';
                              if (enquiryController
                                      .startDate.value.isNotEmpty &&
                                  enquiryController.endDate.value.isNotEmpty) {
                                dateLabel =
                                    "${enquiryController.startDate.value} to ${enquiryController.endDate.value}";
                              } else if (enquiryController
                                  .startDate.value.isNotEmpty) {
                                dateLabel =
                                    "From ${enquiryController.startDate.value}";
                              } else if (enquiryController
                                  .endDate.value.isNotEmpty) {
                                dateLabel =
                                    "To ${enquiryController.endDate.value}";
                              }

                              return dateLabel.isNotEmpty
                                  ? Chip(
                                      side: BorderSide.none,
                                      label: Text(dateLabel),
                                      deleteIcon: Icon(
                                        Icons.close, // Use the desired icon
                                        size: 18, // Adjust the size if needed
                                        color: CustomColors
                                            .selectionColor, // Set the icon color
                                      ),
                                      backgroundColor: CustomColors
                                          .greyBgIcon, // Chip background color
                                      onDeleted: () {
                                        enquiryController.updateValue(
                                            enquiryController.startDate, '');
                                        enquiryController.updateValue(
                                            enquiryController.endDate, '');
                                        enquiryController.updateValue(
                                            enquiryController.tempStartDate,
                                            '');
                                        enquiryController.updateValue(
                                            enquiryController.tempEndDate, '');
                                      },
                                    )
                                  : SizedBox(); // Don't show the chip if no date is available
                            }),
                            SizedBox(width: 8),

                            // Status Chip
                            Obx(() {
                              return enquiryController.status.value.isNotEmpty
                                  ? Chip(
                                      side: BorderSide.none,
                                      label:
                                          Text(enquiryController.status.value),
                                      deleteIcon: Icon(
                                        Icons.close, // Use the desired icon
                                        size: 18, // Adjust the size if needed
                                        color: CustomColors
                                            .selectionColor, // Set the icon color
                                      ),
                                      backgroundColor: CustomColors
                                          .greyBgIcon, // Chip background color
                                      onDeleted: () {
                                        enquiryController.updateValue(
                                            enquiryController.status, '');
                                        enquiryController.updateValue(
                                            enquiryController.tempStatus, '');
                                      },
                                    )
                                  : SizedBox(); // Don't show the chip if no status is available
                            }),
                          ],
                        ),
                      ],
                    );
                  })),

              // Only show the list if there are grouped enquiries
              if (groupedEnquiries.isNotEmpty)
                Expanded(
                  // Ensure the list expands correctly within the layout
                  child: GroupedDateList(
                    itemCount: groupedEnquiries.entries.length,
                    groupTitles: groupTitles,
                    fetchData: enquiryController.fetchEnquiries,
                    pageLoading: enquiryController.isLoading,
                    itemBuilder: (context, dateIndex) {
                      final entry =
                          groupedEnquiries.entries.elementAt(dateIndex);
                      final enquiriesForDate = entry.value;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: enquiriesForDate.length,
                        itemBuilder: (context, enquiryIndex) {
                          final enquiry = enquiriesForDate[enquiryIndex];
                          final cardKey = (dateIndex * 100 + enquiryIndex);

                          return GestureDetector(
                            onTap: () {
                              cardController.toggleCardExpansion(cardKey);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Customer Name and Mobile
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  CustomColors.sandalColor,
                                              radius: 20,
                                              child: Icon(
                                                CustomIcons.user,
                                                color: CustomColors
                                                    .darkSandalColor,
                                              ),
                                            ),
                                            const SizedBox(width: 8.0),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  enquiry.customerName ??
                                                      'John Mathew',
                                                  style: TextStyle(
                                                    color: CustomColors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text(
                                                  enquiry.mobile ?? '987654123',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color:
                                                        CustomColors.darkGrey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // Enquiry Status
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0, horizontal: 8.0),
                                          decoration: BoxDecoration(
                                            color: enquiry.enquiryStatus
                                                        .toLowerCase() ==
                                                    'enquired'
                                                ? CustomColors.greenBadge
                                                : CustomColors.redBadge,
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border.all(
                                              color: enquiry.enquiryStatus
                                                          .toLowerCase() ==
                                                      'enquired'
                                                  ? CustomColors
                                                      .successLightBackground
                                                  : CustomColors
                                                      .dangerLightBackground,
                                            ),
                                          ),
                                          child: Text(
                                            GlobalHelper.capitalize(
                                                enquiry.enquiryStatus ??
                                                    'Status'),
                                            style: TextStyle(
                                              color: enquiry.enquiryStatus
                                                          .toLowerCase() ==
                                                      'enquired'
                                                  ? CustomColors.successDarktext
                                                  : CustomColors.darkRedText,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12.0),
                                    // Additional rows for Enquired By, Branch, etc.
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Enquired By',
                                              style: TextStyle(
                                                  color: CustomColors.darkGrey,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              enquiry.enquiredBy ?? 'Richard',
                                              style: TextStyle(
                                                  color: CustomColors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Branch',
                                              style: TextStyle(
                                                  color: CustomColors.darkGrey,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              enquiry.branch,
                                              style: TextStyle(
                                                  color: CustomColors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              if (groupedEnquiries.isEmpty)
                Center(child: Text('No enquiries found')) // Handle empty data
            ],
          );
        }),
      );
    });
  }
}

Widget _buildExpandedSection(BuildContext context) {
  final EnquiryController controller = Get.put(EnquiryController());
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Column(
      children: [
        Divider(
          height: 1,
          color: CustomColors.borderGrey,
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionButton(
                CustomIcons.tablerMessage,
                TextString.comments,
                () => {
                      _showBottomSheet(
                          context,
                          TextString.comments,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                                'The customer may purchase these enquired products within next week (29/02/2024)'),
                          ))
                    }),
            _buildActionButton(CustomIcons.editPencil, TextString.edit,
                () => {NavigationHelper.navigateToScreen(EnquiryForm())}),
            _buildActionButton(Icons.shopping_cart, TextString.sale,
                () => {NavigationHelper.navigateToScreen(MakeSalesPage())}),
            _buildActionButton(
                Icons.remove_red_eye,
                TextString.details,
                () => {
                      _showBottomSheet(
                          context,
                          TextString.showDetails,
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                  child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.4, // Max height of 50% of screen
                                      ),
                                      child: ListView.builder(
                                          shrinkWrap:
                                              true, // Allows the ListView to shrink based on content size
                                          itemCount:
                                              8, // Replace with dynamic item count
                                          itemBuilder: (context, index) {
                                            return Card(
                                              color: CustomColors
                                                  .mildSkyblueBg, // Custom background color
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12), // Rounded corners
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // The title at the top (e.g., Home Theatre/Soundbar)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Text(
                                                      'Home Theatre/Soundbar',
                                                      style: TextStyle(
                                                        color: CustomColors
                                                            .invoiceNoBlueColor, // Custom blue color
                                                        fontSize: 15,
                                                        fontWeight: FontWeight
                                                            .w600, // Title is bold
                                                      ),
                                                    ),
                                                  ),
                                                  // Space between title and divider
                                                  Divider(
                                                    height: 1,
                                                    color: CustomColors
                                                        .dividerLightBlue
                                                        .withOpacity(0.5),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          12), // Space after the divider
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 12.0,
                                                            left: 12,
                                                            bottom: 12),
                                                    child: Row(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Brand',
                                                              style: TextStyle(
                                                                color:
                                                                    CustomColors
                                                                        .grey,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 12,
                                                            ),
                                                            Text(
                                                              'Product',
                                                              style: TextStyle(
                                                                color:
                                                                    CustomColors
                                                                        .grey,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 12,
                                                            ),
                                                            Text(
                                                              'Price',
                                                              style: TextStyle(
                                                                color:
                                                                    CustomColors
                                                                        .grey,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Zebronics',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            SizedBox(
                                                              height: 12,
                                                            ),
                                                            Text(
                                                              '2.1',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            SizedBox(
                                                              height: 12,
                                                            ),
                                                            Text(
                                                              '3400',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),

                                                  // Brand row
                                                ],
                                              ),
                                            );
                                          })))
                            ],
                          ))
                    }),
            _buildActionButton(CustomIcons.close, TextString.close,
                () => {controller.showCloseEnquiryDialog(context)},
                iconColor: CustomColors.selectionColor),
          ],
        ),
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

void _showBottomSheet(BuildContext context, String title, Widget content) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return CustomBottomSheet(title: title, content: content);
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
