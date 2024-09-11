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
  static const IconData paymentsIcon =
      IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData salesIcon =
      IconData(0xe804, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData enquiryIcon =
      IconData(0xe805, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData customerIcon =
      IconData(0xe806, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData salesListIcon =
      IconData(0xe80e, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData filter =
      IconData(0xe80f, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData search =
      IconData(0xe810, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  // Method to get IconData from icon name
  static IconData getIconData(String iconName) {
    switch (iconName) {
      case 'home':
        return home;
      case 'enquiry':
        return enquiry;
      case 'sale':
        return sale;
      case 'salesIcon':
        return salesIcon;
      case 'customerIcon':
        return customerIcon;
      case 'enquiryIcon':
        return enquiryIcon;
      case 'paymentsIcon':
        return paymentsIcon;
      case 'salesListIcon':
        return salesListIcon;
      case 'search':
        return search;
      case 'filter':
        return filter;
      // Add more cases as needed
      default:
        return home; // Default icon
    }
  }
}
