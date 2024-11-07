import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/common/widgets/serial_image_widget.dart';
import 'package:sacs_app/app/core/utils/global_helper.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';

import 'package:sacs_app/app/screens/customer_products/controller.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CustomerProductsController controller =
        Get.put(CustomerProductsController());

    if (controller.products.isEmpty) {
      return Center(child: Text('No products available.'));
    }
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.products.length,
              itemBuilder: (context, index) => _buildProductCard(
                  controller.products[index], controller, index, context),
            ),
            SizedBox(
              height: 24,
            ),
            _buildDeliveryChargeInput(),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product,
      CustomerProductsController controller, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          // Unfocus the TextFormField when tapping on the AnimatedContainer
          GlobalHelper.textFocusLoss(context);
          controller.toggleCardExpansion(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: CustomColors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductHeader(product),
                const SizedBox(height: 8),
                _buildProductDetails(product),
                Obx(() {
                  return SizeTransition(
                    sizeFactor: controller.expandAnimation,
                    axisAlignment: 1.0,
                    child: controller.expandedCardIndex.value == index
                        ? _buildExpandedSection(product, controller, context)
                        : const SizedBox.shrink(),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductHeader(Map<String, dynamic> product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            product['name'],
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
              color: CustomColors.productBadgeBackgroundColor,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color: CustomColors.productBadgeBackgroundColor,
              )),
          child: Text(
            product['status'],
            style: TextStyle(
                fontSize: 12,
                color: CustomColors.productBadgeColor,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildProductDetails(Map<String, dynamic> product) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: CustomColors.mildSkyblueBg,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDetailColumn(TextString.price, product['price']),
          _buildDetailColumn(TextString.type, product['type']),
          _buildDetailColumn(TextString.serialNo, product['serialNumber']),
        ],
      ),
    );
  }

  Widget _buildDetailColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildExpandedSection(
      Map<String, dynamic> product, controller, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatusBox(
              "Delivery Status",
              "Ready For Delivery",
              CustomColors.successLightBackground,
              CustomColors.darkGreenColor, // Text color
              CustomIcons.truckDelivery, // Icon
            ),
            const SizedBox(width: 8),
            _buildStatusBox(
              "Delivery Payment",
              "Company (₹ 500",
              CustomColors.badgeBackgroundBlue,
              CustomColors.invoiceNoBlueColor, // Text color
              CustomIcons.rupeeBag, // Icon
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Row(
          children: [
            Icon(Icons.location_on, color: Colors.red),
            SizedBox(width: 5),
            Expanded(
              child: Text(
                '2nd, Cross Street, Arapalayam, Madurai - 625017',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
        Container(
          height: 1,
          // width: 1,
          color: CustomColors.borderGrey,
        ),
        SizedBox(height: 24),
        Column(
          children: [
            SizedBox(
              width: double.infinity, // Full width for the first button
              child: GestureDetector(
                onTap: () {
                  // Approve delivery logic
                  showSerialNumberBottomSheet(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: CustomColors.lightGrey, // Button background color
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'Show Serial Image',
                    style: TextStyle(
                      color: CustomColors.darkGrey, // Text color
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8), // Spacing between the two buttons
            SizedBox(
              width: double.infinity, // Full width for the second button
              child: GestureDetector(
                onTap: () {
                  // Show image logic
                  controller.showDeliveryApproval(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        CustomColors.bgGreenButton, // Button background color
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'Delivery Approval',
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusBox(
      String title, String value, Color color, Color textColor, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: color.withOpacity(0.2),
          border: Border.all(color: textColor.withOpacity(0.2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: textColor, size: 16), // Add icon here
              const SizedBox(width: 6),

              Text(title, style: TextStyle(fontSize: 12, color: textColor)),
            ],
          ), // Apply text color here
          const SizedBox(height: 4),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: textColor)), // Apply text color here
        ],
      ),
    );
  }

  Widget _buildDeliveryChargeInput() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Align the label to the left
      children: [
        const Text(
          "Delivery Charge", // You can replace this with TextString.deliveryCharge
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 8), // Space between label and input
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: CustomColors.borderGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: CustomColors.borderGrey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: CustomColors.borderGrey),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                // Handle apply delivery charge
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: CustomColors.selectionColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  TextString.submit, // Replace with the appropriate constant
                  style: TextStyle(color: CustomColors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildApproveSection(controller, context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, -2), // shadow upwards
          ),
        ],
      ),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              // Handle "Approve All" button press
              controller.showDeliveryApproval(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.selectionColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
              minimumSize: const Size.fromHeight(48), // Make button wide
            ),
            icon: const Icon(Icons.check, color: Colors.white),
            label: const Text(
              'Approve All',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please click the button to approve all the items are delivered',
            style: TextStyle(color: Colors.grey, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
