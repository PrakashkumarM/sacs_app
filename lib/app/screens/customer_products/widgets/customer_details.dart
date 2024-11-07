import 'package:flutter/material.dart';
import 'package:sacs_app/app/common/widgets/custom_icons.dart';

import 'package:sacs_app/app/core/values/colors.dart';

class CustomerDetails extends StatelessWidget {
  final String customerName;
  final String customerMobile;

  const CustomerDetails({
    super.key,
    required this.customerName,
    required this.customerMobile,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: CustomColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              customerName,
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
                SizedBox(width: 3),
                Text(
                  customerMobile,
                  style: TextStyle(color: CustomColors.grey, fontSize: 13),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
