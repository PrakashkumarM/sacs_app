import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/core/utils/screen_utils.dart';

import 'package:sacs_app/app/screens/login/controller.dart';
import 'package:sacs_app/app/screens/login/widgets/bottom_logo.dart';
import 'package:sacs_app/app/screens/login/widgets/login_form.dart';
import 'package:sacs_app/app/screens/login/widgets/top_logo.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    ScreenUtils.setStatusBarColor(
      color: Colors.transparent,
      iconBrightness: Brightness.dark,
    );

    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Adjust the screen when the keyboard opens
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // Top-left logo
              TopLogo(),

              // Bottom-right logo
              BottomLogo(),

              // Center form
              LoginForm(formKey: _formKey, loginController: loginController),
            ],
          ),
        ),
      ),
    );
  }
}
