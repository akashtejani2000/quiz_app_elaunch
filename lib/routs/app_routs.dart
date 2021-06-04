import 'package:get/get_navigation/get_navigation.dart';
import 'package:quize_app_elaunch/screen/dynamic_quiz_page/dynamic_quiz.dart';
import 'package:quize_app_elaunch/screen/quiz_level_page/quiz_level_page.dart';
import 'package:quize_app_elaunch/screen/result_page/result_page.dart';
import 'package:quize_app_elaunch/screen/splesh_screen/splash_screen.dart';

class AppRoute {
  AppRoute._();

  static const splashScreen = '/splashScreen';
  static const quizLevelScreen = '/quizLevelScreen';
  static const dynamicQuizPage = '/dynamicQuizPage';
  static const resultPage = '/resultPage';

  static var routList = [
    GetPage(name: splashScreen, page: () => Splash()),
    GetPage(name: quizLevelScreen, page: () => QuizLevel()),
    GetPage(name: dynamicQuizPage, page: () => DynamicQuiz()),
    GetPage(name: resultPage, page: () => ResultPage()),
  ];
}
