import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedLocation = 'Madurai'.obs;

  final List<String> locations = [
    'Madurai',
    'Chennai',
    'Coimbatore',
    'Trichy',
  ];

  void updateLocation(String newLocation) {
    selectedLocation.value = newLocation;
  }
}
