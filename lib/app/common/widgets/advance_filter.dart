import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/core/values/colors.dart';

class AdvancedSearchBottomSheet extends StatelessWidget {
  final String title;
  final dynamic mainFiltercontroller; // Accept any controller type

  AdvancedSearchBottomSheet(
      {Key? key, required this.title, required this.mainFiltercontroller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('mainFiltercontroller:$mainFiltercontroller');
    final filters = _getFiltersForTitle(title);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0),
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            ...filters,
            SizedBox(height: 16.0),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  // Header
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Advanced Search',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  // Date Field
  Widget _buildDateField(String label, RxString date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14)),
        SizedBox(height: 8.0),
        GestureDetector(
          onTap: () => _selectDate(Get.context!, date),
          child: Obx(() => TextFormField(
                decoration: InputDecoration(
                  hintText: 'dd-mm-yyyy',
                  hintStyle: TextStyle(
                    color: CustomColors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: CustomColors.borderGrey),
                  ),
                  suffixIcon: Icon(CustomIcons.calendar),
                ),
                enabled: false,
                controller: TextEditingController(text: date.value),
              )),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context, RxString date) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      date.value =
          '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}';
    }
  }

  // Dropdown Field
  Widget _buildDropdownField(String label, RxString value, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14)),
        SizedBox(height: 8.0),
        Obx(() => DropdownButtonFormField<String>(
              icon: Icon(Icons.keyboard_arrow_down, color: CustomColors.grey),
              hint: Text('Select',
                  style: TextStyle(
                      color: CustomColors.grey, fontWeight: FontWeight.w400)),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: CustomColors.borderGrey),
                ),
              ),
              value: value.isNotEmpty ? value.value : null,
              items: items.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
              onChanged: (newValue) {
                value.value = newValue ?? '';
              },
            )),
      ],
    );
  }

  // Action Buttons
  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildButton('Search', CustomColors.selectionColor, () {
          mainFiltercontroller.applyFilters();
          Navigator.of(context).pop();
        }),
        SizedBox(width: 8.0),
        _buildButton('Reset', CustomColors.grey, () {
          mainFiltercontroller.resetFilters();
          Navigator.of(context).pop();
        }),
      ],
    );
  }

  Widget _buildButton(String label, Color color, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Filters Based on Title
  List<Widget> _getFiltersForTitle(String title) {
    switch (title) {
      case 'Enquiry':
        return [
          _buildDateField(
              'Start Date', mainFiltercontroller.tempStartDate ?? ''.obs),
          SizedBox(height: 8),
          _buildDateField('End Date', mainFiltercontroller.tempEndDate),
          SizedBox(height: 8),
          _buildDropdownField('Status', mainFiltercontroller.tempStatus,
              ['Pending', 'Completed', 'Cancelled']),
        ];
      case 'Sales List':
        return [
          _buildDateField('Start Date', mainFiltercontroller.tempStartDate),
          SizedBox(height: 8),
          _buildDateField('End Date', mainFiltercontroller.tempEndDate),
          SizedBox(height: 8),
          _buildDropdownField('Status', mainFiltercontroller.tempStatus,
              ['Pending', 'Delivered']),
          SizedBox(height: 8),
          _buildDropdownField(
              'Delivery Status',
              mainFiltercontroller.tempDeliveryStatus,
              ['Pending', 'Delivered']),
          SizedBox(height: 8),
          _buildDropdownField('Delivery Payment',
              mainFiltercontroller.tempDeliveryPayment, ['Paid', 'Unpaid']),
        ];
      default:
        return [Text('No filters available for this page.')];
    }
  }
}
