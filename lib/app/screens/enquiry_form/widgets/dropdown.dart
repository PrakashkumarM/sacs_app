import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/common/widgets/dropdown_clone/drop_down_search_field.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';

class CommonDropdownMenu extends StatelessWidget {
  final String label;
  final RxList<String> items;
  final ValueChanged<String?> onSelected;
  final double width;
  final Function scrollTop;
  final RxString selectedValue;

  const CommonDropdownMenu({
    Key? key,
    required this.label,
    required this.items,
    required this.onSelected,
    required this.scrollTop,
    this.width = double.infinity,
    required this.selectedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController dropDownSearchController =
        TextEditingController();

    return DropDownSearchFormField(
      onSuggestionsBoxToggle: (isOpen, fromSuggestionSelected) {
        if (!isOpen && !fromSuggestionSelected) {
          dropDownSearchController.text = selectedValue.value;
          onSelected(selectedValue.value);
        }
      },
      suggestionsBoxController: SuggestionsBoxController(),
      autoFlipDirection: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      loadingBuilder: (context) => _buildLoadingIndicator(),
      noItemsFoundBuilder: (context) =>
          _buildNoItemsFound(dropDownSearchController),
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        color: CustomColors.white,
        constraints: BoxConstraints(maxHeight: 240.0),
      ),
      textFieldConfiguration: TextFieldConfiguration(
        onTap: scrollTop as void Function(),
        decoration: _inputDecoration(),
        controller: dropDownSearchController,
      ),
      suggestionsCallback: (pattern) {
        return items
            .where((item) => item.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
      },
      itemBuilder: (context, suggestion) => ListTile(title: Text(suggestion)),
      transitionBuilder: (context, suggestionsBox, controller) =>
          suggestionsBox,
      onSuggestionSelected: (String suggestion) {
        dropDownSearchController.text = suggestion;
        onSelected(suggestion);
        scrollTop();
      },
      validator: (value) => value!.isEmpty ? TextString.plsSelectProduct : null,
      onSaved: (value) {},
      displayAllSuggestionWhenTap: true,
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      hintText: label,
      hintStyle: TextStyle(fontSize: 16, color: CustomColors.placeholderGrey),
      border: _outlineInputBorder(),
      focusedBorder: _outlineInputBorder(),
      enabledBorder: _outlineInputBorder(),
      suffixIcon:
          Icon(CustomIcons.downArrow, color: CustomColors.placeholderGrey),
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: CustomColors.grey),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(CustomColors.selectionColor)),
            const SizedBox(width: 10),
            Text('Loading...',
                style: TextStyle(
                    color: CustomColors.unSelectionColor, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildNoItemsFound(TextEditingController controller) {
    return Center(
      child: GestureDetector(
        onTap: () {
          controller.text = selectedValue.value;
          onSelected(selectedValue.value);
        },
        child: SizedBox(
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline,
                  color: CustomColors.selectionColor, size: 30),
              const SizedBox(height: 8),
              Text(TextString.noItemsFound,
                  style: TextStyle(
                      color: CustomColors.unSelectionColor, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
