import 'package:flutter/material.dart';

import 'package:sacs_app/app/common/widgets/button_with_icon.dart';
import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/screens/customer_products/view.dart';

class InvoiceCard extends StatelessWidget {
  final String invoiceNumber;
  final String deliveryType;
  final String deliveryCharge;
  final String totalProducts;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onDeliveryCharge;

  const InvoiceCard({
    super.key,
    required this.invoiceNumber,
    required this.deliveryType,
    required this.deliveryCharge,
    required this.totalProducts,
    required this.onEdit,
    required this.onDelete,
    required this.onDeliveryCharge,
  });

  // Text style constants
  static TextStyle labelStyle = TextStyle(color: CustomColors.darkGrey);
  static TextStyle valueStyle = TextStyle(
      color: CustomColors.unSelectionColor, fontWeight: FontWeight.w600);
  static TextStyle invoiceNoStyle = TextStyle(
      color: CustomColors.invoiceNoBlueColor, fontWeight: FontWeight.w600);
  static TextStyle blueTextStyle = TextStyle(
      color: CustomColors.invoiceNoBlueColor, fontWeight: FontWeight.w600);

  // Grid item labels
  static const List<String> labels = [
    TextString.invoice,
    TextString.deliveryType,
    TextString.deliveryCharge,
    TextString.totalProduct,
  ];

  // Method to create a grid item
  Widget _createGridItem(String label, String value, {Widget? icon}) {
    bool isInvoiceType = label == TextString.invoice;
    bool isDeliveryType = label == TextString.deliveryType;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: CustomColors.borderGrey, width: 1.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(label, style: labelStyle),
              if (icon != null) ...[
                const SizedBox(width: 4), // Space between icon and label
                icon,
              ],
            ],
          ),
          Text(
            value,
            style: isInvoiceType
                ? invoiceNoStyle
                : (isDeliveryType ? blueTextStyle : valueStyle),
          ),
        ],
      ),
    );
  }

  // Method for creating buttons
  Widget _buildActionButton(
      String text, VoidCallback onTap, IconData icon, Color iconColor,
      {Color? textColor}) {
    return ButtonIcon(
      onButtonTap: onTap,
      text: text,
      icon: icon,
      iconColor: iconColor,
      textColor: textColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Values for the grid items
    final values = [invoiceNumber, deliveryType, deliveryCharge, totalProducts];

    return Card(
      color: CustomColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 6.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 170,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.0,
                ),
                itemCount: labels.length,
                itemBuilder: (context, index) {
                  return _createGridItem(labels[index], values[index]);
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 12, bottom: 18, right: 6, left: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionButton(
                      TextString.invoice,
                      () =>
                          NavigationHelper.navigateToScreen(CustomerProducts()),
                      CustomIcons.invoice,
                      CustomColors.selectionColor),
                  _buildActionButton(TextString.edit, onEdit,
                      CustomIcons.editPencil, CustomColors.grey),
                  _buildActionButton(TextString.delete, onDelete,
                      CustomIcons.trash, CustomColors.selectionColor,
                      textColor: CustomColors.selectionColor),
                  _buildActionButton(
                      TextString.charges,
                      onDeliveryCharge,
                      CustomIcons.refreshWithTick,
                      CustomColors.refreshTealColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
