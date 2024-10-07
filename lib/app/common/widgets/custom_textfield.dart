import 'package:flutter/material.dart';
import 'package:sacs_app/app/core/values/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isMultiline;
  final bool isRequired;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.isMultiline = false,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: CustomColors.unSelectionColor, // Custom color
              ),
              children: [
                TextSpan(text: label),
                if (isRequired)
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                        color: CustomColors
                            .selectionColor), // Required asterisk color
                  ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: isMultiline ? 3 : 1,
            decoration: InputDecoration(
              hintText: 'Enter $label',
              hintStyle: TextStyle(
                color: CustomColors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
            validator: (value) {
              if (isRequired && (value == null || value.isEmpty)) {
                return 'Please enter $label';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
