import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/common/widgets/custom_textfield.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/data/services/image_picker_service.dart';
import 'package:sacs_app/app/screens/enquiry_form/widgets/dropdown.dart';
import 'package:sacs_app/app/screens/sale_form/add_product_controller.dart';

class AddProductForm extends StatelessWidget {
  final AddProductController controller = Get.put(AddProductController());
  final formKey = GlobalKey<FormState>();
  final ImagePickerService imagePickerService = ImagePickerService();
  final bool isEdit;

  AddProductForm(this.isEdit, {super.key});

  final ScrollController _scrollController = ScrollController();

  void _scrollToDropdownField(int index) {
    double targetPosition = 100 + (index * (60 + 16));
    if (_scrollController.position.pixels != targetPosition) {
      _scrollController.animateTo(
        targetPosition,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDropdownField(
                      index: 1,
                      label: TextString.category,
                      items: controller.categories,
                      selectedValue: controller.selectedCategory,
                      onSuggestionSelected: (category) {
                        controller.selectedCategory.value = category;
                      },
                      isRequired: true,
                    ),
                    const SizedBox(height: 10),
                    _buildDropdownField(
                      index: 2,
                      label: TextString.brand,
                      items: controller.brands,
                      selectedValue: controller.selectedBrand,
                      onSuggestionSelected: (brand) {
                        controller.selectedBrand.value = brand;
                      },
                      isRequired: true,
                    ),
                    const SizedBox(height: 10),
                    _buildDropdownField(
                      index: 3,
                      label: TextString.product,
                      items: controller.products,
                      selectedValue: controller.selectedProduct,
                      onSuggestionSelected: (product) {
                        controller.selectedProduct.value = product;
                      },
                      isRequired: true,
                    ),
                    _buildCheckboxField(
                      label: TextString.isAddOnProduct,
                      value: controller.isAddonProduct,
                    ),
                    CustomTextField(
                      label: TextString.productAmnt,
                      controller: controller.productAmountController,
                    ),
                    const SizedBox(height: 10),
                    _buildDropdownField(
                        index: 6,
                        label: TextString.deliveryStatus,
                        items: controller.deliveryStatuses,
                        selectedValue: controller.selectedDeliveryStatus,
                        onSuggestionSelected: (status) {
                          controller.selectedDeliveryStatus.value = status;
                        },
                        scrollTop: () {
                          _scrollToDropdownField(5);
                        }),
                    const SizedBox(height: 10),
                    _buildDropdownField(
                        index: 7,
                        label: TextString.deliveryType,
                        items: controller.deliveryTypes,
                        selectedValue: controller.selectedDeliveryType,
                        onSuggestionSelected: (type) {
                          controller.selectedDeliveryType.value = type;
                        },
                        scrollTop: () {
                          _scrollToDropdownField(6);
                        }),
                    const SizedBox(height: 10),
                    _buildDropdownField(
                        index: 8,
                        label: TextString.deliveryPayment,
                        items: controller.deliveryPayments,
                        selectedValue: controller.selectedDeliveryPayment,
                        onSuggestionSelected: (payment) {
                          controller.selectedDeliveryPayment.value = payment;
                        },
                        scrollTop: () {
                          _scrollToDropdownField(7);
                        }),
                    const SizedBox(height: 10),
                    CustomTextField(
                      label: TextString.deliveryCharge,
                      controller: controller.deliveryChargeController,
                    ),
                    _buildCheckboxField(
                      label: TextString.useCustomerAddress,
                      value: controller.isAddonProduct,
                    ),
                    CustomTextField(
                      label: TextString.serialNo,
                      controller: controller.serialNumberController,
                      isRequired: true,
                    ),
                    const SizedBox(height: 8),
                    _buildImageUploadField(),
                    CustomTextField(
                      label: TextString.address,
                      controller: controller.addressController,
                      isMultiline: true,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.add, color: CustomColors.white),
                        label: Text(TextString.addProduct,
                            style: const TextStyle(color: CustomColors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.selectionColor,
                          shape: const StadiumBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 25),
          Expanded(
            child: Text(
              '${isEdit ? TextString.edit : TextString.select} ${TextString.product}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required int index,
    required String label,
    required RxList<String> items,
    required RxString selectedValue,
    required onSuggestionSelected,
    scrollTop,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: CustomColors.unSelectionColor,
            ),
            children: [
              TextSpan(text: label),
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: CustomColors.selectionColor),
                ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        CommonDropdownMenu(
          label: label,
          items: items,
          onSelected: onSuggestionSelected,
          selectedValue: selectedValue,
          scrollTop: scrollTop ?? () {},
        ),
      ],
    );
  }

  Widget _buildCheckboxField({
    required String label,
    required RxBool value,
  }) {
    return Obx(() {
      return Row(
        children: [
          Checkbox(
            value: value.value,
            onChanged: (val) => value.value = val ?? false,
          ),
          Text(label),
        ],
      );
    });
  }

  Widget _buildImageUploadField() {
    return GestureDetector(
      onTap: () => imagePickerService.showImageSourceDialog(
          Get.context!, controller.updateImage),
      child: Obx(() {
        return Container(
          width: 100,
          height: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[200],
          ),
          child: controller.imagePath.value.isEmpty
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
                    File(controller.imagePath.value),
                    fit: BoxFit.cover,
                  ),
                ),
        );
      }),
    );
  }
}
