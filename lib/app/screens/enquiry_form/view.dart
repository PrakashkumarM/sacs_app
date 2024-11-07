import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/common/widgets/stepper_header.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/screens/enquiry_form/controller.dart';
import 'package:sacs_app/app/screens/enquiry_form/customer_details_form_controller.dart';
import 'package:sacs_app/app/screens/enquiry_form/widgets/customer_details_form.dart';
import 'package:sacs_app/app/screens/enquiry_form/widgets/dropdown.dart';

class EnquiryForm extends StatelessWidget {
  final EnquiryFormController _controller = Get.put(EnquiryFormController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  final customController = Get.put(CustomerDetailsFormController());
  final GlobalKey<FormState> customControllerFormKey = GlobalKey<FormState>();

  void _scrollTo(double target) {
    _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToDropdownField(int index) {
    double targetPosition = 100 +
        (index *
            (60 + 16)); // Assuming each dropdown is 60px tall with 16px spacing
    if (_scrollController.position.pixels != targetPosition) {
      _scrollTo(targetPosition);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: TextString.createEnquiry,
      showBackButton: true,
      body: Column(
        children: [
          StepperHeader(
            currentStep: _controller.currentStep,
            onStepReached: () {},
            steps: _controller.formSteps,
          ),
          Obx(() {
            return _controller.currentStep == 0
                ? _buildDropdownForm()
                : _buildCustomerDetailsForm();
          }),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildDropdownForm() {
    return Expanded(
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdownField(
                  index: 1,
                  label: TextString.selectCategory,
                  items: _controller.categories,
                  onSuggestionSelected: (category) {
                    _controller.selectedCategory.value = category;
                  },
                  scrollTop: () {},
                  validationLabel: 'category'),
              const SizedBox(height: 16),
              _buildDropdownField(
                  index: 2,
                  label: TextString.selectBrand,
                  items: _controller.brands,
                  onSuggestionSelected: (brand) {
                    _controller.selectedBrand.value = brand;
                  },
                  scrollTop: () {
                    _scrollToDropdownField(1);
                  },
                  validationLabel: 'brand'),
              const SizedBox(height: 16),
              _buildDropdownField(
                  index: 3,
                  label: TextString.selectProduct,
                  items: _controller.products,
                  onSuggestionSelected: (product) {
                    _controller.selectedProduct.value = product;
                  },
                  scrollTop: () {
                    _scrollToDropdownField(2);
                  },
                  validationLabel: 'product'),
              const SizedBox(height: 16),
              _buildDropdownField(
                  index: 4,
                  label: TextString.selectModal,
                  items: _controller.locations,
                  onSuggestionSelected: (location) {
                    _controller.selectedLocation.value = location;
                  },
                  scrollTop: () {
                    _scrollToDropdownField(3);
                  },
                  validationLabel: 'modal'),
              const SizedBox(height: 16),
              _buildAddProductButton(),
              const SizedBox(height: 16),
              _buildProductCard(),
              _buildProductCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomerDetailsForm() {
    return Form(
      key: customControllerFormKey,
      child: CustomerDetailsForm(),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the container
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            offset: Offset(0, -3), // Shift shadow upwards
            blurRadius: 6, // Shadow blur radius
            spreadRadius: 0, // How much the shadow should spread
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          _buildBackButton(),
          const SizedBox(width: 10),
          _buildNextOrSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return Obx(() {
      if (_controller.currentStep.value > 0) {
        return Expanded(
          child: ElevatedButton(
            onPressed: () {
              _controller.goBackOrNext(true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.lightGrey,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CustomIcons.backArrow, color: CustomColors.purpleColor),
                const SizedBox(width: 8),
                Text(TextString.back,
                    style: TextStyle(
                        fontSize: 16, color: CustomColors.purpleColor)),
              ],
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }

  Widget _buildNextOrSubmitButton() {
    return Obx(() {
      return Expanded(
        child: ElevatedButton(
          onPressed: () {
            if (_controller.currentStep.value <
                _controller.formSteps.length - 1) {
              _controller.goBackOrNext(false);
            } else {
              if (customControllerFormKey.currentState!.validate()) {
                _controller.submitForm();
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.selectionColor,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _controller.currentStep.value < _controller.formSteps.length - 1
                    ? TextString.next
                    : TextString.submit,
                style: const TextStyle(fontSize: 16, color: CustomColors.white),
              ),
              const SizedBox(width: 8),
              (_controller.currentStep.value < _controller.formSteps.length - 1)
                  ? const Icon(CustomIcons.rightArrow,
                      size: 16, color: CustomColors.white)
                  : Container()
            ],
          ),
        ),
      );
    });
  }

  Widget _buildDropdownField(
      {required int index,
      required String label,
      required RxList<String> items,
      required onSuggestionSelected,
      required scrollTop,
      required validationLabel}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
                color: CustomColors.unSelectionColor,
                fontSize: 16,
                fontWeight: FontWeight.w400),
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(color: CustomColors.selectionColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        CommonDropdownMenu(
            label: label,
            items: items,
            onSelected: onSuggestionSelected,
            selectedValue: RxString(''),
            scrollTop: scrollTop,
            validationLabel: validationLabel // Make sure to set a default value
            ),
      ],
    );
  }

  Widget _buildAddProductButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton.icon(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _controller.addProduct(
              _controller.selectedCategory.value,
              _controller.selectedBrand.value,
              _controller.selectedProduct.value,
            );
            _scrollTo(_scrollController.position
                .maxScrollExtent); // Scroll to bottom after adding product
          }
        },
        icon: const Icon(Icons.add, color: CustomColors.white),
        label: const Text(
          TextString.addProduct,
          style: TextStyle(color: CustomColors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomColors.selectionColor,
        ),
      ),
    );
  }

  Widget _buildProductCard() {
    return Card(
      color: CustomColors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    "Category",
                    style: TextStyle(
                      color: CustomColors.grey,
                    ),
                  ),
                ),
                Text(
                  "Mobiles",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    "Brand",
                    style: TextStyle(
                      color: CustomColors.grey,
                    ),
                  ),
                ),
                Text(
                  "Mobiles",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    "Product",
                    style: TextStyle(
                      color: CustomColors.grey,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    "Mobiles ",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    "Model",
                    style: TextStyle(
                      color: CustomColors.grey,
                    ),
                  ),
                ),
                Text(
                  "Mobiles",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            )
          ])),
    );
  }

  Widget _buildGridItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CustomColors.darkGrey,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: CustomColors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
