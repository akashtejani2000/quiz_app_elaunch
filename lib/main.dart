import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_elaunch/routs/app_routs.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Quiz App",
      initialRoute: AppRoute.splashScreen,
      getPages: AppRoute.routList,
    );
  }
}
