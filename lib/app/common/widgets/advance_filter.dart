import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/data/controllers/filter_controller.dart';

class AdvancedSearchBottomSheet extends StatelessWidget {
  final FilterController controller = Get.put(FilterController());

  AdvancedSearchBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: 16.0),
            _buildDateField('Start Date', controller.startDate),
            SizedBox(height: 16.0),
            _buildDateField('End Date', controller.endDate),
            SizedBox(height: 16.0),
            _buildDropdownField('Delivery Status', controller.deliveryStatus,
                ['Pending', 'Delivered']),
            SizedBox(height: 16.0),
            _buildDropdownField('Delivery Payment', controller.deliveryPayment,
                ['Paid', 'Unpaid']),
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
        Text('Advance Search',
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

  Future<void> _selectDate(BuildContext context, RxString date) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      // date.value = DateFormat('dd-MM-yyyy').format(selectedDate);
    }
  }

  // Dropdown Fields
// Date Fields with Label
  Widget _buildDateField(String label, RxString date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, // Label text above the field
            style: TextStyle(
              fontSize: 14,
            )),
        SizedBox(height: 8.0), // Add space between label and input
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
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: CustomColors.borderGrey),
                  ),
                  enabledBorder: OutlineInputBorder(
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

// Dropdown Fields with Label
  Widget _buildDropdownField(String label, RxString value, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, // Label text above the field
            style: TextStyle(
              fontSize: 14,
            )),
        SizedBox(height: 8.0), // Add space between label and input
        Obx(() => DropdownButtonFormField<String>(
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: CustomColors.grey,
              ),
              hint: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select',
                  style: TextStyle(
                      color: CustomColors.grey, fontWeight: FontWeight.w400),
                ),
              ),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: CustomColors.borderGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: CustomColors.borderGrey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: CustomColors.borderGrey),
                ),
              ),
              value: value.isNotEmpty ? value.value : null,
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (newValue) {
                value.value = newValue ?? '';
              },
            )),
      ],
    );
  }

  // Action Buttons using Container
  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildButton('Search', CustomColors.selectionColor, () {
          // Implement search action here
        }),
        SizedBox(width: 8.0),
        _buildButton('Reset', CustomColors.grey, () {
          // Implement reset action here
        }),
      ],
    );
  }

  // Custom Container Button
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
}
