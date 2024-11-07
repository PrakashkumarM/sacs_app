import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/common/widgets/stepper_header.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/screens/enquiry_form/customer_details_form_controller.dart';
import 'package:sacs_app/app/screens/enquiry_form/widgets/customer_details_form.dart';
import 'package:sacs_app/app/screens/sale_form/controller.dart';
import 'package:sacs_app/app/screens/sale_form/widgets/invoice_number_form.dart';
import 'package:sacs_app/app/screens/sale_form/widgets/product_details_form.dart';

class CreateSales extends StatelessWidget {
  final CreateSalesFormController _controller =
      Get.put(CreateSalesFormController());
  final GlobalKey _stepperHeaderKey = GlobalKey();
  final customControllerFormKey = GlobalKey<FormState>();
  final invoiceformKey = GlobalKey<FormState>();

  final customerDetailsFormController =
      Get.put(CustomerDetailsFormController());

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: TextString.createNewSales,
      showBackButton: true,
      body: Column(
        children: [
          StepperHeader(
            key: _stepperHeaderKey,
            currentStep: _controller.currentStep,
            onStepReached: () {},
            steps: _controller.formSteps,
          ),
          Obx(() => _buildFormStep()),
          _buildStepButtonRow(),
        ],
      ),
    );
  }

  Widget _buildFormStep() {
    switch (_controller.currentStep.value) {
      case 0:
        return ProductDetailsForm();
      case 1:
        return Form(
          key: customControllerFormKey,
          child: CustomerDetailsForm(),
        );
      case 2:
        return Expanded(
          child: Form(key: invoiceformKey, child: InvoiceForm()),
        );
      default:
        return Container();
    }
  }

  Widget _buildStepButtonRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Obx(() => _controller.currentStep.value > 0
                ? Expanded(
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
                          Icon(CustomIcons.backArrow,
                              color: CustomColors.purpleColor),
                          const SizedBox(width: 8),
                          Text(TextString.back,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: CustomColors.purpleColor)),
                        ],
                      ),
                    ),
                  )
                : SizedBox.shrink()),
            const SizedBox(width: 10),
            Obx(() => _buildStepButton(
                  label: _controller.currentStep.value <
                          _controller.formSteps.length - 1
                      ? TextString.next
                      : TextString.submit,
                  icon: _controller.currentStep.value <
                          _controller.formSteps.length - 1
                      ? CustomIcons.rightArrow
                      : null,
                  color: CustomColors.white,
                  backgroundColor: CustomColors.selectionColor,
                  onPressed: _handleStepButton,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildStepButton({
    required String label,
    IconData? icon,
    required Color color,
    Color? backgroundColor,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? CustomColors.lightGrey,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: TextStyle(fontSize: 16, color: color)),
            if (icon != null) ...[
              const SizedBox(width: 8),
              Icon(icon, size: 16, color: color),
            ],
          ],
        ),
      ),
    );
  }

  void _handleStepButton() {
    if (_controller.currentStep.value < _controller.formSteps.length - 1) {
      if (_controller.currentStep.value == 1 &&
          customControllerFormKey.currentState!.validate()) {
        _controller.goBackOrNext(false);
      } else if (_controller.currentStep.value == 0) {
        _controller.goBackOrNext(false);
      }
    } else if (_controller.currentStep.value == 2 &&
        invoiceformKey.currentState!.validate()) {
      _controller.submitForm();
      _controller.currentStep.value = 0;
      customControllerFormKey.currentState?.reset();
      invoiceformKey.currentState?.reset();
    }
  }
}
