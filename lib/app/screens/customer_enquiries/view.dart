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
                    Column(
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
                        const SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: CustomColors.selectionColor,
                              size: 16.0,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              "TownHall - Madurai",
                              style: TextStyle(color: CustomColors.grey),
                            )
                          ],
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
