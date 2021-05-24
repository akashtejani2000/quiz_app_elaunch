import 'package:get/get_navigation/get_navigation.dart';
import 'package:quize_app_elaunch/screen/quiz_page/quiz_page.dart';
import 'package:quize_app_elaunch/screen/result_page/result_page.dart';

class AppRoute {
  AppRoute._();

  static const quizPage = '/quizPage';
  static const resultPage = '/resultPage';

  static var routList = [
    GetPage(name: quizPage, page: () => QuizPage()),
    GetPage(name: resultPage, page: () => ResultPage()),
  ];
}
