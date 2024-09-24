import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/common/widgets/rounded_image.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/data/services/image_picker_service.dart';
import 'package:sacs_app/app/screens/profile/controller.dart';

class ProfileScreen extends StatelessWidget {
  final ImagePickerService _imagePickerService = ImagePickerService();
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: TextString.editProfile,
      showBackButton: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // Profile Image
            Center(
              child: Stack(
                children: [
                  Obx(() {
                    return RoundedImage(
                      backgroundImageUrl:
                          profileController.profileImagePath.value,
                      radius: 50,
                    );
                  }),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => _imagePickerService.showImageSourceDialog(
                          context,
                          profileController.updateImage), // Show dialog on tap
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CustomColors.error,
                        ),
                        child: Icon(
                          CustomIcons.editPencil,
                          color: CustomColors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Full Name Label & Field
            Text(
              TextString.fullName,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: CustomColors.unSelectionColor),
            ),
            SizedBox(height: 8), // Space between label and input
            TextField(
              decoration: InputDecoration(
                hintText: 'John Mathew',
                hintStyle: TextStyle(
                    color: CustomColors.placeholderGrey,
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: CustomColors.borderGrey,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: CustomColors.borderGrey,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: CustomColors.borderGrey,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),

            SizedBox(height: 16),

            // Email Label & Field
            Text(
              TextString.email,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: CustomColors.unSelectionColor),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'mathew@gmail.com',
                hintStyle: TextStyle(
                    color: CustomColors.placeholderGrey,
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: CustomColors.borderGrey,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: CustomColors.borderGrey,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: CustomColors.borderGrey,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            SizedBox(height: 16),

            // Password Label & Field
            Text(
              TextString.password,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: CustomColors.unSelectionColor),
            ),
            SizedBox(height: 8),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: '••••••••',
                hintStyle: TextStyle(
                    color: CustomColors.placeholderGrey,
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: CustomColors.borderGrey,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: CustomColors.borderGrey,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: CustomColors.borderGrey,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                suffixIcon: Icon(
                  Icons.visibility,
                  color: CustomColors.placeholderGrey,
                ),
              ),
            ),
            SizedBox(height: 32),

            // Buttons Row (Cancel and Save Changes)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Cancel Button
                SizedBox(
                  width: 80, // Adjust width as per your requirement
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.lightGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 12), // Adjust vertical padding
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      TextString.cancel,
                      style: TextStyle(color: CustomColors.black),
                    ),
                  ),
                ),
                SizedBox(width: 8), // Space between buttons
                // Save Changes Button
                SizedBox(
                  width: 130, // Adjust width as per your requirement
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.error,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 12), // Adjust vertical padding
                    ),
                    onPressed: () {
                      // Handle save action
                    },
                    child: Text(
                      TextString.saveChanges,
                      style: TextStyle(color: CustomColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
