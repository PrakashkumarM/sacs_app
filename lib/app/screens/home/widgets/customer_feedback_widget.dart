import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/common/widgets/date_header.dart';
import 'package:sacs_app/app/core/utils/global_helper.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';

class CustomerFeedbackWidget extends StatelessWidget {
  final dynamic controller;

  final List<Map<String, dynamic>> _elements = [
    {'name': 'John Mathew', 'invoice': '#8rg28384-0001', 'group': '10-09-2024'},
    {
      'name': 'John Mathew Richard',
      'invoice': '#8ab28384-0500',
      'group': '10-09-2024'
    },
    {
      'name': 'John Mathew Richard',
      'invoice': '#8cd28584-0001',
      'group': '10-09-2024'
    },
    // Add more elements as needed
  ];
  CustomerFeedbackWidget({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GroupedListView<dynamic, String>(
      shrinkWrap: true,
      elements: _elements,
      groupBy: (element) => element['group'],
      groupSeparatorBuilder: (String groupByValue) =>
          DateHeader(groupByValue: groupByValue),
      itemBuilder: (context, dynamic element) =>
          _buildFeedbackCard(context, element),
      itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']),
      useStickyGroupSeparators: true,
      floatingHeader: true,
      order: GroupedListOrder.ASC,
    );
  }

  Widget _buildGroupSeparator(String groupByValue) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6),
          decoration: BoxDecoration(
            color: CustomColors.lightRed,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            groupByValue,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: CustomColors.darkGrey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackCard(BuildContext context, dynamic element) {
    return GestureDetector(
      onTap: () {
        controller.showBottomSheet(
          context,
          'Product Details',
          Column(
            mainAxisSize:
                MainAxisSize.min, // Let the column size based on content
            children: [
              Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height *
                        0.4, // Max height of 50% of screen
                  ),
                  child: ListView.builder(
                    shrinkWrap:
                        true, // Allows the ListView to shrink based on content size
                    itemCount: 8, // Replace with dynamic item count
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Product Name",
                                    style: TextStyle(
                                      color: CustomColors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    "Home Theater/Soundbar voltas 1.5 ton",
                                    style: TextStyle(
                                      color: CustomColors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Serial no",
                                    style: TextStyle(
                                      color: CustomColors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    "787877784",
                                    style: TextStyle(
                                      color: CustomColors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: Card(
        color: CustomColors.white,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFeedbackInfo(element),
              _buildActionButtons(context, element['invoice']),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildFeedbackInfo(dynamic element) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          element['name'],
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 3),
        Row(
          children: [
            Text(TextString.invoice),
            SizedBox(width: 3),
            Text(
              element['invoice'],
              style: TextStyle(color: CustomColors.invoiceNoBlueColor),
            ),
          ],
        ),
      ],
    );
  }

  Row _buildActionButtons(context, String invoice) {
    return Row(
      children: [
        _buildCircularIcon(
          icon: CustomIcons.call,
          backgroundColor: CustomColors.greenBadge,
          iconColor: CustomColors.successDarktext,
          onTap: () {
            GlobalHelper.makePhoneCall(Uri(scheme: 'tel', path: '9876543210'));
          },
        ),
        SizedBox(width: 5),
        _buildCircularIcon(
          icon: Icons.message,
          backgroundColor: CustomColors.mildSkyblueBg,
          iconColor: CustomColors.invoiceNoBlueColor,
          onTap: () {
            // Handle message action here
            controller.showCustomerFeedback(context);
          },
        ),
      ],
    );
  }

  Widget _buildCircularIcon({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 16,
          color: iconColor,
        ),
      ),
    );
  }
}
