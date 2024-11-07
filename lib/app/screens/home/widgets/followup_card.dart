import 'package:flutter/material.dart';

import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/core/utils/global_helper.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/screens/customer_enquiries/view.dart';

class FollowUpCard extends StatelessWidget {
  final String name;
  final String date;
  final String mobile;
  final int index;
  final dynamic controller;
  final openProductDetails;
  final bool isLastIndex;

  final colorList = [
    {
      'lightColor': CustomColors.lightRed,
      'darkColor': CustomColors.darkRedText,
    },
    {
      'lightColor': CustomColors.sandalColor,
      'darkColor': CustomColors.darkSandalColor,
    },
    {
      'lightColor': CustomColors.invoiceNoBlueColor,
      'darkColor': CustomColors.badgeBackgroundBlue,
    },
  ];
  // Method to get color based on parent index
  Map<String, Color> getColorByIndex(int parentIndex) {
    final int index = parentIndex % colorList.length;
    return colorList[index];
  }

  FollowUpCard({
    required this.name,
    required this.date,
    required this.mobile,
    required this.index,
    required this.controller,
    this.openProductDetails,
    this.isLastIndex = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('isLastIndex:$isLastIndex');
    final currentColor =
        (index > 2 ? getColorByIndex(index) : colorList[index]);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        onTap: () {
          controller.showBottomSheet(
            context,
            'Product Details',
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height *
                          0.4, // Max height of 50% of screen
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // Align items at the start
                        children: [
                          Text(
                            "Product Name",
                            style: TextStyle(
                                color: CustomColors.grey, fontSize: 13),
                          ),
                          SizedBox(width: 20),
                          Flexible(
                            child: Text(
                              "Home Theater/Soundbar voltas 1.5 ton",
                              style: TextStyle(
                                  color: CustomColors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                              maxLines:
                                  2, // Allows text to break into two lines
                              overflow: TextOverflow
                                  .ellipsis, // Adds ellipsis if it overflows
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              border: isLastIndex
                  ? null
                  : Border(
                      bottom: BorderSide(
                          width: 1,
                          color: CustomColors.borderGrey.withOpacity(0.5)))),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: currentColor['lightColor'],
              child: Icon(CustomIcons.user, color: currentColor['darkColor']),
            ),
            title: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            subtitle: Text(
              date,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: CustomColors.grey,
              ),
            ),
            trailing: _buildTrailingIcons(controller),
          ),
        ),
      ),
    );
  }

  Widget _buildTrailingIcons(controller) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCircularIcon(CustomColors.greenBadge, CustomIcons.call,
            CustomColors.successDarktext, () {
          GlobalHelper.makePhoneCall(Uri(scheme: 'tel', path: '9876543210'));
        }),
        SizedBox(width: 4),
        _buildCircularIcon(CustomColors.mildSkyblueBg, Icons.visibility,
            CustomColors.invoiceNoBlueColor, () {
          NavigationHelper.navigateToScreen(CustomerEnquiries());
        }),
      ],
    );
  }

  Widget _buildCircularIcon(
      Color bgColor, IconData icon, Color iconColor, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 20,
          color: iconColor,
        ),
      ),
    );
  }
}
