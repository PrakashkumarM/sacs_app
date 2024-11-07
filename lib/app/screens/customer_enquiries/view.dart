import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/screens/customer_enquiries/controller.dart';
import 'package:sacs_app/app/screens/enquiry_form/view.dart';
import 'package:sacs_app/app/screens/sale_form/view.dart';

class CustomerEnquiries extends StatelessWidget {
  final CustomerEnquiriesController controller =
      Get.put(CustomerEnquiriesController());

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: TextString.customerEnquiries,
      showBackButton: false,
      isFilterAvailable: true,
      isSearchAvailable: true,
      body: _buildEnquiryUI(context),
      showFloatingActionButton: true, // Display the FAB
      openBuilderCallBack: () {
        return EnquiryForm();
      },
    );
  }

  Widget _buildEnquiryUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
        ),
        // Customer Information
        const Center(
          child: Column(
            children: [
              Text(
                'John Mathew',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CustomIcons.call,
                    size: 15,
                    color: CustomColors.grey,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    '9876543210',
                    style: TextStyle(color: CustomColors.grey, fontSize: 13),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
        SizedBox(
          height: 24,
        ),
        // Enquiry / Sale Toggle Buttons with rounded corners and animation
        Container(
          decoration: BoxDecoration(
            color:
                CustomColors.lightGrey, // Background color for the button area
            borderRadius: BorderRadius.circular(
                20), // Rounded corners for the entire container
            boxShadow: [
              BoxShadow(
                color: CustomColors.lightGrey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              // Enquiry Button
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.isEnquirySelected(true);
                  },
                  child: Obx(
                    () => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: controller.isEnquirySelected.value
                            ? CustomColors.selectionColor
                            : CustomColors.lightGrey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(
                              controller.isEnquirySelected.value ? 20 : 0),
                          bottomRight: Radius.circular(
                              controller.isEnquirySelected.value ? 20 : 0),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: Text(
                          'Enquiry',
                          style: TextStyle(
                            color: controller.isEnquirySelected.value
                                ? Colors.white
                                : Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Sale Button
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.isEnquirySelected(false);
                  },
                  child: Obx(
                    () => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: !controller.isEnquirySelected.value
                            ? CustomColors.selectionColor
                            : CustomColors.lightGrey,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(
                              !controller.isEnquirySelected.value ? 20 : 0),
                          bottomLeft: Radius.circular(
                              !controller.isEnquirySelected.value ? 20 : 0),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: Text(
                          'Sale',
                          style: TextStyle(
                            color: !controller.isEnquirySelected.value
                                ? Colors.white
                                : Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 36),

        // Card with enquiry information and actions
        Card(
          color: CustomColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Enquired By
                Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enquired By',
                          style: TextStyle(color: CustomColors.grey),
                        ),
                        Text(
                          'Richard',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: CustomColors.greenBadge,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Enquired',
                        style: TextStyle(
                            color: CustomColors.darkGreenColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Divider(
                  color: CustomColors.lightGrey.withOpacity(0.5),
                  height: 1,
                ),
                const SizedBox(height: 16),

                // Action buttons: Add Comments, Sale, Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildActionItem(Icons.comment, 'Add Comments', () {}),
                    _buildActionItem(Icons.shopping_cart, 'Sale', () {
                      NavigationHelper.navigateToScreen(EnquiryForm());
                    }),
                    _buildActionItem(Icons.remove_red_eye, 'Details', () {}),
                  ],
                ),
                const SizedBox(height: 16),

                Divider(
                  color: CustomColors.lightGrey.withOpacity(0.5),
                  height: 1,
                ),
                const SizedBox(height: 16),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: CustomColors.selectionColor,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "TownHall - Madurai",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionItem(IconData icon, String label, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.grey,
            size: 16,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
