import 'package:flutter/material.dart';
import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/common/widgets/dropdown_clone/drop_down_search_field.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/screens/customer_enquiries/view.dart';
import 'package:sacs_app/app/screens/enquiry_form/view.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final List<Map<String, dynamic>> items = [
    {
      "id": "1",
      "name": "John Mathew Richard",
      "mobile": "9856556321",
      "enquiry": true,
      "sales": false
    },
    {
      "id": "2",
      "name": "Jane Doe",
      "mobile": "9856556321",
      "enquiry": true,
      "sales": true
    },
    {
      "id": "3",
      "name": "Alice Johnson",
      "mobile": "9856556321",
      "enquiry": false,
      "sales": false
    },
    {
      "id": "4",
      "name": "Bob Smith",
      "mobile": "9856556321",
      "enquiry": true,
      "sales": false
    },
  ];

  final TextEditingController dropDownSearchController =
      TextEditingController();

  @override
  void dispose() {
    dropDownSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 40),
      child: DropDownSearchFormField(
        keepSuggestionsOnSuggestionSelected: true,
        suggestionsCallback: (pattern) {
          return items
              .where((item) =>
                  item['mobile']!.toLowerCase().contains(pattern.toLowerCase()))
              .toList();
        },
        itemBuilder: (context, suggestion) => ListTile(
          tileColor: CustomColors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(suggestion['mobile']!,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
              Text(
                suggestion['name']!,
                style: TextStyle(color: CustomColors.grey, fontSize: 14),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (suggestion['enquiry'])
                GestureDetector(
                  onTap: () {
                    NavigationHelper.navigateToScreen(CustomerEnquiries());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:
                        Text('Enquiry', style: TextStyle(color: Colors.black)),
                  ),
                ),
              if (suggestion['enquiry'] && suggestion['sales'])
                SizedBox(width: 6),
              if (suggestion['sales'])
                GestureDetector(
                  onTap: () {
                    NavigationHelper.navigateToScreen(CustomerEnquiries());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('Sale', style: TextStyle(color: Colors.white)),
                  ),
                ),
              if (!suggestion['enquiry'] && !suggestion['sales'])
                GestureDetector(
                  onTap: () {
                    NavigationHelper.navigateToScreen(EnquiryForm());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('+ New', style: TextStyle(color: Colors.white)),
                  ),
                ),
            ],
          ),
        ),
        onSuggestionSelected: (suggestion) {
          dropDownSearchController.text = suggestion['name']!;
        },
        suggestionsBoxDecoration: SuggestionsBoxDecoration(),
        displayAllSuggestionWhenTap: true,
        textFieldConfiguration: TextFieldConfiguration(
          decoration: _inputDecoration(),
          controller: dropDownSearchController,
          onChanged: (text) {
            setState(() {}); // Update state on text change
          },
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
      hintText: "Enter Phone number",
      hintStyle: TextStyle(fontSize: 16, color: CustomColors.placeholderGrey),
      border: _outlineInputBorder(),
      focusedBorder: _outlineInputBorder(),
      enabledBorder: _outlineInputBorder(),
      suffixIcon:
          _buildCloseIcon(), // Use custom close icon based on text input
      prefixIcon: Icon(
        CustomIcons.search,
        color: CustomColors.darkGrey,
        size: 15,
      ),
    );
  }

  Widget _buildCloseIcon() {
    return dropDownSearchController.text.isNotEmpty
        ? IconButton(
            icon: Icon(
              CustomIcons.close,
              color: CustomColors.darkGrey,
              size: 15,
            ),
            onPressed: () {
              dropDownSearchController.clear(); // Clear text
              setState(() {}); // Update UI to reflect change
            },
          )
        : SizedBox.shrink();
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide(color: CustomColors.borderGrey),
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
}
