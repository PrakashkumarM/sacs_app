import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/core/utils/screen_utils.dart';
import 'package:sacs_app/app/core/values/colors.dart';

import 'package:sacs_app/app/screens/splash/controller.dart';
import 'package:sacs_app/app/screens/splash/widgets/app_logo.dart';
import 'package:sacs_app/app/screens/splash/widgets/appliances_logo.dart';
import 'package:sacs_app/app/screens/splash/widgets/background_image.dart';
import 'package:sacs_app/app/screens/splash/widgets/company_name.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    // Set status bar to transparent
    ScreenUtils.setStatusBarColor(
      color: Colors.transparent,
      iconBrightness: Brightness.light,
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              CustomColors.darkLinearColorStart,
              CustomColors.darkLinearColorEnd
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // Background image part
            const BackgroundImage(),

            // Sacs logo part
            const AppLogo(),

            // Bottom Image with company text part
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      // Product logo part
                      AppliancesLogo(),

                      // Company name part
                      CompanyName(),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
