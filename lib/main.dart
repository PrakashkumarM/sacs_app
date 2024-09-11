import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/core/utils/api_service.dart';
import 'package:sacs_app/app/data/controllers/user_controller.dart';
import 'package:sacs_app/app/screens/dashboard/binding.dart';
import 'package:sacs_app/app/screens/dashboard/view.dart';
import 'package:sacs_app/app/screens/login/view.dart';
import 'package:sacs_app/app/screens/splash/view.dart';

void main() {
  Get.put(ApiService());
  Get.put(UserController()); // Register UserController globally

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Keyboard unfocus
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        // Remove debug tag
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Roboto'),
        initialRoute: '/splash',
        getPages: [
          GetPage(
              name: '/splash',
              page: () => SplashScreen(),
              binding: BindingsBuilder(() {
                // Get.lazyPut(() => UserController());
              })),
          GetPage(name: '/login', page: () => LoginScreen()),
          GetPage(
            name: '/dashboard',
            page: () => Dashboard(),
            binding: BindingsBuilder(() {
              DashboardBinding().dependencies();
            }),
          ),
        ],
      ),
    );
  }
}
