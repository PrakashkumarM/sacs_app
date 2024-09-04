import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/screens/home/contoller.dart';
import 'package:sacs_app/app/screens/home/widgets/appbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      appBar: CommonAppBar(
        selectedValue: homeController.selectedLocation,
        locations: homeController.locations,
        updateLocation: (newLocation) =>
            homeController.updateLocation(newLocation),
      ),
    );
  }
}
