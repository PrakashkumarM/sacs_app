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
      IconData(0xf0b0, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData search =
      IconData(0xe809, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData taskList =
      IconData(0xe80e, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData backArrow =
      IconData(0xe812, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData target =
      IconData(0xe813, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData medal =
      IconData(0xe814, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData notifcation =
      IconData(0xe815, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData salesmanEnquiry =
      IconData(0xe816, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData tablerMessage =
      IconData(0xe817, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData user =
      IconData(0xe81a, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData editPencil =
      IconData(0xe819, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData trash =
      IconData(0xe81b, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData refreshWithTick =
      IconData(0xe81c, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData gallery =
      IconData(0xe81d, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData calendar =
      IconData(0xe81f, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData close =
      IconData(0xe820, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData truckDelivery =
      IconData(0xe821, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData rupeeBag =
      IconData(0xe822, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData call =
      IconData(0xe824, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData rightArrow =
      IconData(0xe823, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData truck =
      IconData(0xe825, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData refreshWait =
      IconData(0xe826, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData downArrow =
      IconData(0xe827, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData invoice =
      IconData(0xe82a, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData calendarInput =
      IconData(0xe828, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData rupee =
      IconData(0xe829, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  // Icon mapping
  static const Map<String, IconData> _iconMap = {
    'home': home,
    'enquiry': enquiry,
    'sale': sale,
    'salesIcon': salesIcon,
    'customerIcon': customerIcon,
    'enquiryIcon': enquiryIcon,
    'paymentsIcon': paymentsIcon,
    'salesListIcon': salesListIcon,
    'search': search,
    'filter': filter,
    'taskList': taskList,
    'backArrow': backArrow,
    'target': target,
    'medal': medal,
    'notifcation': notifcation,
    'salesmanEnquiry': salesmanEnquiry,
    'tablerMessage': tablerMessage,
    'user': user,
    'editPencil': editPencil,
    'trash': trash,
    'refreshWithTick': refreshWithTick,
    'gallery': gallery,
    'calendar': calendar,
    'close': close,
    'truckDelivery': truckDelivery,
    'rupeeBag': rupeeBag,
    'call': call,
    'rightArrow': rightArrow,
    'truck': truck,
    'refreshWait': refreshWait,
    'downArrow': downArrow,
    'calendarInput': calendarInput,
    'rupee': rupee,
    'invoice': invoice
  };

  // Method to get IconData from icon name
  static IconData getIconData(String iconName) {
    return _iconMap[iconName] ?? home; // Default icon if not found
  }
}
