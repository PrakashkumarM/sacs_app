import 'package:flutter/material.dart';
import 'package:sacs_app/app/core/values/colors.dart';

class CustomCard extends StatelessWidget {
  final String productName;
  final String enquiryStatus;
  final String customerName;
  final String mobile;
  final Widget trailing;

  const CustomCard({
    required this.productName,
    required this.enquiryStatus,
    required this.customerName,
    required this.mobile,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: CustomColors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  productName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                decoration: BoxDecoration(
                  color: enquiryStatus == 'Enquired'
                      ? CustomColors.successLightBackground
                      : CustomColors.dangerLightBackground,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  enquiryStatus,
                  style: TextStyle(
                    color: enquiryStatus == 'Enquired'
                        ? CustomColors.successDarktext
                        : CustomColors.dangerDarktext,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.person, color: CustomColors.placeholderGrey),
              const SizedBox(width: 4.0),
              Text(
                customerName,
                style: TextStyle(
                  color: CustomColors.darkGrey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              Icon(Icons.phone, color: CustomColors.placeholderGrey),
              const SizedBox(width: 4.0),
              Text(
                mobile,
                style: TextStyle(
                  color: CustomColors.darkGrey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          trailing,
        ],
      ),
    );
  }
}
