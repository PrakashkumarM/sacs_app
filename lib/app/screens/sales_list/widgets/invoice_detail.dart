import 'package:flutter/material.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/screens/customer_products/view.dart';

class InvoiceDetailsWidget extends StatelessWidget {
  final String invoiceNumber;
  final String deliveryType;
  final int deliveryCharge;
  final int totalProduct;
  final VoidCallback onDownloadInvoice;

  const InvoiceDetailsWidget({
    Key? key,
    required this.invoiceNumber,
    required this.deliveryType,
    required this.deliveryCharge,
    required this.totalProduct,
    required this.onDownloadInvoice,
  }) : super(key: key);

  // Define styles similar to InvoiceCard
  static TextStyle labelStyle =
      TextStyle(color: Colors.grey[700], fontSize: 12);
  static TextStyle valueStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14);
  static TextStyle invoiceNoStyle =
      TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationHelper.navigateToScreen(CustomerProducts());
      },
      child: Card(
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Grid layout for invoice details
              SizedBox(
                height: 160,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // childAspectRatio: 2.0,
                    mainAxisExtent: 80,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return _buildGridItem("Invoice", invoiceNumber,
                            valueStyle: invoiceNoStyle);
                      case 1:
                        return _buildGridItemWithBadge(
                            "Delivery Type", deliveryType);
                      case 2:
                        return _buildGridItem("Delivery Charge",
                            "₹ ${deliveryCharge.toString()}");
                      case 3:
                        return _buildGridItem("Total Product",
                            "${totalProduct.toString().padLeft(2, '0')} No's");
                      default:
                        return Container();
                    }
                  },
                ),
              ),
              InkWell(
                child: GestureDetector(
                  onTap: () {
                    // Download Invoice
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.article,
                              color: CustomColors.selectionColor,
                              size: 16,
                            ),
                            SizedBox(width: 5),
                            Text("Download Invoice")
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: CustomColors.unSelectionColor,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to create grid items
  Widget _buildGridItem(String label, String value, {TextStyle? valueStyle}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: CustomColors.borderGrey, width: 1.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: labelStyle),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: valueStyle ?? InvoiceDetailsWidget.valueStyle,
          ),
        ],
      ),
    );
  }

  // Helper function to create grid items with a badge for Delivery Type
  Widget _buildGridItemWithBadge(String label, String value) {
    Color badgeColor = CustomColors.mildSkyblueBg;
    Color textColor = CustomColors.invoiceNoBlueColor;
    Color borderColor = CustomColors.badgeBackgroundBlue;

    // // Define badge color and text color based on the delivery type
    // if (value == 'Express') {
    //   badgeColor = CustomColors.greenBadge;
    //   textColor = CustomColors.successDarktext;
    // } else if (value == 'Standard') {
    //   badgeColor = CustomColors.redBadge;
    //   textColor = CustomColors.darkRedText;
    // } else {
    //   // Default color if delivery type is unknown
    //   badgeColor = Colors.grey;
    //   textColor = Colors.white;
    // }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!, width: 1.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: labelStyle),
          const SizedBox(height: 4.0),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: borderColor)),
            child: Text(
              value,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
