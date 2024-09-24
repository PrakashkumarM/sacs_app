import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class DropdownSearchWidget<T> extends StatelessWidget {
  final String labelText;
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;
  final FormFieldValidator<T>? validator;
  final bool showSearchBox;

  const DropdownSearchWidget({
    required this.labelText,
    required this.items,
    required this.onChanged,
    this.selectedItem,
    this.validator,
    this.showSearchBox = true,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      popupProps: PopupProps.menu(
        showSearchBox: showSearchBox,
        showSelectedItems: true,
        fit: FlexFit.loose, // Adjust the fit property
        constraints: BoxConstraints(
          maxHeight: 200, // Adjust this height to fit exactly 4 items
        ),
      ),
      // dropdownDecoratorProps: DropDownDecoratorProps(
      //   dropdownSearchDecoration: InputDecoration(
      //     labelText: labelText,
      //   ),
      // ),
      items: items,
      onChanged: onChanged,
      selectedItem: selectedItem,
      validator: validator,
    );
  }
}
