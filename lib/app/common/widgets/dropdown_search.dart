import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class DropdownSearchWidget<T> extends StatelessWidget {
  final String labelText;
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;
  final FormFieldValidator<T>? validator;

  const DropdownSearchWidget({
    required this.labelText,
    required this.items,
    required this.onChanged,
    this.selectedItem,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownSearch<T>(
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          items: items,
          onChanged: onChanged,
          selectedItem: selectedItem,
          validator: validator,
          dropdownBuilder: (context, selectedItem) {
            return Text(
              selectedItem?.toString() ?? 'Select $labelText', // Placeholder
              style: const TextStyle(fontSize: 16),
            );
          },
          dropdownButtonProps: DropdownButtonProps(
            icon: const Icon(Icons.arrow_drop_down),
          ),
          popupProps: PopupProps.menu(
            showSearchBox: true, // Enable search box
            constraints: BoxConstraints(maxHeight: 200),
            fit: FlexFit.loose,
          ),
          filterFn: (item, filter) {
            // Filter function for items based on input text
            return item.toString().toLowerCase().contains(filter.toLowerCase());
          },
          autoValidateMode:
              AutovalidateMode.onUserInteraction, // Validate on interaction
        ),
      ],
    );
  }
}
