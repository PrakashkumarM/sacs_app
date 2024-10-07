import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/common/widgets/serial_image_widget.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';

import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/screens/make_sale/controller.dart';
import 'package:sacs_app/app/screens/sale_form/controller.dart';
import 'package:sacs_app/app/screens/sale_form/widgets/add_product_form.dart';

class SaleItemWidget extends StatelessWidget {
  final String title;
  final String price;
  final String serialNumber;
  final String status;
  final int cardKey;

  SaleItemWidget({
    required this.cardKey,
    required this.title,
    required this.price,
    required this.serialNumber,
    required this.status,
  });

  final MakeSalesController controller = Get.put(MakeSalesController());

  @override
  Widget build(BuildContext context) {
    final Color statusColor = status == 'On Shop'
        ? CustomColors.darkRedText
        : CustomColors.productBadgeColor;

    return Card(
      elevation: 2,
      color: CustomColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => controller.toggleCardExpansion(cardKey),
              child: _buildTitleSection(statusColor),
            ),
            Obx(() {
              return SizeTransition(
                sizeFactor: controller.expandAnimation,
                axisAlignment: 1.0,
                child: controller.expandedCardIndex.value == cardKey
                    ? _buildExpandedSection(context)
                    : const SizedBox.shrink(),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection(Color statusColor) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w500, color: CustomColors.black),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: status == 'On Shop'
                    ? CustomColors.dangerLightBackground
                    : CustomColors.productBadgeBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                status,
                style:
                    TextStyle(color: statusColor, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildProductDetails(),
      ],
    );
  }

  Widget _buildProductDetails() {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.lightBlueBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(TextString.price,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12)),
              Text(TextString.type,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12)),
              Text(TextString.serialNo,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(price,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 14)),
              Text(title.split('|')[0],
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 14)),
              Text(serialNumber,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedSection(BuildContext context) {
    final CreateSalesFormController formController =
        Get.put(CreateSalesFormController());

    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusRow(),
          const SizedBox(height: 10),
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
          const Divider(
            height: 20,
            thickness: 1,
          ),
          const SizedBox(height: 10),
          _buildActionButtons(context, formController),
        ],
      ),
    );
  }

  Widget _buildStatusRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatusBadge(
          icon: Icons.check_circle,
          color: CustomColors.successDarktext,
          title: TextString.deliveryStatus,
          description: 'Ready For Delivery',
        ),
        const SizedBox(width: 10),
        _buildStatusBadge(
          icon: Icons.payment,
          color: CustomColors.invoiceNoBlueColor,
          title: TextString.deliveryPayment,
          description: 'Company (₹ 500)',
        ),
      ],
    );
  }

  Widget _buildStatusBadge({
    required IconData icon,
    required Color color,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 5),
              Text(
                title,
                style: TextStyle(color: color, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(color: color, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
      BuildContext context, CreateSalesFormController formController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(Icons.visibility, TextString.serialNo, () {
          showSerialNumberBottomSheet(context);
        }),
        _buildActionButton(CustomIcons.editPencil, TextString.edit, () {
          NavigationHelper.navigateToScreen(AddProductForm(true));
        }),
        _buildActionButton(CustomIcons.trash, TextString.delete, () {
          formController.showDeleteConfirmation(context);
        }, color: CustomColors.lightRed),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, Function onIconTap,
      {Color? color}) {
    return GestureDetector(
      onTap: () => onIconTap(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color ?? Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 15,
              color: color != null
                  ? CustomColors.selectionColor
                  : CustomColors.grey,
            ),
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
