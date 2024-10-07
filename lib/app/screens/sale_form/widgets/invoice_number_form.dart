import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/data/services/image_picker_service.dart';
import 'package:sacs_app/app/screens/sale_form/controller.dart';

class InvoiceForm extends StatelessWidget {
  final CreateSalesFormController invoiceController =
      Get.put(CreateSalesFormController());
  final ImagePickerService imagePickerService = ImagePickerService();

  InvoiceForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabelWithAsterisk(TextString.invoiceNo),
          const SizedBox(height: 8),

          // Invoice Number Input
          _buildTextField(
            controller: invoiceController.invoiceNumberController,
            hintText: TextString.enterInvoiceNo,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return TextString.validInvocieNO;
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Invoice Upload Label
          _buildLabel(TextString.invoiceUpload),
          const SizedBox(height: 8),

          // Invoice Image Upload
          GestureDetector(
            onTap: () => imagePickerService.showImageSourceDialog(
                context, invoiceController.updateImage),
            child: Obx(() {
              return _buildImageUploadContainer(
                  invoiceController.imagePath.value);
            }),
          ),
        ],
      ),
    );
  }

  // Method to build label with asterisk
  Widget _buildLabelWithAsterisk(String label) {
    return RichText(
      text: TextSpan(
        text: '$label ',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: CustomColors.unSelectionColor,
        ),
        children: [
          TextSpan(
            text: '*',
            style: TextStyle(
              color: CustomColors.selectionColor, // Red asterisk
            ),
          ),
        ],
      ),
    );
  }

  // Method to build a standard label without asterisk
  Widget _buildLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: CustomColors.unSelectionColor,
      ),
    );
  }

  // Method to build a reusable TextFormField
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: CustomColors.grey,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      validator: validator,
    );
  }

  // Method to build image upload container
  Widget _buildImageUploadContainer(String imagePath) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200], // Background color
      ),
      child: imagePath.isEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                TextString.noImgPath,
                fit: BoxFit.cover,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(imagePath), // Display selected image
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
