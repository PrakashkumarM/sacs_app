import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sacs_app/app/core/values/text_string.dart';

class GlobalHelper {
  static Future<void> makePhoneCall(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw '${TextString.cldNotLaunch} $url';
    }
  }

  static textFocusLoss(context) {
    FocusScope.of(context).unfocus();
  }

  static String capitalize(String input) {
    if (input.isEmpty) return input;
    return '${input[0].toUpperCase()}${input.substring(1).toLowerCase()}';
  }
}