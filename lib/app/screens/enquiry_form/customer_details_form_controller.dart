import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDetailsFormController extends GetxController {
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController primaryAddressController = TextEditingController();
  final TextEditingController secondaryAddressController =
      TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController referenceMobileController =
      TextEditingController();
  final TextEditingController referenceNameController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  var useCustomerPhone = false.obs;

  var clientPurchaseDate = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();
  }

  void setDate(DateTime date) {
    clientPurchaseDate.value = date;
  }

  // Validation method
  bool validate() {
    return mobileNumberController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        primaryAddressController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        stateController.text.isNotEmpty &&
        pinCodeController.text.isNotEmpty;
  }

  @override
  void onClose() {
    mobileNumberController.dispose();
    nameController.dispose();
    primaryAddressController.dispose();
    secondaryAddressController.dispose();
    cityController.dispose();
    stateController.dispose();
    pinCodeController.dispose();
    referenceMobileController.dispose();
    referenceNameController.dispose();
    remarksController.dispose();
    super.onClose();
  }
}
