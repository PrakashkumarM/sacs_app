import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/screens/enquiry_form/customer_details_form_controller.dart';

class CustomerDetailsForm extends StatelessWidget {
  final controller = Get.put(CustomerDetailsFormController());

  static const double paddingHorizontal = 16.0;
  static const double paddingVertical = 10.0;
  static const double fieldPaddingVertical = 8.0;

  CustomerDetailsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal, vertical: paddingVertical),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                  TextString.mobileNo, controller.mobileNumberController,
                  isRequired: true),
              _buildUseCustomerPhoneCheckbox(),
              _buildTextField(TextString.name, controller.nameController,
                  isRequired: true),
              _buildTextField(TextString.primaryAddress,
                  controller.primaryAddressController,
                  isRequired: true, isMultiline: true),
              _buildTextField(TextString.secondaryAddress,
                  controller.secondaryAddressController,
                  isMultiline: true),
              _buildTextField(TextString.city, controller.cityController),
              _buildTextField(TextString.state, controller.stateController),
              _buildTextField(TextString.pincode, controller.pinCodeController,
                  isRequired: true),
              _buildReferenceDetails(),
              _buildTextField(TextString.remarks, controller.remarksController),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isMultiline = false, bool isRequired = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: fieldPaddingVertical),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(label, isRequired),
          SizedBox(height: 4),
          TextFormField(
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: isMultiline ? 3 : 1,
            decoration: _buildInputDecoration(label),
            validator: (value) {
              if (isRequired && (value == null || value.isEmpty)) {
                return 'Please enter $label';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String label, bool isRequired) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: CustomColors.unSelectionColor,
        ),
        children: [
          TextSpan(text: label),
          if (isRequired)
            TextSpan(
              text: ' ${TextString.star}',
              style: TextStyle(color: CustomColors.selectionColor),
            ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      hintText: 'Enter $label',
      hintStyle: TextStyle(
        color: CustomColors.grey,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey),
      ),
    );
  }

  Widget _buildUseCustomerPhoneCheckbox() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: controller.useCustomerPhone.value,
            onChanged: (value) {
              controller.useCustomerPhone.value = value ?? false;
            },
          ),
          Text(
            TextString.useCustomerPhnNo,
            style: TextStyle(
              color: CustomColors.unSelectionColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildReferenceDetails() {
    return Card(
      color: CustomColors.lightBlueBackground,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TextString.refDetails,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: CustomColors.unSelectionColor,
              ),
            ),
            SizedBox(height: 2),
            _buildTextField(
                TextString.refMobile, controller.referenceMobileController),
            _buildTextField(
                TextString.refName, controller.referenceNameController),
          ],
        ),
      ),
    );
  }
}
