import 'package:flutter/widgets.dart';

class CustomIcons {
  CustomIcons._();

  static const _kFontFam = 'CustomIcons';
  static const String? _kFontPkg = null;

  static const IconData home =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData enquiry =
      IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData sale =
      IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  // Method to get IconData from icon name
  static IconData getIconData(String iconName) {
    switch (iconName) {
      case 'home':
        return home;
      case 'enquiry':
        return enquiry;
      case 'sale':
        return sale;
      // Add more cases as needed
      default:
        return home; // Default icon
    }
  }
}
