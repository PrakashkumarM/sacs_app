import 'package:flutter/material.dart';
import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/core/values/colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<Map<String, dynamic>> items;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.white,
        boxShadow: [
          BoxShadow(
            color: CustomColors.grey.withOpacity(0.3), // Shadow color
            offset: Offset(0, -3), // Shadow offset (top shadow)
            blurRadius: 6, // Shadow blur radius
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          int index = items.indexOf(item);
          bool isSelected = index == currentIndex;

          return GestureDetector(
            onTap: () => onTap(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CustomIcons.getIconData(item['icon']),
                  color: isSelected
                      ? CustomColors.selectionColor
                      : CustomColors.unSelectionColor,
                  size: 24.0, // Adjust the size if needed
                ),
                SizedBox(height: 5), // Adjust space between icon and text
                Text(
                  item['label'],
                  style: TextStyle(
                    color: isSelected
                        ? CustomColors.selectionColor
                        : CustomColors.unSelectionColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0, // Adjust the font size if needed
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}