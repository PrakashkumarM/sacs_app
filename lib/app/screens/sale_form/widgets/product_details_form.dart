import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/common/widgets/serial_image_widget.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/data/models/enquiry_model.dart';
import 'package:sacs_app/app/common/widgets/grouped_date_list.dart';
import 'package:sacs_app/app/screens/sale_form/controller.dart';
import 'package:sacs_app/app/screens/sale_form/widgets/add_product_form.dart';

class ProductDetailsForm extends StatelessWidget {
  const ProductDetailsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateSalesFormController controller =
        Get.put(CreateSalesFormController());

    return Obx(() {
      final groupedEnquiries = _groupEnquiriesByDate(controller.enquiries);
      final groupTitles = groupedEnquiries.keys.toList();

      return Expanded(
        child: Stack(
          children: [
            if (controller.enquiries.isEmpty) _buildAddProductButton(),
            if (controller.enquiries.isNotEmpty)
              GroupedDateList(
                itemCount: groupedEnquiries.length,
                groupTitles: groupTitles,
                fetchData: controller.fetchEnquiries,
                pageLoading: controller.isLoading,
                itemBuilder: (context, dateIndex) {
                  final entry = groupedEnquiries.entries.elementAt(dateIndex);
                  final enquiriesForDate = entry.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: enquiriesForDate
                        .asMap()
                        .entries
                        .map((entry) => GestureDetector(
                              onTap: () {
                                controller.toggleCardExpansion(entry.key);
                              },
                              child: ProductCard(entry.key),
                            ))
                        .toList(),
                  );
                },
              ),
            if (controller.enquiries.isNotEmpty) _buildFloatingActionButton(),
          ],
        ),
      );
    });
  }

  ElevatedButton _buildAddProductButton() {
    return ElevatedButton.icon(
      onPressed: () => NavigationHelper.navigateToScreen(AddProductForm(false)),
      icon: Icon(Icons.add, color: CustomColors.white),
      label: Text(TextString.addProduct,
          style: TextStyle(color: CustomColors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.selectionColor,
        shape: StadiumBorder(),
      ),
    );
  }

  Positioned _buildFloatingActionButton() {
    return Positioned(
      bottom: 10,
      right: 0,
      child: FloatingActionButton.small(
        elevation: 0,
        backgroundColor: CustomColors.selectionColor,
        onPressed: () =>
            NavigationHelper.navigateToScreen(AddProductForm(false)),
        child: Icon(Icons.add, size: 30, color: CustomColors.white),
        tooltip: TextString.add,
        shape: const CircleBorder(),
      ),
    );
  }

  Map<String, List<Enquiry>> _groupEnquiriesByDate(List<Enquiry> enquiries) {
    return enquiries.fold<Map<String, List<Enquiry>>>({},
        (groupedEnquiries, enquiry) {
      final date = enquiry.enquiryDate ?? 'Unknown Date';
      groupedEnquiries[date] = groupedEnquiries[date] ?? [];
      groupedEnquiries[date]!.add(enquiry);
      return groupedEnquiries;
    });
  }
}

class ProductCard extends StatelessWidget {
  final CreateSalesFormController controller =
      Get.put(CreateSalesFormController());
  final int cardKey;

  ProductCard(this.cardKey, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductTitleRow(),
            SizedBox(height: 8),
            _buildPriceTypeSerialCard(),
            SizedBox(height: 16),
            Obx(() => SizeTransition(
                  sizeFactor: controller.expandAnimation,
                  axisAlignment: 1.0,
                  child: controller.expandedCardIndex.value == cardKey
                      ? _buildExpandedSection(context)
                      : SizedBox.shrink(),
                )),
          ],
        ),
      ),
    );
  }

  Row _buildProductTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Television | Samsung | TV | 42"',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        _buildBadge('Warehouse'),
      ],
    );
  }

  Container _buildBadge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: CustomColors.productBadgeBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: CustomColors.productBadgeColor,
            fontSize: 13,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Card _buildPriceTypeSerialCard() {
    return Card(
      color: CustomColors.lightBlueBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildColumnWithText(TextString.price, '₹ 69000'),
            _buildColumnWithText(TextString.type, 'Product'),
            _buildColumnWithText(TextString.serialNo, '78521874187'),
          ],
        ),
      ),
    );
  }

  Column _buildColumnWithText(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                color: CustomColors.darkGrey, fontWeight: FontWeight.w400)),
        Text(content,
            style: TextStyle(
                fontSize: 14,
                color: CustomColors.unSelectionColor,
                fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildExpandedSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDeliveryAndPaymentStatus(),
          SizedBox(height: 10),
          _buildAddressRow(),
          Divider(height: 20, thickness: 1, color: Colors.grey[300]),
          SizedBox(height: 10),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Row _buildDeliveryAndPaymentStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildBadgeColumn(TextString.deliveryStatus, 'Ready For Delivery',
            Icons.check_circle, CustomColors.successDarktext),
        SizedBox(width: 10),
        _buildBadgeColumn(TextString.deliveryPayment, 'Company (₹ 500)',
            Icons.payment, CustomColors.invoiceNoBlueColor),
      ],
    );
  }

  Container _buildBadgeColumn(
      String title, String subtitle, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, color: color),
            SizedBox(width: 5),
            Text(title, style: TextStyle(color: color))
          ]),
          SizedBox(height: 5),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 14, color: color, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Row _buildAddressRow() {
    return Row(
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
    );
  }

  Row _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(Icons.visibility, TextString.serialNo,
            () => showSerialNumberBottomSheet(context)),
        _buildActionButton(CustomIcons.editPencil, TextString.edit,
            () => NavigationHelper.navigateToScreen(AddProductForm(true))),
        _buildActionButton(CustomIcons.trash, TextString.delete,
            () => controller.showDeleteConfirmation(context),
            color: CustomColors.lightRed,
            iconColor: CustomColors.selectionColor),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, Function onIconTap,
      {Color? color, Color? iconColor}) {
    return GestureDetector(
      onTap: () => onIconTap(),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color ?? CustomColors.greyBgIcon,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: iconColor ?? CustomColors.grey,
              size: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(label,
              style: TextStyle(fontSize: 12, color: CustomColors.black)),
        ],
      ),
    );
  }
}
