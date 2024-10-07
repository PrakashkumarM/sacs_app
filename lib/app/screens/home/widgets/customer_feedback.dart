import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/data/models/enquiry_model.dart';
import 'package:sacs_app/app/screens/sales/controller.dart';

class CustomerFeedbackWidget extends StatelessWidget {
  final SalesScreenController controller = Get.put(SalesScreenController());

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

  @override
  Widget build(BuildContext context) {
    return GroupedListView<dynamic, String>(
      shrinkWrap: true,
      elements: _elements,
      groupBy: (element) => element['group'],
      groupSeparatorBuilder: (String groupByValue) =>
          _buildGroupSeparator(groupByValue),
      itemBuilder: (context, dynamic element) => _buildFeedbackCard(element),
      itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']),
      useStickyGroupSeparators: true,
      floatingHeader: true,
      order: GroupedListOrder.ASC,
    );
  }

  Widget _buildGroupSeparator(String groupByValue) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
    );
  }

  Widget _buildFeedbackCard(dynamic element) {
    return Card(
      color: CustomColors.white,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFeedbackInfo(element),
            _buildActionButtons(element['invoice']),
          ],
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

  Row _buildActionButtons(String invoice) {
    return Row(
      children: [
        _buildCircularIcon(
          icon: CustomIcons.call,
          backgroundColor: CustomColors.greenBadge,
          iconColor: CustomColors.successDarktext,
          onTap: () {
            controller.makePhoneCall(Uri(scheme: 'tel', path: '9876543210'));
          },
        ),
        SizedBox(width: 5),
        _buildCircularIcon(
          icon: Icons.message,
          backgroundColor: CustomColors.mildSkyblueBg,
          iconColor: CustomColors.invoiceNoBlueColor,
          onTap: () {
            // Handle message action here
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
