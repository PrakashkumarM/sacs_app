import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/screens/login/controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.loginController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final LoginController loginController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  TextString.sacsLogoPath, // SACS logo path
                  height: 75, // Adjust height as needed
                ),
              ),

              SizedBox(height: 35), // Space between logo and title

              // Login Title aligned to the left
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  TextString.loginHeader,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              SizedBox(height: 20), // Space between title and form fields

              // Username Label and Field
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  TextString.userNamePlaceholder,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 8), // Space between label and input field
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: loginController
                    .emailController, // Bind controller to input field
                decoration: InputDecoration(
                  hintText: TextString.userNameHintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: loginController.validateEmail,
              ),

              SizedBox(height: 20), // Space between fields

              // Password Label and Field
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  TextString.password,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 8), // Space between label and input field
              Obx(
                () => TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: loginController
                      .passwordController, // Bind controller to input field
                  obscureText: loginController.obscureText.value,
                  decoration: InputDecoration(
                    errorMaxLines: 2,
                    hintText: TextString.passwordHintText,
                    suffixIcon: IconButton(
                      icon: Icon(
                        loginController.obscureText.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: loginController.togglePasswordVisibility,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: loginController.validatePassword,
                ),
              ),

              SizedBox(height: 20), // Space between fields and button

              // Login Button
              Container(
                width: double.infinity, // Full width of the parent container
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Pass the email and password to the formSubmit function
                      loginController.formSubmit(
                        loginController.emailController.text,
                        loginController.passwordController.text,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: CustomColors.selectionColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ), // Set your button color
                  ),
                  child: Text(
                    TextString.loginButtonText,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
