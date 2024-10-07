import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/common/widgets/custom_icons.dart';
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
          _buildCustomerInfo(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSaleDatePicker(controller, context),
                  const SizedBox(height: 16),
                  _buildSaleItems(),
                  const SizedBox(height: 16),
                  _buildDeliveryChargeInput(controller),
                ],
              ),
            ),
          ),
          _buildBottomActions(controller),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo() {
    return Container(
      padding: EdgeInsets.only(top: 16, bottom: 8),
      child: Center(
        child: Column(
          children: [
            Text(
              'John Rebac',
              style: TextStyle(
                color: CustomColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CustomIcons.call, color: CustomColors.grey, size: 14),
                const SizedBox(width: 2),
                Text(
                  '9582555312',
                  style: TextStyle(color: CustomColors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaleDatePicker(
      MakeSalesController controller, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: '${TextString.saleDate} ',
            style:
                TextStyle(color: CustomColors.unSelectionColor, fontSize: 16),
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: CustomColors.selectionColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: controller.selectedDate.value ?? DateTime.now(),
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
                style: TextStyle(color: CustomColors.darkGrey),
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    CustomIcons.calendarInput,
                    color: CustomColors.grey,
                    size: 18,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.borderGrey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.borderGrey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
      ],
    );
  }

  Widget _buildSaleItems() {
    // SaleItemWidget list generation optimized with map
    return Column(
      children: List.generate(4, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SaleItemWidget(
            cardKey: index,
            title: 'Washing Machine | Haier | 9Kg',
            price: '₹ 69,000',
            serialNumber: '78521874100',
            status: 'Warehouse',
          ),
        );
      }),
    );
  }

  Widget _buildDeliveryChargeInput(MakeSalesController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(TextString.deliveryCharge),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller.chargeController,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CustomColors.borderGrey),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CustomColors.borderGrey),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(MakeSalesController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => NavigationHelper.goBack(),
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.lightGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                TextString.cancel,
                style: TextStyle(color: CustomColors.black),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                NavigationHelper.navigateAndClearStack(TextString.dashboard,
                    arguments: {'tabIndex': 2});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.selectionColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                TextString.submit,
                style: TextStyle(color: CustomColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
