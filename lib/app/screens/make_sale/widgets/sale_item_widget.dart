import 'package:flutter/material.dart';

import 'package:sacs_app/app/core/values/colors.dart';

class SaleItemWidget extends StatelessWidget {
  final String title;
  final String price;
  final String serialNumber;
  final String status;

  const SaleItemWidget({
    required this.title,
    required this.price,
    required this.serialNumber,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = status == 'On Shop'
        ? CustomColors.darkRedText
        : CustomColors.productBadgeColor;

    return Card(
      elevation: 2,
      color: CustomColors.white, // Entire card with white background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Status Row
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: status == 'On Shop'
                        ? CustomColors.dangerLightBackground
                        : CustomColors
                            .productBadgeBackgroundColor, // Badge-like status background
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                        color: statusColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Product Details in Table Format inside Sky Blue Container
            Container(
              decoration: BoxDecoration(
                color: CustomColors.lightBlueBackground, // Sky blue background
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  // Header Row (Price, Type, Serial Number)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Price',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                      Text(
                        'Type',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                      Text(
                        'Serial Number',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Values Row (Price, Type, Serial Number)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      Text(title.split('|')[0],
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  14)), // Extracting the first part of the title as the type
                      Text(serialNumber,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
