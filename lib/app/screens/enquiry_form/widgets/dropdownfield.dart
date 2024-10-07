import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/screens/enquiry_form/widgets/dropdown.dart';

class DropdownField extends StatelessWidget {
  final String label;
  final RxList<String> items;
  final onSuggestionSelected;
  final void Function() scrollTop;
  final RxString selectedValue;

  const DropdownField({
    Key? key,
    required this.label,
    required this.items,
    required this.onSuggestionSelected,
    required this.scrollTop,
    required this.selectedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
                color: CustomColors.unSelectionColor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(color: CustomColors.selectionColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        CommonDropdownMenu(
          label: label,
          items: items,
          onSelected: onSuggestionSelected,
          selectedValue: selectedValue,
          scrollTop: scrollTop,
        ),
      ],
    );
  }
}
