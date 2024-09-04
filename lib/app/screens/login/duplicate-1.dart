import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/screens/login/controller.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Adjust the screen when the keyboard opens
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // Top-left logo
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/top_frame.png', // Replace with your logo asset
                  height: 135.0,
                ),
              ),

              // Bottom-right logo
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  'assets/images/bottom_frame.png', // Replace with your logo asset
                  height: 135.0,
                ),
              ),

              // Center form
              Form(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/sacs_logo.png', // SACS logo path
                            height: 75, // Adjust height as needed
                          ),
                        ),

                        SizedBox(height: 35), // Space between logo and title

                        // Login Title aligned to the left
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Login Now',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(
                            height: 20), // Space between title and form fields

                        // Username Label and Field
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Username',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                            height: 8), // Space between label and input field
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'mathew@gmail.com',
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
                            'Password',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                            height: 8), // Space between label and input field
                        Obx(
                          () => TextFormField(
                            obscureText: loginController.obscureText.value,
                            decoration: InputDecoration(
                              errorMaxLines: 2,
                              hintText: 'Enter Your Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  loginController.obscureText.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed:
                                    loginController.togglePasswordVisibility,
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
                          width: double
                              .infinity, // Full width of the parent container
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Perform login action
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ), // Set your button color
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
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
