import 'package:flutter/material.dart';

import 'package:sacs_app/app/core/values/colors.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final List<TextSpan> message; // Accept a List of TextSpan for dynamic styling
  final String confirmText;
  final String cancelText;
  final VoidCallback onCancel;
  final Function(String) onConfirm; // Update to accept a String parameter
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // New parameters for hint text, label text, and boolean for showing the field
  final String hintText;
  final String labelText;
  final bool showField;

  final TextEditingController feedbackController =
      TextEditingController(); // Controller for TextFormField

  ConfirmationDialog({
    Key? key,
    required this.title,
    required this.message, // Updated to List<TextSpan>
    required this.confirmText,
    this.cancelText = '',
    required this.onConfirm,
    required this.onCancel,
    this.hintText = '',
    this.labelText = '',
    this.showField = false, // Default to false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AlertDialog(
          backgroundColor: CustomColors.white,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          contentPadding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titlePadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0), // Reduced top padding
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 24), // Placeholder for spacing
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 30,
                        color: CustomColors.darkGrey,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          content: Form(
            key: formKey,
            child: SizedBox(
              width: constraints.maxWidth * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start, // Center content
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: message, // Use the dynamic TextSpan list
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  if (showField) ...[
                    RichText(
                      text: TextSpan(
                        text: '$labelText ',
                        style:
                            TextStyle(color: CustomColors.black, fontSize: 16),
                        children: [
                          TextSpan(
                            text: '*',
                            style: TextStyle(color: CustomColors.darkRedText),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    // Add TextFormField for feedback
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: feedbackController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: CustomColors.borderGrey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: CustomColors.borderGrey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: CustomColors.borderGrey),
                          ),
                          hintText: hintText,
                          hintStyle: TextStyle(color: CustomColors.grey)),
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Reason is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ],
              ),
            ),
          ),
          actionsPadding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  // Reduce confirm button width
                  width: 140, // Adjust width as needed
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Implement close logic here
                        onConfirm(feedbackController.text);
                      }
                      // Call onConfirm with the text from the TextFormField
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.selectionColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Center(
                      // Center the text
                      child: Text(
                        confirmText,
                        style: const TextStyle(color: CustomColors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                if (cancelText.isNotEmpty)
                  SizedBox(
                    // Wrap in SizedBox to control width
                    width: 100, // Adjust width as needed
                    child: ElevatedButton(
                      onPressed: onCancel,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.lightGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Center(
                        // Center the text
                        child: Text(cancelText,
                            style: TextStyle(color: CustomColors.purpleColor)),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
