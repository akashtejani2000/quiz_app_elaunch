import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_elaunch/screen/quiz_page/quiz_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Quiz App",
      home: QuizPage(),
    );
  }
}
