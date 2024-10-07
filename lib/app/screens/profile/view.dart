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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: TextString.editProfile,
      showBackButton: true,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Common padding for the form
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                _buildProfileImage(),
                SizedBox(height: 20),
                _buildTextField(
                  label: TextString.fullName,
                  hintText: 'John Mathew',
                  controller: profileController.nameController,
                  validator: profileController.validateName,
                ),
                SizedBox(height: 16),
                _buildTextField(
                  label: TextString.email,
                  hintText: 'mathew@gmail.com',
                  controller: profileController.emailController,
                  validator: profileController.validateEmail,
                ),
                SizedBox(height: 16),
                _buildPasswordField(),
                SizedBox(height: 32),
                _buildButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Stack(
        children: [
          Obx(() {
            return RoundedImage(
              backgroundImageUrl: profileController.profileImagePath.value,
              radius: 50,
            );
          }),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => _imagePickerService.showImageSourceDialog(
                  Get.context!, profileController.updateImage),
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
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: CustomColors.unSelectionColor,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: _inputDecoration(hintText),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TextString.password,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: CustomColors.unSelectionColor,
          ),
        ),
        SizedBox(height: 8),
        Obx(() => TextFormField(
              controller: profileController.passwordController,
              obscureText: profileController.obscureText.value,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: _inputDecoration('••••••••').copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    profileController.obscureText.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: CustomColors.placeholderGrey,
                  ),
                  onPressed: profileController.togglePasswordVisibility,
                ),
              ),
              validator: profileController.validatePassword,
            )),
      ],
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: CustomColors.placeholderGrey,
        fontWeight: FontWeight.w400,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: CustomColors.borderGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: CustomColors.borderGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: CustomColors.borderGrey),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButton(
          label: TextString.cancel,
          color: CustomColors.lightGrey,
          textColor: CustomColors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        SizedBox(width: 8),
        _buildButton(
          label: TextString.saveChanges,
          color: CustomColors.error,
          textColor: CustomColors.white,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              profileController.formSubmit(
                profileController.nameController.text,
                profileController.emailController.text,
                profileController.passwordController.text,
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 130,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 8),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
