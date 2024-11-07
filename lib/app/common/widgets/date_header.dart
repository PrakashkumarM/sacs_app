import 'package:flutter/material.dart';
import 'package:sacs_app/app/core/values/colors.dart';

class DateHeader extends StatelessWidget {
  final String groupByValue;
  const DateHeader({super.key, required this.groupByValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6),
          decoration: BoxDecoration(
            color: CustomColors.lightRed,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            groupByValue,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: CustomColors.selectionColor,
            ),
          ),
        ),
      ),
    );
  }
}
