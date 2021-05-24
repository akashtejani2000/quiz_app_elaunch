import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_elaunch/routs/app_routs.dart';
import 'package:quize_app_elaunch/screen/quiz_page/quiz_page_controller.dart';
import 'package:scratcher/widgets.dart';

class ResultPageController extends GetxController {
  final scratchKey = GlobalKey<ScratcherState>();
  ConfettiController controller;

  final QuizPageController quizPage = Get.put(QuizPageController());

  @override
  void onInit() {
    super.onInit();
    controller = new ConfettiController(
      duration: new Duration(seconds: 2),
    );
  }

  reSetGame() async {
    quizPage.time?.cancel();
    quizPage.disableAnswer.value = true;
    quizPage.wrongAns.value = 0;
    quizPage.rightAns.value = 0;
    quizPage.currentQuestion.value = 0;
    quizPage.optionMenu.add(
      OptionMenu(color: Colors.indigo, title: quizPage.quizData[quizPage.currentQuestion.value].option1),
    );
    quizPage.optionMenu.add(
      OptionMenu(color: Colors.indigo, title: quizPage.quizData[quizPage.currentQuestion.value].option2),
    );
    quizPage.optionMenu.add(
      OptionMenu(color: Colors.indigo, title: quizPage.quizData[quizPage.currentQuestion.value].option3),
    );
    quizPage.optionMenu.add(
      OptionMenu(color: Colors.indigo, title: quizPage.quizData[quizPage.currentQuestion.value].option4),
    );
    Get.toNamed(AppRoute.quizPage);
    quizPage.startTimer();
  }
}
