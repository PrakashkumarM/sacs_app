import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakeSalesController extends GetxController {
  var selectedDate = Rxn<DateTime>();
  var chargeController = TextEditingController(text: '1100');

  void setDate(DateTime date) {
    selectedDate.value = date;
  }
}
