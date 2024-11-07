import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/screens/customer_products/controller.dart';
import 'package:sacs_app/app/screens/customer_products/widgets/customer_details.dart';
import 'package:sacs_app/app/screens/customer_products/widgets/product_list.dart';

class CustomerProducts extends StatelessWidget {
  CustomerProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomerProductsController controller =
        Get.put(CustomerProductsController());

    return MainLayout(
      title: TextString.customerProducts,
      showBackButton: true,
      stepperAvailable: false,
      showFloatingActionButton: false,
      body: Column(
        children: [
          // Header Part
          CustomerDetails(
              customerName: 'John Mathew', customerMobile: '8714587452'),

          // Product List section
          // Expanded(child: _buildProductList(controller, context)),
          ProductList(),

          // Approve Button
          _buildApproveSection(
              controller, context), // Add this section at the bottom
        ],
      ),
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
