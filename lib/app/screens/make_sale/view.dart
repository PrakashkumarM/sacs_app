import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/screens/make_sale/controller.dart';
import 'package:sacs_app/app/screens/make_sale/widgets/sale_item_widget.dart';

class MakeSalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MakeSalesController controller = Get.put(MakeSalesController());

    return MainLayout(
      title: TextString.makeSales,
      showBackButton: true,
      showFloatingActionButton: false,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                       Text(
                        '${TextString.saleDate} ',
                        style: TextStyle(color: CustomColors.selectionColor),
                      ),
                      const Text('*'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate:
                            controller.selectedDate.value ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null) {
                        controller.setDate(picked);
                      }
                    },
                    child: AbsorbPointer(
                      child: Obx(() {
                        return TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.calendar_today),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                          controller: TextEditingController(
                            text: controller.selectedDate.value != null
                                ? '${controller.selectedDate.value!.day}-${controller.selectedDate.value!.month}-${controller.selectedDate.value!.year}'
                                : TextString.selectDate,
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SaleItemWidget(
                    title: 'Television | Samsung | TV | 42"',
                    price: '₹ 69,000',
                    serialNumber: 'A0c1715821',
                    status: 'Warehouse',
                  ),
                  const SizedBox(height: 16),
                  SaleItemWidget(
                    title: 'Washing Machine | Haier | 9Kg',
                    price: '₹ 69,000',
                    serialNumber: '78521874100',
                    status: 'Warehouse',
                  ),
                  const SizedBox(height: 16),
                  SaleItemWidget(
                    title: 'Bajaj Frore | Fan | 1200 mm',
                    price: '₹ 1,000',
                    serialNumber: '78521874187',
                    status: 'On Shop',
                  ),
                  const SizedBox(height: 16),
                  const Text(TextString.deliveryCharge),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controller.chargeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Cancel action here
                      NavigationHelper.goBack();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.lightGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(TextString.cancel,
                        style: TextStyle(color: CustomColors.black)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Submit action here
                      NavigationHelper.navigateAndClearStack(
                          TextString.dashboard,
                          arguments: {'tabIndex': 2});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.selectionColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(TextString.submit,
                        style: TextStyle(color: CustomColors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
