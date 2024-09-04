import 'package:flutter/material.dart';
import 'package:sacs_app/app/core/values/text_string.dart';

class CompanyName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: 20, // Adjust bottom padding
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          TextString.companyBrandText,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
