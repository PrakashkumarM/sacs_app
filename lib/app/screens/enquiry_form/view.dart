import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/common/widgets/stepper_header.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/screens/enquiry_form/controller.dart';

class EnquiryForm extends StatelessWidget {
  // Initialize the GetX controller
  final EnquiryFormController _controller = Get.put(EnquiryFormController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        title: TextString.createEnquiry,
        showBackButton: true,
        stepperAvailable: false,
        body: Column(
          children: [
            // Reactive Stepper Header
            StepperHeader(
              currentStep: _controller.currentStep,
              onStepReached: () {},
              steps: _controller.formSteps,
            ),

            // Scrollable form content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDropdownField(
                        label: TextString.selectCategory,
                        hintText: TextString.selectCategory,
                        items: _controller.categories,
                        selectedValue: _controller.selectedCategory,
                      ),
                      const SizedBox(height: 16),
                      _buildDropdownField(
                        label: TextString.selectBrand,
                        hintText: TextString.selectBrand,
                        items: _controller.brands,
                        selectedValue: _controller.selectedBrand,
                      ),
                      const SizedBox(height: 16),
                      _buildDropdownField(
                        label: TextString.selectProduct,
                        hintText: TextString.selectProduct,
                        items: _controller.products,
                        selectedValue: _controller.selectedProduct,
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _controller.addProduct(
                                _controller.selectedCategory.value,
                                _controller.selectedBrand.value,
                                _controller.selectedProduct.value,
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.add,
                            color: CustomColors.white,
                          ),
                          label: const Text(
                            TextString.addProduct,
                            style: TextStyle(color: CustomColors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.selectionColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildProductCard(),
                      _buildProductCard(),
                    ],
                  ),
                ),
              ),
            ),

            // Fixed "Next" or "Submit" button at the bottom
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: SizedBox(
                  width: double.infinity,
                  child: Obx(() {
                    return Row(
                      children: [
                        if (_controller.currentStep.value > 0)
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _controller.goBackOrNext(true);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.grey,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: const Text(TextString.back,
                                  style: TextStyle(
                                      fontSize: 16, color: CustomColors.white)),
                            ),
                          ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_controller.currentStep.value <
                                  _controller.formSteps.length - 1) {
                                _controller.goBackOrNext(false);
                              } else {
                                _controller
                                    .submitForm(); // Submit if it's the last step
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.selectionColor,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: Text(
                              _controller.currentStep.value <
                                      _controller.formSteps.length - 1
                                  ? TextString.next
                                  : TextString.submit,
                              style: const TextStyle(
                                  fontSize: 16, color: CustomColors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  })),
            ),
          ],
        ));
  }

  // Dropdown fields and other widgets (same as before)
  Widget _buildDropdownField({
    required String label,
    required String hintText,
    required List<String> items,
    required RxString selectedValue,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Obx(() {
          return DropdownButtonFormField<String>(
            value: selectedValue.value.isEmpty ? null : selectedValue.value,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onChanged: (String? newValue) {
              if (newValue != null) {
                selectedValue.value = newValue;
              }
            },
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
        }),
      ],
    );
  }

  Widget _buildProductCard() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Category: Mobiles"),
            Text("Brand: Samsung"),
            Text("Product: Samsung Galaxy S23 Ultra"),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: null,
                child: Text(
                  TextString.remove,
                  style: TextStyle(color: CustomColors.selectionColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
